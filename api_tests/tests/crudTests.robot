*** Settings ***
Documentation    ✏️ CRUD Tests - Pruebas completas de operaciones Create, Read, Update, Delete
...              
...              Tests de ciclo de vida completo de objetos en la API.
...              Verifica todas las operaciones CRUD de forma individual y en flujo completo.
...              
...              Tests incluidos:
...              - Create (POST)
...              - Read (GET) 
...              - Update Complete (PUT)
...              - Update Partial (PATCH)
...              - Delete (DELETE)
...              - Full CRUD Workflow E2E

Resource         ../config/base.robot
Resource         ../config/helpers.robot
Resource         ../data/testData.robot
Resource         ../data/variables.robot

Suite Setup      Setup API Test Suite
Suite Teardown   Teardown API Test Suite
Test Setup       Setup API Test Case
Test Teardown    Teardown API Test Case

Default Tags     crud    integration

*** Variables ***
${CREATED_OBJECT_ID}    ${EMPTY}

*** Test Cases ***
Create New Object With POST
    [Documentation]    ✅ Crea un nuevo objeto usando POST /objects
    ...                
    ...                Valida:
    ...                - Status 200 (API retorna 200 en lugar de 201)
    ...                - Response contiene el objeto creado
    ...                - Objeto tiene ID asignado
    ...                - Datos enviados coinciden con recibidos
    [Tags]    @{TAGS_CRUD}    create    post    p0
    
    Log    ➕ Creando nuevo objeto    console=${TRUE}
    
    # Preparar datos
    ${unique_name}=    Generate Unique Name    ${OBJECT_NAME_PHONE}
    ${body}=    Create Object Body    ${unique_name}    ${DATA_IPHONE_15}
    
    # Crear objeto
    ${response}=    POST Request    ${ENDPOINT_OBJECTS}    ${body}
    
    # Validaciones
    Validate Status Code    ${response}    ${HTTP_200_OK}
    Validate Response Is Dictionary    ${response}
    
    # Validar estructura del objeto creado
    ${json}=    Set Variable    ${response.json()}
    Validate Dictionary Has Keys    ${json}    id    name    data
    Validate Field Not Empty    ${json}    id
    Validate Field Value    ${json}    name    ${unique_name}
    
    # Guardar ID para cleanup
    ${object_id}=    Extract Object ID    ${response}
    Set Suite Variable    ${CREATED_OBJECT_ID}    ${object_id}
    
    Log    ✅ Objeto creado con ID: ${object_id}    console=${TRUE}
    
    [Teardown]    Run Keywords
    ...    Teardown API Test Case
    ...    AND    Cleanup Test Objects    ${CREATED_OBJECT_ID}

Read Object With GET
    [Documentation]    ✅ Lee un objeto específico usando GET /objects/{id}
    ...                
    ...                Valida:
    ...                - Status 200
    ...                - Objeto existe
    ...                - Estructura completa
    ...                - Campos requeridos presentes
    [Tags]    @{TAGS_CRUD}    read    get    p0
    
    Log    📖 Leyendo objeto ID: ${OBJECT_ID_2}    console=${TRUE}
    
    # Leer objeto
    ${endpoint}=    Set Variable    ${ENDPOINT_OBJECTS}/${OBJECT_ID_2}
    ${response}=    GET Request    ${endpoint}
    
    # Validaciones
    Validate Status Code    ${response}    ${HTTP_200_OK}
    Validate Response Is Dictionary    ${response}
    
    # Validar estructura
    ${json}=    Set Variable    ${response.json()}
    Validate Dictionary Has Keys    ${json}    id    name    data
    Validate Field Value    ${json}    id    ${OBJECT_ID_2}
    Validate Field Value    ${json}    name    ${EXPECTED_NAME_ID_2}
    
    Log    ✅ Objeto leído correctamente    console=${TRUE}

Update Object Complete With PUT
    [Documentation]    ✅ Actualiza un objeto completamente usando PUT /objects/{id}
    ...                
    ...                PUT reemplaza el objeto completo con los nuevos datos
    ...                
    ...                Valida:
    ...                - Status 200
    ...                - Datos actualizados correctamente
    ...                - Campos modificados reflejan cambios
    [Tags]    @{TAGS_CRUD}    update    put    p0
    
    Log    🔄 Actualizando objeto con PUT    console=${TRUE}
    
    # Paso 1: Crear objeto para actualizar
    ${unique_name}=    Generate Unique Name    ${OBJECT_NAME_LAPTOP}
    ${body_create}=    Create Object Body    ${unique_name}    ${DATA_MACBOOK_PRO}
    ${response_create}=    POST Request    ${ENDPOINT_OBJECTS}    ${body_create}
    ${object_id}=    Extract Object ID    ${response_create}
    
    Log    📝 Objeto creado con ID ${object_id}, procediendo a actualizar    console=${TRUE}
    
    # Paso 2: Actualizar objeto completo (PUT)
    ${updated_name}=    Set Variable    ${unique_name} - Updated
    ${updated_data}=    Create Object With Data    price=2999.99    color=Silver    RAM=64 GB
    ${body_update}=    Create Object Body    ${updated_name}    ${updated_data}
    
    ${endpoint}=    Set Variable    ${ENDPOINT_OBJECTS}/${object_id}
    ${response_update}=    PUT Request    ${endpoint}    ${body_update}
    
    # Validaciones
    Validate Status Code    ${response_update}    ${HTTP_200_OK}
    ${json}=    Set Variable    ${response_update.json()}
    Validate Field Value    ${json}    id    ${object_id}
    Validate Field Value    ${json}    name    ${updated_name}
    
    # Validar que data fue actualizada
    ${data_updated}=    Get From Dictionary    ${json}    data
    Should Not Be Equal    ${data_updated}    ${DATA_MACBOOK_PRO}
    
    Log    ✅ Objeto actualizado con PUT    console=${TRUE}
    
    [Teardown]    Run Keywords
    ...    Teardown API Test Case
    ...    AND    Cleanup Test Objects    ${object_id}

Update Object Partial With PATCH
    [Documentation]    ✅ Actualiza parcialmente un objeto usando PATCH /objects/{id}
    ...                
    ...                PATCH solo actualiza los campos enviados, mantiene el resto
    ...                
    ...                Valida:
    ...                - Status 200
    ...                - Solo campos especificados se actualizan
    ...                - Otros campos se mantienen intactos
    [Tags]    @{TAGS_CRUD}    update    patch    p1
    
    Log    🔧 Actualizando objeto con PATCH    console=${TRUE}
    
    # Paso 1: Crear objeto
    ${unique_name}=    Generate Unique Name    ${OBJECT_NAME_TABLET}
    ${body_create}=    Create Object Body    ${unique_name}    ${DATA_IPAD_PRO}
    ${response_create}=    POST Request    ${ENDPOINT_OBJECTS}    ${body_create}
    ${object_id}=    Extract Object ID    ${response_create}
    
    # Paso 2: Actualizar solo el precio (PATCH)
    ${patch_data}=    Create Object With Data    price=999.99
    ${body_patch}=    Create Dictionary    data=${patch_data}
    
    ${endpoint}=    Set Variable    ${ENDPOINT_OBJECTS}/${object_id}
    ${response_patch}=    PATCH Request    ${endpoint}    ${body_patch}
    
    # Validaciones
    Validate Status Code    ${response_patch}    ${HTTP_200_OK}
    ${json}=    Set Variable    ${response_patch.json()}
    
    # Validar que el precio cambió
    ${data}=    Get From Dictionary    ${json}    data
    ${price}=    Get From Dictionary    ${data}    price
    Should Be Equal As Strings    ${price}    999.99
    
    Log    ✅ Objeto actualizado parcialmente con PATCH    console=${TRUE}
    
    [Teardown]    Run Keywords
    ...    Teardown API Test Case
    ...    AND    Cleanup Test Objects    ${object_id}

Delete Object With DELETE
    [Documentation]    ✅ Elimina un objeto usando DELETE /objects/{id}
    ...                
    ...                Valida:
    ...                - Status 200 (confirmación de eliminación)
    ...                - Objeto ya no existe después de eliminar
    ...                - GET posterior retorna 404
    [Tags]    @{TAGS_CRUD}    delete    p0
    
    Log    🗑️ Eliminando objeto    console=${TRUE}
    
    # Paso 1: Crear objeto para eliminar
    ${unique_name}=    Generate Unique Name    ${OBJECT_NAME_WATCH}
    ${body}=    Create Object Body    ${unique_name}    ${DATA_APPLE_WATCH}
    ${response_create}=    POST Request    ${ENDPOINT_OBJECTS}    ${body}
    ${object_id}=    Extract Object ID    ${response_create}
    
    Log    📝 Objeto creado con ID ${object_id}, procediendo a eliminar    console=${TRUE}
    
    # Paso 2: Eliminar objeto
    ${endpoint}=    Set Variable    ${ENDPOINT_OBJECTS}/${object_id}
    ${response_delete}=    DELETE Request    ${endpoint}
    
    # Validaciones
    Validate Status Code    ${response_delete}    ${HTTP_200_OK}
    
    # Paso 3: Verificar que ya no existe
    ${response_get}=    GET Request    ${endpoint}    expected_status=${HTTP_404_NOT_FOUND}
    Validate Status Code    ${response_get}    ${HTTP_404_NOT_FOUND}
    
    Log    ✅ Objeto eliminado correctamente    console=${TRUE}

Complete CRUD Workflow End To End
    [Documentation]    🛣️ Test E2E que ejecuta el ciclo CRUD completo
    ...                
    ...                Flujo:
    ...                1. CREATE - Crear objeto con POST
    ...                2. READ - Leer objeto creado con GET
    ...                3. UPDATE - Actualizar con PUT
    ...                4. READ - Verificar cambios con GET
    ...                5. DELETE - Eliminar con DELETE
    ...                6. READ - Verificar que ya no existe (404)
    ...                
    ...                Este test valida el flujo completo de un objeto
    [Tags]    @{TAGS_CRUD}    e2e    workflow    critical    p0
    
    Log    🛣️ Iniciando flujo CRUD completo    console=${TRUE}
    Log    ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━    console=${TRUE}
    
    # ========== STEP 1: CREATE ==========
    Log    1️⃣ CREATE - Creando objeto nuevo    console=${TRUE}
    ${unique_name}=    Generate Unique Name    ${OBJECT_NAME_HEADPHONES}
    ${body_create}=    Create Object Body    ${unique_name}    ${DATA_AIRPODS_PRO}
    ${response_create}=    POST Request    ${ENDPOINT_OBJECTS}    ${body_create}
    Validate Status Code    ${response_create}    ${HTTP_200_OK}
    ${object_id}=    Extract Object ID    ${response_create}
    Log    ✅ Objeto creado con ID: ${object_id}    console=${TRUE}
    Log    ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━    console=${TRUE}
    
    # ========== STEP 2: READ ==========
    Log    2️⃣ READ - Leyendo objeto creado    console=${TRUE}
    ${endpoint}=    Set Variable    ${ENDPOINT_OBJECTS}/${object_id}
    ${response_read}=    GET Request    ${endpoint}
    Validate Status Code    ${response_read}    ${HTTP_200_OK}
    ${json_read}=    Set Variable    ${response_read.json()}
    Validate Field Value    ${json_read}    name    ${unique_name}
    Log    ✅ Objeto leído correctamente    console=${TRUE}
    Log    ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━    console=${TRUE}
    
    # ========== STEP 3: UPDATE ==========
    Log    3️⃣ UPDATE - Actualizando objeto con PUT    console=${TRUE}
    ${updated_name}=    Set Variable    ${unique_name} - Premium Edition
    ${updated_data}=    Create Object With Data    price=299.99    color=Black    noise_cancellation=${TRUE}
    ${body_update}=    Create Object Body    ${updated_name}    ${updated_data}
    ${response_update}=    PUT Request    ${endpoint}    ${body_update}
    Validate Status Code    ${response_update}    ${HTTP_200_OK}
    Log    ✅ Objeto actualizado correctamente    console=${TRUE}
    Log    ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━    console=${TRUE}
    
    # ========== STEP 4: READ AGAIN ==========
    Log    4️⃣ READ - Verificando cambios aplicados    console=${TRUE}
    ${response_read_2}=    GET Request    ${endpoint}
    Validate Status Code    ${response_read_2}    ${HTTP_200_OK}
    ${json_read_2}=    Set Variable    ${response_read_2.json()}
    Validate Field Value    ${json_read_2}    name    ${updated_name}
    Log    ✅ Cambios verificados correctamente    console=${TRUE}
    Log    ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━    console=${TRUE}
    
    # ========== STEP 5: DELETE ==========
    Log    5️⃣ DELETE - Eliminando objeto    console=${TRUE}
    ${response_delete}=    DELETE Request    ${endpoint}
    Validate Status Code    ${response_delete}    ${HTTP_200_OK}
    Log    ✅ Objeto eliminado correctamente    console=${TRUE}
    Log    ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━    console=${TRUE}
    
    # ========== STEP 6: VERIFY DELETION ==========
    Log    6️⃣ READ - Verificando que ya no existe    console=${TRUE}
    ${response_verify}=    GET Request    ${endpoint}    expected_status=${HTTP_404_NOT_FOUND}
    Validate Status Code    ${response_verify}    ${HTTP_404_NOT_FOUND}
    Log    ✅ Confirmado: objeto ya no existe (404)    console=${TRUE}
    Log    ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━    console=${TRUE}
    
    Log    🎉 Flujo CRUD E2E completado exitosamente!    console=${TRUE}

Create Multiple Objects In Batch
    [Documentation]    ✅ Crea múltiples objetos en secuencia
    ...                
    ...                Valida:
    ...                - Todos los objetos se crean correctamente
    ...                - Cada uno tiene ID único
    ...                - Performance aceptable para batch
    [Tags]    @{TAGS_CRUD}    batch    create    p1
    
    Log    📦 Creando múltiples objetos en batch    console=${TRUE}
    
    # Lista para guardar IDs creados
    @{created_ids}=    Create List
    
    # Crear 5 objetos diferentes
    FOR    ${index}    IN RANGE    1    6
        ${unique_name}=    Generate Unique Name    TestObject${index}
        ${data}=    Create Object With Data    index=${index}    timestamp=${index}
        ${body}=    Create Object Body    ${unique_name}    ${data}
        
        ${response}=    POST Request    ${ENDPOINT_OBJECTS}    ${body}
        Validate Status Code    ${response}    ${HTTP_200_OK}
        
        ${object_id}=    Extract Object ID    ${response}
        Append To List    ${created_ids}    ${object_id}
        
        Log    ✅ Objeto ${index}/5 creado con ID: ${object_id}    console=${TRUE}
    END
    
    # Validar que todos tienen IDs únicos
    ${count}=    Get Length    ${created_ids}
    Should Be Equal As Integers    ${count}    5
    
    Log    ✅ ${count} objetos creados exitosamente    console=${TRUE}
    
    [Teardown]    Run Keywords
    ...    Teardown API Test Case
    ...    AND    Cleanup Test Objects    @{created_ids}

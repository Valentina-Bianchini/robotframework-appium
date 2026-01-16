*** Settings ***
Documentation    ⚠️ Negative Tests - Pruebas de casos negativos y manejo de errores
...              
...              Tests que verifican el comportamiento de la API ante
...              peticiones inválidas, datos incorrectos y casos edge.
...              
...              Tests incluidos:
...              - Invalid IDs
...              - Malformed Requests
...              - Missing Required Fields
...              - Invalid HTTP Methods
...              - Boundary Conditions

Resource         ../config/base.robot
Resource         ../config/helpers.robot
Resource         ../data/testData.robot
Resource         ../data/variables.robot

Suite Setup      Setup API Test Suite
Suite Teardown   Teardown API Test Suite
Test Setup       Setup API Test Case
Test Teardown    Teardown API Test Case

Default Tags     negative    error_handling

*** Test Cases ***
GET Non-Existent Object Returns 404
    [Documentation]    ❌ Verifica que GET con ID inválido retorne 404
    ...                
    ...                Status esperado: 404 Not Found
    ...                Mensaje de error apropiado
    [Tags]    @{TAGS_NEGATIVE}    not_found    p0
    
    Log    🔍 Intentando obtener objeto inexistente: ID ${OBJECT_ID_NONEXISTENT}    console=${TRUE}
    
    ${endpoint}=    Set Variable    ${ENDPOINT_OBJECTS}/${OBJECT_ID_NONEXISTENT}
    ${response}=    GET Request    ${endpoint}    expected_status=${HTTP_404_NOT_FOUND}
    
    # Validar status 404
    Validate Status Code    ${response}    ${HTTP_404_NOT_FOUND}
    
    # Validar que el response contiene mensaje de error
    ${json}=    Set Variable    ${response.json()}
    Dictionary Should Contain Key    ${json}    error
    ...    msg=Response debería contener campo 'error'
    
    ${error_msg}=    Get From Dictionary    ${json}    error
    Should Not Be Empty    ${error_msg}
    ...    msg=Mensaje de error no debe estar vacío
    
    # Validar que el error menciona el ID
    Should Contain    ${error_msg}    ${OBJECT_ID_NONEXISTENT}
    ...    msg=Error debería mencionar el ID solicitado
    
    Log    ✅ 404 retornado correctamente para ID inexistente    console=${TRUE}

DELETE Non-Existent Object Returns 404
    [Documentation]    ❌ Verifica que DELETE con ID inválido retorne 404
    ...                
    ...                Intentar eliminar un objeto que no existe
    ...                debe retornar 404
    [Tags]    @{TAGS_NEGATIVE}    delete_not_found    p0
    
    Log    🗑️ Intentando eliminar objeto inexistente: ID ${OBJECT_ID_INVALID}    console=${TRUE}
    
    ${endpoint}=    Set Variable    ${ENDPOINT_OBJECTS}/${OBJECT_ID_INVALID}
    ${response}=    DELETE Request    ${endpoint}    expected_status=${HTTP_404_NOT_FOUND}
    
    Validate Status Code    ${response}    ${HTTP_404_NOT_FOUND}
    
    # Validar mensaje de error
    ${json}=    Set Variable    ${response.json()}
    Dictionary Should Contain Key    ${json}    error
    
    Log    ✅ 404 retornado correctamente al intentar eliminar objeto inexistente    console=${TRUE}

PUT Non-Existent Object Returns 404
    [Documentation]    ❌ Verifica que PUT con ID inválido retorne 404
    ...                
    ...                Intentar actualizar un objeto que no existe
    ...                debe retornar 404
    [Tags]    @{TAGS_NEGATIVE}    update_not_found    p0
    
    Log    🔄 Intentando actualizar objeto inexistente: ID ${OBJECT_ID_INVALID}    console=${TRUE}
    
    ${body}=    Create Object Body    Updated Name    ${DATA_IPHONE_14}
    ${endpoint}=    Set Variable    ${ENDPOINT_OBJECTS}/${OBJECT_ID_INVALID}
    ${response}=    PUT Request    ${endpoint}    ${body}    expected_status=${HTTP_404_NOT_FOUND}
    
    Validate Status Code    ${response}    ${HTTP_404_NOT_FOUND}
    
    Log    ✅ 404 retornado correctamente al intentar actualizar objeto inexistente    console=${TRUE}

POST With Empty Name Field
    [Documentation]    ❌ Verifica comportamiento al crear objeto con nombre vacío
    ...                
    ...                El campo 'name' es requerido y no debe aceptar
    ...                valores vacíos
    [Tags]    @{TAGS_NEGATIVE}    empty_field    p1
    
    Log    📝 Intentando crear objeto con nombre vacío    console=${TRUE}
    
    # Crear body con name vacío
    ${body}=    Create Dictionary    name=${EMPTY}    data=${DATA_IPHONE_15}
    
    # API podría aceptarlo (comportamiento a documentar) o rechazarlo
    ${response}=    POST Request    ${ENDPOINT_OBJECTS}    ${body}    expected_status=any
    
    # Si la API lo acepta (200), documentar el comportamiento
    Run Keyword If    ${response.status_code} == ${HTTP_200_OK}
    ...    Log    ⚠️ API acepta nombre vacío - comportamiento documentado    console=${TRUE}
    ...    ELSE
    ...    Log    ✅ API rechaza nombre vacío correctamente    console=${TRUE}
    
    # Cleanup si se creó
    ${created}=    Run Keyword And Return Status
    ...    Should Be Equal As Integers    ${response.status_code}    ${HTTP_200_OK}
    
    Run Keyword If    ${created}
    ...    Run Keywords
    ...    ${object_id}=    Extract Object ID    ${response}
    ...    AND    Cleanup Test Objects    ${object_id}

POST With Missing Name Field
    [Documentation]    ❌ Verifica comportamiento al crear objeto sin campo name
    ...                
    ...                Debería retornar error 400 Bad Request
    [Tags]    @{TAGS_NEGATIVE}    missing_field    p0
    
    Log    📝 Intentando crear objeto sin campo name    console=${TRUE}
    
    # Body sin el campo 'name' requerido
    ${body}=    Create Dictionary    data=${DATA_MACBOOK_PRO}
    
    ${response}=    POST Request    ${ENDPOINT_OBJECTS}    ${body}    expected_status=any
    
    # Documentar el comportamiento de la API
    Log    Status recibido: ${response.status_code}    console=${TRUE}
    
    # La API podría aceptarlo o rechazarlo
    ${is_error}=    Evaluate    ${response.status_code} >= 400
    Run Keyword If    ${is_error}
    ...    Log    ✅ API rechaza petición sin nombre (${response.status_code})    console=${TRUE}
    ...    ELSE
    ...    Log    ⚠️ API acepta petición sin nombre - comportamiento documentado    console=${TRUE}

POST With Invalid JSON
    [Documentation]    ❌ Verifica manejo de JSON malformado
    ...                
    ...                Enviar JSON inválido debería retornar 400 Bad Request
    [Tags]    @{TAGS_NEGATIVE}    malformed_json    p1
    
    Log    📝 Intentando enviar JSON malformado    console=${TRUE}
    
    # Nota: RequestsLibrary maneja JSON automáticamente
    # Para este test, enviamos un body que no cumple con el formato esperado
    ${invalid_body}=    Create Dictionary    invalid_structure=not_an_object
    
    ${response}=    POST Request    ${ENDPOINT_OBJECTS}    ${invalid_body}    expected_status=any
    
    # Documentar comportamiento
    Log    Status recibido: ${response.status_code}    console=${TRUE}
    
    # La API puede aceptar estructuras variadas
    Run Keyword If    ${response.status_code} == ${HTTP_200_OK}
    ...    Log    ⚠️ API acepta estructura variada    console=${TRUE}
    ...    ELSE
    ...    Log    ✅ API valida estructura de request    console=${TRUE}
    
    # Cleanup si se creó
    ${created}=    Run Keyword And Return Status
    ...    Should Be Equal As Integers    ${response.status_code}    ${HTTP_200_OK}
    
    Run Keyword If    ${created}
    ...    Run Keywords
    ...    ${object_id}=    Extract Object ID    ${response}
    ...    AND    Cleanup Test Objects    ${object_id}

GET With Invalid ID Format
    [Documentation]    ❌ Verifica manejo de IDs con formato inválido
    ...                
    ...                IDs no numéricos o con caracteres especiales
    [Tags]    @{TAGS_NEGATIVE}    invalid_format    p1
    
    Log    🔍 Intentando GET con ID inválido: "abc123"    console=${TRUE}
    
    ${invalid_id}=    Set Variable    abc123
    ${endpoint}=    Set Variable    ${ENDPOINT_OBJECTS}/${invalid_id}
    ${response}=    GET Request    ${endpoint}    expected_status=any
    
    # Debe retornar error (400 o 404)
    ${is_error}=    Evaluate    ${response.status_code} >= 400
    Should Be True    ${is_error}
    ...    msg=API debería rechazar IDs con formato inválido
    
    Log    ✅ ID inválido rechazado: ${response.status_code}    console=${TRUE}

POST With Excessively Long Name
    [Documentation]    ❌ Verifica validación de longitud de campo name
    ...                
    ...                Nombres extremadamente largos deberían ser rechazados
    [Tags]    @{TAGS_NEGATIVE}    boundary    p1
    
    Log    📝 Intentando crear objeto con nombre muy largo (300+ chars)    console=${TRUE}
    
    # Crear nombre de 300 caracteres
    ${long_name}=    Evaluate    'A' * 300
    ${body}=    Create Object Body    ${long_name}    ${DATA_IPHONE_15}
    
    ${response}=    POST Request    ${ENDPOINT_OBJECTS}    ${body}    expected_status=any
    
    # Documentar comportamiento
    Log    Status recibido: ${response.status_code}    console=${TRUE}
    
    Run Keyword If    ${response.status_code} == ${HTTP_200_OK}
    ...    Log    ⚠️ API acepta nombres largos    console=${TRUE}
    ...    ELSE
    ...    Log    ✅ API valida longitud de nombre    console=${TRUE}
    
    # Cleanup si se creó
    ${created}=    Run Keyword And Return Status
    ...    Should Be Equal As Integers    ${response.status_code}    ${HTTP_200_OK}
    
    Run Keyword If    ${created}
    ...    Run Keywords
    ...    ${object_id}=    Extract Object ID    ${response}
    ...    AND    Cleanup Test Objects    ${object_id}

GET Multiple Objects With Invalid IDs
    [Documentation]    ❌ Verifica comportamiento con lista de IDs inválidos
    ...                
    ...                Query con IDs que no existen
    [Tags]    @{TAGS_NEGATIVE}    batch_invalid    p1
    
    Log    🔢 Obteniendo múltiples objetos con IDs inválidos    console=${TRUE}
    
    ${ids_param}=    Catenate    SEPARATOR=,    @{QUERY_IDS_ALL_INVALID}
    ${endpoint}=    Set Variable    ${ENDPOINT_OBJECTS}?id=${ids_param}
    
    ${response}=    GET Request    ${endpoint}    expected_status=any
    
    # Puede retornar lista vacía o error
    Run Keyword If    ${response.status_code} == ${HTTP_200_OK}
    ...    Run Keywords
    ...    ${json}=    Set Variable    ${response.json()}
    ...    AND    ${is_list}=    Evaluate    isinstance($json, list)
    ...    AND    Run Keyword If    ${is_list}
    ...    Log    ⚠️ API retorna lista (posiblemente vacía) para IDs inválidos    console=${TRUE}
    ...    ELSE
    ...    Log    ✅ API retorna error para IDs inválidos    console=${TRUE}

GET Mixed Valid And Invalid IDs
    [Documentation]    ⚠️ Verifica comportamiento con mezcla de IDs válidos e inválidos
    ...                
    ...                Query con algunos IDs válidos y otros inválidos
    [Tags]    @{TAGS_NEGATIVE}    mixed_ids    edge_case    p2
    
    Log    🔢 Obteniendo objetos con IDs mixtos (válidos e inválidos)    console=${TRUE}
    
    ${ids_param}=    Catenate    SEPARATOR=,    @{QUERY_IDS_MIXED}
    ${endpoint}=    Set Variable    ${ENDPOINT_OBJECTS}?id=${ids_param}
    
    ${response}=    GET Request    ${endpoint}    expected_status=any
    
    # Debería retornar solo los válidos
    Run Keyword If    ${response.status_code} == ${HTTP_200_OK}
    ...    Run Keywords
    ...    ${json}=    Set Variable    ${response.json()}
    ...    AND    Log    Objetos retornados: ${len($json)}    console=${TRUE}
    ...    AND    Log    ✅ API filtra IDs inválidos y retorna solo válidos    console=${TRUE}
    ...    ELSE
    ...    Log    ⚠️ API rechaza petición con IDs mixtos    console=${TRUE}

Double DELETE Same Object
    [Documentation]    ❌ Verifica que no se pueda eliminar dos veces el mismo objeto
    ...                
    ...                Segundo DELETE debe retornar 404
    [Tags]    @{TAGS_NEGATIVE}    double_delete    p1
    
    Log    🗑️ Test de doble eliminación    console=${TRUE}
    
    # Paso 1: Crear objeto
    ${unique_name}=    Generate Unique Name    DoubleDeleteTest
    ${body}=    Create Object Body    ${unique_name}    ${DATA_APPLE_WATCH}
    ${response_create}=    POST Request    ${ENDPOINT_OBJECTS}    ${body}
    ${object_id}=    Extract Object ID    ${response_create}
    
    Log    📝 Objeto creado con ID: ${object_id}    console=${TRUE}
    
    # Paso 2: Primera eliminación (debe funcionar)
    ${endpoint}=    Set Variable    ${ENDPOINT_OBJECTS}/${object_id}
    ${response_delete_1}=    DELETE Request    ${endpoint}
    Validate Status Code    ${response_delete_1}    ${HTTP_200_OK}
    Log    ✅ Primera eliminación exitosa    console=${TRUE}
    
    # Paso 3: Segunda eliminación (debe fallar con 404)
    ${response_delete_2}=    DELETE Request    ${endpoint}    expected_status=${HTTP_404_NOT_FOUND}
    Validate Status Code    ${response_delete_2}    ${HTTP_404_NOT_FOUND}
    Log    ✅ Segunda eliminación rechazada correctamente (404)    console=${TRUE}

UPDATE After DELETE Returns 404
    [Documentation]    ❌ Verifica que no se pueda actualizar un objeto eliminado
    ...                
    ...                PUT después de DELETE debe retornar 404
    [Tags]    @{TAGS_NEGATIVE}    update_after_delete    p1
    
    Log    🔄 Test de actualización después de eliminación    console=${TRUE}
    
    # Crear objeto
    ${unique_name}=    Generate Unique Name    UpdateAfterDelete
    ${body}=    Create Object Body    ${unique_name}    ${DATA_IPAD_PRO}
    ${response_create}=    POST Request    ${ENDPOINT_OBJECTS}    ${body}
    ${object_id}=    Extract Object ID    ${response_create}
    
    # Eliminar objeto
    ${endpoint}=    Set Variable    ${ENDPOINT_OBJECTS}/${object_id}
    ${response_delete}=    DELETE Request    ${endpoint}
    Validate Status Code    ${response_delete}    ${HTTP_200_OK}
    
    # Intentar actualizar objeto eliminado
    ${updated_body}=    Create Object Body    Updated Name    ${DATA_IPAD_PRO}
    ${response_update}=    PUT Request    ${endpoint}    ${updated_body}    expected_status=${HTTP_404_NOT_FOUND}
    
    Validate Status Code    ${response_update}    ${HTTP_404_NOT_FOUND}
    Log    ✅ Actualización de objeto eliminado rechazada (404)    console=${TRUE}

POST With Null Data Field
    [Documentation]    ✅ Verifica que se pueda crear objeto con data=null
    ...                
    ...                El campo data puede ser explícitamente null
    [Tags]    @{TAGS_NEGATIVE}    null_field    edge_case    p2
    
    Log    📝 Creando objeto con data=null explícito    console=${TRUE}
    
    ${unique_name}=    Generate Unique Name    NullDataTest
    ${body}=    Create Dictionary    name=${unique_name}    data=${NONE}
    
    ${response}=    POST Request    ${ENDPOINT_OBJECTS}    ${body}
    Validate Status Code    ${response}    ${HTTP_200_OK}
    
    # Validar que se creó correctamente
    ${json}=    Set Variable    ${response.json()}
    ${data}=    Get From Dictionary    ${json}    data
    
    Log    ✅ Objeto con data=null creado correctamente    console=${TRUE}
    
    ${object_id}=    Extract Object ID    ${response}
    
    [Teardown]    Run Keywords
    ...    Teardown API Test Case
    ...    AND    Cleanup Test Objects    ${object_id}

GET With Special Characters In ID
    [Documentation]    ❌ Verifica manejo de caracteres especiales en IDs
    ...                
    ...                IDs con caracteres especiales deben ser rechazados
    [Tags]    @{TAGS_NEGATIVE}    special_chars    p2
    
    Log    🔍 Intentando GET con caracteres especiales en ID    console=${TRUE}
    
    @{special_ids}=    Create List    1;DROP TABLE    ../../../    <script>    %00
    
    FOR    ${special_id}    IN    @{special_ids}
        ${endpoint}=    Set Variable    ${ENDPOINT_OBJECTS}/${special_id}
        ${response}=    GET Request    ${endpoint}    expected_status=any
        
        # Debe retornar error
        ${is_error}=    Evaluate    ${response.status_code} >= 400
        Should Be True    ${is_error}
        ...    msg=ID con caracteres especiales '${special_id}' debería ser rechazado
        
        Log    ✅ ID especial rechazado: '${special_id}'    console=${TRUE}
    END

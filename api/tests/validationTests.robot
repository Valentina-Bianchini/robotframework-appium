*** Settings ***
Documentation    ✔️ Validation Tests - Pruebas de validación de datos, schemas y tipos
...              
...              Tests que verifican la integridad de datos, tipos correctos,
...              schemas JSON y validaciones de campos requeridos.
...              
...              Tests incluidos:
...              - Schema Validation
...              - Required Fields
...              - Data Types
...              - Field Constraints
...              - Nested Objects

Resource         ../config/base.robot
Resource         ../config/helpers.robot
Resource         ../data/testData.robot
Resource         ../data/variables.robot

Suite Setup      Setup API Test Suite
Suite Teardown   Teardown API Test Suite
Test Setup       Setup API Test Case
Test Teardown    Teardown API Test Case

Default Tags     validation    data_quality

*** Test Cases ***
Validate Object Schema Structure
    [Documentation]    ✅ Valida que los objetos cumplan con el schema JSON esperado
    ...                
    ...                Schema esperado:
    ...                - id (string)
    ...                - name (string)
    ...                - data (object | null)
    [Tags]    @{TAGS_VALIDATION}    schema    p0
    
    Log    📋 Validando schema de objetos    console=${TRUE}
    
    # Obtener objeto
    ${endpoint}=    Set Variable    ${ENDPOINT_OBJECTS}/${OBJECT_ID_1}
    ${response}=    GET Request    ${endpoint}
    
    # Validar estructura básica
    ${json}=    Set Variable    ${response.json()}
    Validate Dictionary Has Keys    ${json}    id    name    data
    
    # Validar tipos de datos
    Validate Field Type    ${json}    id    str
    Validate Field Type    ${json}    name    str
    
    Log    ✅ Schema validado correctamente    console=${TRUE}

Validate Required Fields Present
    [Documentation]    ✅ Verifica que todos los campos requeridos estén presentes
    ...                
    ...                Campos requeridos:
    ...                - id (obligatorio)
    ...                - name (obligatorio)
    ...                - data (obligatorio, puede ser null)
    [Tags]    @{TAGS_VALIDATION}    required_fields    p0
    
    Log    🔍 Validando campos requeridos    console=${TRUE}
    
    ${endpoint}=    Set Variable    ${ENDPOINT_OBJECTS}/${OBJECT_ID_2}
    ${response}=    GET Request    ${endpoint}
    ${json}=    Set Variable    ${response.json()}
    
    # Validar presencia de campos requeridos
    Dictionary Should Contain Key    ${json}    id
    ...    msg=❌ Campo 'id' es requerido pero no está presente
    Dictionary Should Contain Key    ${json}    name
    ...    msg=❌ Campo 'name' es requerido pero no está presente
    Dictionary Should Contain Key    ${json}    data
    ...    msg=❌ Campo 'data' es requerido pero no está presente
    
    Log    ✅ Todos los campos requeridos presentes    console=${TRUE}

Validate Field Data Types
    [Documentation]    ✅ Valida que los campos tengan los tipos de datos correctos
    ...                
    ...                Tipos esperados:
    ...                - id: string
    ...                - name: string
    ...                - data: dict o None
    [Tags]    @{TAGS_VALIDATION}    types    p0
    
    Log    🔢 Validando tipos de datos    console=${TRUE}
    
    ${endpoint}=    Set Variable    ${ENDPOINT_OBJECTS}/${OBJECT_ID_3}
    ${response}=    GET Request    ${endpoint}
    ${json}=    Set Variable    ${response.json()}
    
    # Validar tipo de 'id'
    ${id}=    Get From Dictionary    ${json}    id
    ${id_type}=    Evaluate    type($id).__name__
    Should Be Equal As Strings    ${id_type}    str
    ...    msg=❌ Campo 'id' debe ser string, pero es ${id_type}
    
    # Validar tipo de 'name'
    ${name}=    Get From Dictionary    ${json}    name
    ${name_type}=    Evaluate    type($name).__name__
    Should Be Equal As Strings    ${name_type}    str
    ...    msg=❌ Campo 'name' debe ser string, pero es ${name_type}
    
    # Validar tipo de 'data' (puede ser dict o NoneType)
    ${data}=    Get From Dictionary    ${json}    data
    ${data_type}=    Evaluate    type($data).__name__
    ${is_valid_type}=    Evaluate    '${data_type}' in ['dict', 'NoneType']
    Should Be True    ${is_valid_type}
    ...    msg=❌ Campo 'data' debe ser dict o None, pero es ${data_type}
    
    Log    ✅ Tipos de datos correctos    console=${TRUE}

Validate ID Field Format
    [Documentation]    ✅ Valida que el campo ID tenga formato correcto
    ...                
    ...                Formato esperado:
    ...                - String numérico
    ...                - No vacío
    ...                - Solo dígitos
    [Tags]    @{TAGS_VALIDATION}    id_format    p1
    
    Log    🆔 Validando formato de ID    console=${TRUE}
    
    ${endpoint}=    Set Variable    ${ENDPOINT_OBJECTS}/${OBJECT_ID_1}
    ${response}=    GET Request    ${endpoint}
    ${json}=    Set Variable    ${response.json()}
    
    ${id}=    Get From Dictionary    ${json}    id
    
    # ID no debe estar vacío
    Should Not Be Empty    ${id}
    ...    msg=❌ ID no puede estar vacío
    
    # ID debe contener solo dígitos
    ${is_numeric}=    Evaluate    '${id}'.isdigit()
    Should Be True    ${is_numeric}
    ...    msg=❌ ID debe contener solo dígitos: ${id}
    
    Log    ✅ Formato de ID válido: ${id}    console=${TRUE}

Validate Name Field Constraints
    [Documentation]    ✅ Valida que el campo name cumpla con restricciones
    ...                
    ...                Restricciones:
    ...                - No vacío
    ...                - Tipo string
    ...                - Longitud razonable (< 255 chars)
    [Tags]    @{TAGS_VALIDATION}    name_constraints    p1
    
    Log    📛 Validando restricciones del campo name    console=${TRUE}
    
    ${endpoint}=    Set Variable    ${ENDPOINT_OBJECTS}/${OBJECT_ID_2}
    ${response}=    GET Request    ${endpoint}
    ${json}=    Set Variable    ${response.json()}
    
    ${name}=    Get From Dictionary    ${json}    name
    
    # Name no debe estar vacío
    Should Not Be Empty    ${name}
    ...    msg=❌ Campo 'name' no puede estar vacío
    
    # Name debe ser string
    ${is_string}=    Evaluate    isinstance($name, str)
    Should Be True    ${is_string}
    ...    msg=❌ Campo 'name' debe ser string
    
    # Name debe tener longitud razonable
    ${length}=    Get Length    ${name}
    Should Be True    ${length} > 0
    ...    msg=❌ Campo 'name' debe tener al menos 1 carácter
    Should Be True    ${length} < 256
    ...    msg=❌ Campo 'name' no debe exceder 255 caracteres (actual: ${length})
    
    Log    ✅ Campo name válido: "${name}" (${length} chars)    console=${TRUE}

Validate Data Field Can Be Null
    [Documentation]    ✅ Valida que el campo data puede ser null legítimamente
    ...                
    ...                El campo 'data' es opcional y puede ser:
    ...                - null
    ...                - objeto con propiedades
    [Tags]    @{TAGS_VALIDATION}    nullable_field    p1
    
    Log    🔄 Validando que data puede ser null    console=${TRUE}
    
    # Objeto con data=null (ID 2)
    ${endpoint}=    Set Variable    ${ENDPOINT_OBJECTS}/${OBJECT_ID_2}
    ${response}=    GET Request    ${endpoint}
    ${json}=    Set Variable    ${response.json()}
    
    # Verificar que 'data' existe en el objeto
    Dictionary Should Contain Key    ${json}    data
    
    # El valor puede ser null, lo cual es válido
    ${data}=    Get From Dictionary    ${json}    data
    Log    Campo 'data' tiene valor: ${data}    console=${TRUE}
    
    # Validar que es None (null) o dict
    ${is_valid}=    Run Keyword And Return Status
    ...    Should Be Equal    ${data}    ${NONE}
    
    Run Keyword If    not ${is_valid}
    ...    Should Be Equal    ${data.__class__.__name__}    dict
    
    Log    ✅ Campo data válido (null o objeto)    console=${TRUE}

Validate Nested Data Object Structure
    [Documentation]    ✅ Valida estructura de objetos anidados en 'data'
    ...                
    ...                Cuando 'data' no es null, debe ser un objeto válido
    ...                con propiedades arbitrarias
    [Tags]    @{TAGS_VALIDATION}    nested    p1
    
    Log    🔗 Validando estructura de objeto anidado    console=${TRUE}
    
    # Objeto que tiene data con propiedades (ID 1)
    ${endpoint}=    Set Variable    ${ENDPOINT_OBJECTS}/${OBJECT_ID_1}
    ${response}=    GET Request    ${endpoint}
    ${json}=    Set Variable    ${response.json()}
    
    ${data}=    Get From Dictionary    ${json}    data
    
    # Si data no es null, debe ser un diccionario
    Run Keyword If    ${data} is not ${NONE}
    ...    Should Be Equal    ${data.__class__.__name__}    dict
    ...    msg=❌ Campo 'data' debe ser un objeto (dict) cuando no es null
    
    # Si es dict, puede tener propiedades arbitrarias
    Run Keyword If    ${data} is not ${NONE}
    ...    Log    Propiedades en data: ${data}    console=${TRUE}
    
    Log    ✅ Estructura de objeto anidado válida    console=${TRUE}

Validate List Response Structure
    [Documentation]    ✅ Valida estructura de respuesta cuando es lista
    ...                
    ...                GET /objects retorna array de objetos
    ...                Cada elemento debe tener estructura válida
    [Tags]    @{TAGS_VALIDATION}    list_structure    p0
    
    Log    📜 Validando estructura de lista de objetos    console=${TRUE}
    
    ${response}=    GET Request    ${ENDPOINT_OBJECTS}
    
    # Verificar que es lista
    Validate Response Is List    ${response}    1
    
    # Validar estructura del primer objeto
    ${objects}=    Set Variable    ${response.json()}
    ${first_object}=    Set Variable    ${objects[0]}
    
    Validate Dictionary Has Keys    ${first_object}    id    name    data
    Validate Field Type    ${first_object}    id    str
    Validate Field Type    ${first_object}    name    str
    
    # Contar total de objetos
    ${count}=    Get Length    ${objects}
    Log    📊 Total de objetos en lista: ${count}    console=${TRUE}
    
    Log    ✅ Estructura de lista validada    console=${TRUE}

Validate Multiple Objects Schema
    [Documentation]    ✅ Valida que múltiples objetos cumplan con el schema
    ...                
    ...                Obtiene los primeros 5 objetos y valida que todos
    ...                cumplan con la estructura esperada
    [Tags]    @{TAGS_VALIDATION}    batch_validation    p1
    
    Log    🔍 Validando schema de múltiples objetos    console=${TRUE}
    
    ${response}=    GET Request    ${ENDPOINT_OBJECTS}
    ${objects}=    Set Variable    ${response.json()}
    
    # Validar primeros 5 objetos
    ${validation_count}=    Set Variable If    ${len($objects)} > 5    5    ${len($objects)}
    
    FOR    ${index}    IN RANGE    ${validation_count}
        ${object}=    Set Variable    ${objects[${index}]}
        
        # Validar estructura
        Validate Dictionary Has Keys    ${object}    id    name    data
        Validate Field Type    ${object}    id    str
        Validate Field Type    ${object}    name    str
        
        ${id}=    Get From Dictionary    ${object}    id
        Log    ✅ Objeto ${index + 1}/${validation_count} - ID ${id} válido    console=${TRUE}
    END
    
    Log    ✅ ${validation_count} objetos validados correctamente    console=${TRUE}

Validate Created Object Matches Request
    [Documentation]    ✅ Valida que el objeto creado coincida con la petición
    ...                
    ...                Al crear un objeto, la respuesta debe contener
    ...                exactamente los datos enviados
    [Tags]    @{TAGS_VALIDATION}    create_validation    p0
    
    Log    🆕 Validando coincidencia de datos creados    console=${TRUE}
    
    # Crear objeto con datos específicos
    ${unique_name}=    Generate Unique Name    ValidationTest
    ${test_data}=    Create Object With Data    
    ...    color=Blue
    ...    capacity=128 GB
    ...    price=799.99
    ${body}=    Create Object Body    ${unique_name}    ${test_data}
    
    ${response}=    POST Request    ${ENDPOINT_OBJECTS}    ${body}
    ${json}=    Set Variable    ${response.json()}
    
    # Validar que name coincide
    Validate Field Value    ${json}    name    ${unique_name}
    
    # Validar que data contiene los campos enviados
    ${data_response}=    Get From Dictionary    ${json}    data
    Dictionary Should Contain Key    ${data_response}    color
    Dictionary Should Contain Key    ${data_response}    capacity
    Dictionary Should Contain Key    ${data_response}    price
    
    # Validar valores específicos
    ${color}=    Get From Dictionary    ${data_response}    color
    Should Be Equal    ${color}    Blue
    
    ${object_id}=    Extract Object ID    ${response}
    Log    ✅ Datos creados coinciden con request    console=${TRUE}
    
    [Teardown]    Run Keywords
    ...    Teardown API Test Case
    ...    AND    Cleanup Test Objects    ${object_id}

Validate Empty Data Field
    [Documentation]    ✅ Valida que se pueda crear objeto sin campo data
    ...                
    ...                El campo 'data' no es obligatorio al crear objetos
    [Tags]    @{TAGS_VALIDATION}    optional_field    p1
    
    Log    📝 Validando creación sin campo data    console=${TRUE}
    
    # Crear objeto solo con name
    ${unique_name}=    Generate Unique Name    MinimalObject
    ${body}=    Create Dictionary    name=${unique_name}
    
    ${response}=    POST Request    ${ENDPOINT_OBJECTS}    ${body}
    Validate Status Code    ${response}    ${HTTP_200_OK}
    
    ${json}=    Set Variable    ${response.json()}
    Validate Field Value    ${json}    name    ${unique_name}
    
    # data debería existir pero puede ser null o empty
    Dictionary Should Contain Key    ${json}    data
    
    ${object_id}=    Extract Object ID    ${response}
    Log    ✅ Objeto creado sin data exitosamente    console=${TRUE}
    
    [Teardown]    Run Keywords
    ...    Teardown API Test Case
    ...    AND    Cleanup Test Objects    ${object_id}

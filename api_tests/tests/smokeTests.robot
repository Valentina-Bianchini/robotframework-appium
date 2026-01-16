*** Settings ***
Documentation    🚭 Smoke Tests - Pruebas básicas de conectividad y salud de la API
...              
...              Estos tests verifican que la API esté accesible, respondiendo
...              correctamente y que los endpoints principales funcionen.
...              
...              Tests incluidos:
...              - API Health Check
...              - Base URL Accessibility  
...              - List Objects Endpoint
...              - Single Object Endpoint
...              - Response Time Validation

Resource         ../config/base.robot
Resource         ../config/helpers.robot
Resource         ../data/testData.robot
Resource         ../data/variables.robot

Suite Setup      Setup API Test Suite
Suite Teardown   Teardown API Test Suite
Test Setup       Setup API Test Case
Test Teardown    Teardown API Test Case

Default Tags     smoke    critical    quick

*** Test Cases ***
API Health Check
    [Documentation]    ✅ Verifica que la API esté accesible y respondiendo
    ...                
    ...                Valida:
    ...                - Status code 200
    ...                - Response no vacío
    ...                - Tiempo de respuesta < 3s
    [Tags]    @{TAGS_SMOKE}    health    p0
    
    Log    🏥 Iniciando Health Check de la API    console=${TRUE}
    
    # Realizar petición GET a /objects
    ${response}=    GET Request    ${ENDPOINT_OBJECTS}
    
    # Validaciones
    Validate Status Code    ${response}    ${HTTP_200_OK}
    Validate Response Not Empty    ${response}
    Validate Response Is List    ${response}    ${MIN_OBJECTS_IN_LIST}
    Validate Response Time    ${response}    ${MAX_RESPONSE_TIME_LIST}
    
    Log    ✅ API Health Check PASSED    console=${TRUE}

Verify Base URL Accessible
    [Documentation]    ✅ Verifica que la URL base de la API sea accesible
    ...                
    ...                Valida:
    ...                - Conexión exitosa
    ...                - Headers de respuesta correctos
    ...                - Content-Type válido
    [Tags]    @{TAGS_SMOKE}    connectivity    p0
    
    Log    🌐 Verificando accesibilidad de ${BASE_URL}    console=${TRUE}
    
    ${response}=    GET Request    ${ENDPOINT_OBJECTS}
    
    # Validar status y headers
    Should Be Equal As Integers    ${response.status_code}    ${HTTP_200_OK}
    Should Contain    ${response.headers}[Content-Type]    ${CONTENT_TYPE_JSON}
    
    Log    ✅ Base URL es accesible    console=${TRUE}

List All Objects Returns Data
    [Documentation]    ✅ Verifica que GET /objects retorne lista de objetos
    ...                
    ...                Valida:
    ...                - Status 200
    ...                - Response es array
    ...                - Array contiene al menos 10 objetos
    ...                - Cada objeto tiene estructura válida
    [Tags]    @{TAGS_SMOKE}    list    p0
    
    Log    📋 Obteniendo lista de todos los objetos    console=${TRUE}
    
    ${response}=    GET Request    ${ENDPOINT_OBJECTS}
    
    # Validar respuesta es lista
    Validate Response Is List    ${response}    ${MIN_OBJECTS_IN_LIST}
    
    # Validar estructura del primer objeto
    ${first_object}=    Set Variable    ${response.json()[0]}
    Validate Dictionary Has Keys    ${first_object}    id    name    data
    
    # Log cantidad de objetos
    ${count}=    Get Length    ${response.json()}
    Log    📊 Total de objetos: ${count}    console=${TRUE}
    
    Log    ✅ Lista de objetos obtenida correctamente    console=${TRUE}

Get Single Object By ID
    [Documentation]    ✅ Verifica que GET /objects/{id} retorne un objeto específico
    ...                
    ...                Valida:
    ...                - Status 200
    ...                - Response es objeto (dict)
    ...                - Objeto contiene ID correcto
    ...                - Campos requeridos presentes
    [Tags]    @{TAGS_SMOKE}    single_object    p0
    
    Log    🔍 Obteniendo objeto con ID: ${OBJECT_ID_1}    console=${TRUE}
    
    # Construir endpoint con ID
    ${endpoint}=    Set Variable    ${ENDPOINT_OBJECTS}/${OBJECT_ID_1}
    ${response}=    GET Request    ${endpoint}
    
    # Validar respuesta
    Validate Status Code    ${response}    ${HTTP_200_OK}
    Validate Response Is Dictionary    ${response}
    
    # Validar estructura
    ${json}=    Set Variable    ${response.json()}
    Validate Dictionary Has Keys    ${json}    id    name    data
    Validate Field Value    ${json}    id    ${OBJECT_ID_1}
    
    Log    ✅ Objeto obtenido correctamente    console=${TRUE}

Verify Known Mock Object
    [Documentation]    ✅ Verifica que un objeto mock conocido exista y tenga datos esperados
    ...                
    ...                Objeto de prueba: ID 1 (Google Pixel 6 Pro)
    ...                
    ...                Valida:
    ...                - Objeto existe
    ...                - Nombre coincide
    ...                - Estructura es válida
    [Tags]    @{TAGS_SMOKE}    mock_data    p1
    
    Log    📱 Verificando objeto mock: ID ${OBJECT_ID_1}    console=${TRUE}
    
    ${endpoint}=    Set Variable    ${ENDPOINT_OBJECTS}/${OBJECT_ID_1}
    ${response}=    GET Request    ${endpoint}
    
    # Validar datos conocidos
    ${json}=    Set Variable    ${response.json()}
    Validate Field Value    ${json}    id    ${OBJECT_ID_1}
    Validate Field Value    ${json}    name    ${EXPECTED_NAME_ID_1}
    
    # Validar que 'data' existe (puede ser null u objeto)
    Dictionary Should Contain Key    ${json}    data
    
    Log    ✅ Objeto mock verificado correctamente    console=${TRUE}

Response Time Within SLA
    [Documentation]    ⚡ Verifica que los tiempos de respuesta estén dentro del SLA
    ...                
    ...                Límites:
    ...                - GET list: < 3.0s
    ...                - GET single: < 1.5s
    ...                
    ...                Valida que la API responda dentro de tiempos aceptables
    [Tags]    @{TAGS_SMOKE}    @{TAGS_PERFORMANCE}    sla    p1
    
    Log    ⚡ Verificando tiempos de respuesta    console=${TRUE}
    
    # Test 1: List objects
    ${response_list}=    GET Request    ${ENDPOINT_OBJECTS}
    Validate Response Time    ${response_list}    ${MAX_RESPONSE_TIME_LIST}
    ${time_list}=    Evaluate    ${response_list.elapsed.total_seconds()}
    Log    ⏱️ GET /objects: ${time_list}s    console=${TRUE}
    
    # Test 2: Single object
    ${endpoint}=    Set Variable    ${ENDPOINT_OBJECTS}/${OBJECT_ID_1}
    ${response_single}=    GET Request    ${endpoint}
    Validate Response Time    ${response_single}    ${MAX_RESPONSE_TIME_GET}
    ${time_single}=    Evaluate    ${response_single.elapsed.total_seconds()}
    Log    ⏱️ GET /objects/1: ${time_single}s    console=${TRUE}
    
    Log    ✅ Tiempos de respuesta dentro del SLA    console=${TRUE}

API Returns Valid JSON
    [Documentation]    ✅ Verifica que la API retorne JSON válido y parseable
    ...                
    ...                Valida:
    ...                - Content-Type es application/json
    ...                - Response puede parsearse como JSON
    ...                - Estructura JSON es válida
    [Tags]    @{TAGS_SMOKE}    json    p1
    
    Log    📝 Validando formato JSON de respuestas    console=${TRUE}
    
    ${response}=    GET Request    ${ENDPOINT_OBJECTS}
    
    # Validar Content-Type header
    Should Contain    ${response.headers}[Content-Type]    ${CONTENT_TYPE_JSON}
    
    # Intentar parsear JSON (debe funcionar sin errores)
    ${json}=    Set Variable    ${response.json()}
    Should Not Be Equal    ${json}    ${NONE}
    
    Log    ✅ JSON válido recibido    console=${TRUE}

Multiple Objects By IDs
    [Documentation]    ✅ Verifica que se puedan obtener múltiples objetos por sus IDs
    ...                
    ...                Valida:
    ...                - Query con múltiples IDs funciona
    ...                - Retorna array de objetos
    ...                - Cantidad correcta de resultados
    [Tags]    @{TAGS_SMOKE}    batch    p1
    
    Log    🔢 Obteniendo múltiples objetos: ${QUERY_IDS_VALID}    console=${TRUE}
    
    # Construir endpoint con query params
    ${ids_param}=    Catenate    SEPARATOR=,    @{QUERY_IDS_VALID}
    ${endpoint}=    Set Variable    ${ENDPOINT_OBJECTS}?id=${ids_param}
    
    ${response}=    GET Request    ${endpoint}
    
    # Validar respuesta
    Validate Status Code    ${response}    ${HTTP_200_OK}
    Validate Response Is List    ${response}
    
    # Validar cantidad de resultados
    ${count}=    Get Length    ${response.json()}
    ${expected_count}=    Get Length    ${QUERY_IDS_VALID}
    Should Be Equal As Integers    ${count}    ${expected_count}
    ...    msg=Se esperaban ${expected_count} objetos, se recibieron ${count}
    
    Log    ✅ Múltiples objetos obtenidos correctamente    console=${TRUE}

*** Keywords ***
Log Test Summary
    [Documentation]    Genera log de resumen de smoke tests
    Log    ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━    console=${TRUE}
    Log    🚭 SMOKE TESTS SUMMARY    console=${TRUE}
    Log    ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━    console=${TRUE}

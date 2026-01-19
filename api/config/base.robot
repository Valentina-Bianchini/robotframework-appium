*** Settings ***
Documentation    Configuración base para tests de API REST
...              Establece sesiones, headers y configuraciones globales
Library          RequestsLibrary
Library          Collections
Library          OperatingSystem
Library          String
Library          DateTime

*** Variables ***
# URLs Base
${BASE_URL}              https://api.restful-api.dev
${HEALTH_ENDPOINT}       /objects

# Configuración de sesión
${SESSION_ALIAS}         restful_api
${VERIFY_SSL}            ${FALSE}
${TIMEOUT}               30

# Headers comunes
&{DEFAULT_HEADERS}       Content-Type=application/json
...                      Accept=application/json

# Tiempos de espera (en segundos)
${RESPONSE_TIMEOUT}      5
${MAX_RESPONSE_TIME}     2.0

# Status codes esperados
${STATUS_OK}             200
${STATUS_CREATED}        200
${STATUS_NO_CONTENT}     204
${STATUS_BAD_REQUEST}    400
${STATUS_NOT_FOUND}      404
${STATUS_SERVER_ERROR}   500

*** Keywords ***
Setup API Test Suite
    [Documentation]    Configuración inicial para toda la suite de tests
    ...                Crea sesión HTTP y valida conectividad
    Log    🚀 Iniciando Suite de Tests de API    console=${TRUE}
    Create API Session
    Verify API Health

Teardown API Test Suite
    [Documentation]    Limpieza final de la suite de tests
    ...                Cierra sesiones y genera reporte de resumen
    Log    ✅ Finalizando Suite de Tests de API    console=${TRUE}
    Delete All Sessions
    Log Many    Suite completada exitosamente    timestamp=${EMPTY}

Setup API Test Case
    [Documentation]    Configuración inicial para cada test case
    ...                Verifica que la sesión esté activa
    Log    🧪 Ejecutando Test Case    console=${TRUE}
    ${session_exists}=    Run Keyword And Return Status    Session Exists    ${SESSION_ALIAS}
    Run Keyword If    not ${session_exists}    Create API Session

Teardown API Test Case
    [Documentation]    Limpieza después de cada test case
    ...                Registra resultado y limpia datos temporales
    Log    ✅ Test Case completado    console=${TRUE}

Create API Session
    [Documentation]    Crea sesión HTTP reutilizable con configuración estándar
    ...                Parámetros de timeout y SSL configurables
    Log    📡 Creando sesión HTTP: ${SESSION_ALIAS}    console=${TRUE}
    Create Session    
    ...    alias=${SESSION_ALIAS}
    ...    url=${BASE_URL}
    ...    headers=${DEFAULT_HEADERS}
    ...    verify=${VERIFY_SSL}
    ...    timeout=${TIMEOUT}
    Log    ✅ Sesión HTTP creada exitosamente    console=${TRUE}

Verify API Health
    [Documentation]    Verifica que la API esté accesible y respondiendo
    ...                Realiza GET al endpoint de salud
    Log    🏥 Verificando salud de la API...    console=${TRUE}
    ${response}=    GET On Session    ${SESSION_ALIAS}    ${HEALTH_ENDPOINT}    expected_status=any
    Should Be Equal As Integers    ${response.status_code}    ${STATUS_OK}
    ...    msg=❌ API no está respondiendo correctamente
    Log    ✅ API está saludable y respondiendo    console=${TRUE}

Log Request
    [Documentation]    Registra detalles de la petición para debugging
    [Arguments]    ${method}    ${endpoint}    ${body}=${EMPTY}
    Log    📤 REQUEST:    console=${TRUE}
    Log    Method: ${method}    console=${TRUE}
    Log    Endpoint: ${endpoint}    console=${TRUE}
    Run Keyword If    '${body}' != '${EMPTY}'    Log    Body: ${body}    console=${TRUE}

Log Response
    [Documentation]    Registra detalles de la respuesta para debugging
    [Arguments]    ${response}
    Log    📥 RESPONSE:    console=${TRUE}
    Log    Status: ${response.status_code}    console=${TRUE}
    Log    Body: ${response.json()}    console=${TRUE}
    Log    Elapsed: ${response.elapsed}    console=${TRUE}

Get Timestamp
    [Documentation]    Obtiene timestamp actual en formato ISO
    ...                Útil para generar datos únicos en tests
    ${timestamp}=    Get Current Date    result_format=%Y-%m-%dT%H:%M:%S
    RETURN    ${timestamp}

Generate Unique Name
    [Documentation]    Genera nombre único para objetos de prueba
    ...                Combina prefijo con timestamp
    [Arguments]    ${prefix}=TestObject
    ${timestamp}=    Get Current Date    result_format=%Y%m%d%H%M%S
    ${unique_name}=    Set Variable    ${prefix}_${timestamp}
    RETURN    ${unique_name}

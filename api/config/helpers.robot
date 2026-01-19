*** Settings ***
Documentation    Keywords auxiliares reutilizables para tests de API
...              Contiene validaciones, assertions y utilidades comunes
Library          RequestsLibrary
Library          Collections
Library          String
Library          OperatingSystem
Resource         base.robot

*** Keywords ***
# ==================== HTTP REQUEST HELPERS ====================

GET Request
    [Documentation]    Realiza petición GET con logging y validación
    ...                Retorna objeto response completo
    [Arguments]    ${endpoint}    ${expected_status}=${STATUS_OK}
    Log Request    GET    ${endpoint}
    ${response}=    GET On Session    ${SESSION_ALIAS}    ${endpoint}    expected_status=${expected_status}
    Log Response    ${response}
    RETURN    ${response}

POST Request
    [Documentation]    Realiza petición POST con body JSON
    ...                Valida status code y retorna response
    [Arguments]    ${endpoint}    ${body}    ${expected_status}=${STATUS_OK}
    Log Request    POST    ${endpoint}    ${body}
    ${response}=    POST On Session    ${SESSION_ALIAS}    ${endpoint}    json=${body}    expected_status=${expected_status}
    Log Response    ${response}
    RETURN    ${response}

PUT Request
    [Documentation]    Realiza petición PUT para actualización completa
    ...                Valida status code y retorna response
    [Arguments]    ${endpoint}    ${body}    ${expected_status}=${STATUS_OK}
    Log Request    PUT    ${endpoint}    ${body}
    ${response}=    PUT On Session    ${SESSION_ALIAS}    ${endpoint}    json=${body}    expected_status=${expected_status}
    Log Response    ${response}
    RETURN    ${response}

PATCH Request
    [Documentation]    Realiza petición PATCH para actualización parcial
    ...                Valida status code y retorna response
    [Arguments]    ${endpoint}    ${body}    ${expected_status}=${STATUS_OK}
    Log Request    PATCH    ${endpoint}    ${body}
    ${response}=    PATCH On Session    ${SESSION_ALIAS}    ${endpoint}    json=${body}    expected_status=${expected_status}
    Log Response    ${response}
    RETURN    ${response}

DELETE Request
    [Documentation]    Realiza petición DELETE con validación
    ...                Retorna response completo
    [Arguments]    ${endpoint}    ${expected_status}=${STATUS_OK}
    Log Request    DELETE    ${endpoint}
    ${response}=    DELETE On Session    ${SESSION_ALIAS}    ${endpoint}    expected_status=${expected_status}
    Log Response    ${response}
    RETURN    ${response}

# ==================== VALIDATIONS ====================

Validate Status Code
    [Documentation]    Valida que el status code sea el esperado
    ...                Muestra mensaje descriptivo en caso de error
    [Arguments]    ${response}    ${expected_status}
    Should Be Equal As Integers    ${response.status_code}    ${expected_status}
    ...    msg=❌ Status code esperado: ${expected_status}, recibido: ${response.status_code}
    Log    ✅ Status code válido: ${expected_status}    console=${TRUE}

Validate Response Not Empty
    [Documentation]    Verifica que la respuesta no esté vacía
    ...                Útil para endpoints que retornan listas o objetos
    [Arguments]    ${response}
    Should Not Be Empty    ${response.json()}
    ...    msg=❌ Response body está vacío
    Log    ✅ Response contiene datos    console=${TRUE}

Validate Response Is List
    [Documentation]    Valida que la respuesta sea una lista
    ...                Verifica tipo de dato y opcionalmente longitud mínima
    [Arguments]    ${response}    ${min_length}=0
    ${json}=    Set Variable    ${response.json()}
    ${is_list}=    Evaluate    isinstance($json, list)
    Should Be True    ${is_list}    msg=❌ Response no es una lista
    ${length}=    Get Length    ${json}
    Should Be True    ${length} >= ${min_length}
    ...    msg=❌ Lista tiene ${length} elementos, se esperaban al menos ${min_length}
    Log    ✅ Response es lista con ${length} elementos    console=${TRUE}

Validate Response Is Dictionary
    [Documentation]    Valida que la respuesta sea un diccionario/objeto
    ...                Verifica tipo de dato
    [Arguments]    ${response}
    ${json}=    Set Variable    ${response.json()}
    ${is_dict}=    Evaluate    isinstance($json, dict)
    Should Be True    ${is_dict}    msg=❌ Response no es un objeto
    Log    ✅ Response es objeto válido    console=${TRUE}

Validate Dictionary Has Keys
    [Documentation]    Valida que un diccionario contenga las claves especificadas
    ...                Acepta lista de claves requeridas
    [Arguments]    ${dictionary}    @{required_keys}
    FOR    ${key}    IN    @{required_keys}
        Dictionary Should Contain Key    ${dictionary}    ${key}
        ...    msg=❌ Clave '${key}' no encontrada en response
        Log    ✅ Clave '${key}' encontrada    console=${TRUE}
    END

Validate Field Not Empty
    [Documentation]    Valida que un campo específico no esté vacío
    ...                Soporta valores None, null y empty string
    [Arguments]    ${dictionary}    ${key}
    ${value}=    Get From Dictionary    ${dictionary}    ${key}
    Should Not Be Equal    ${value}    ${NONE}
    ...    msg=❌ Campo '${key}' es None
    Should Not Be Equal    ${value}    ${EMPTY}
    ...    msg=❌ Campo '${key}' está vacío
    Log    ✅ Campo '${key}' tiene valor: ${value}    console=${TRUE}

Validate Field Value
    [Documentation]    Valida que un campo tenga un valor específico
    ...                Compara valores con conversión a string
    [Arguments]    ${dictionary}    ${key}    ${expected_value}
    ${actual_value}=    Get From Dictionary    ${dictionary}    ${key}
    Should Be Equal As Strings    ${actual_value}    ${expected_value}
    ...    msg=❌ Campo '${key}': esperado '${expected_value}', recibido '${actual_value}'
    Log    ✅ Campo '${key}' tiene valor correcto: ${expected_value}    console=${TRUE}

Validate Field Type
    [Documentation]    Valida el tipo de dato de un campo
    ...                Tipos soportados: str, int, float, bool, list, dict
    [Arguments]    ${dictionary}    ${key}    ${expected_type}
    ${value}=    Get From Dictionary    ${dictionary}    ${key}
    ${actual_type}=    Evaluate    type($value).__name__
    Should Be Equal As Strings    ${actual_type}    ${expected_type}
    ...    msg=❌ Campo '${key}': tipo esperado '${expected_type}', recibido '${actual_type}'
    Log    ✅ Campo '${key}' tiene tipo correcto: ${expected_type}    console=${TRUE}

# ==================== RESPONSE TIME VALIDATIONS ====================

Validate Response Time
    [Documentation]    Valida que el tiempo de respuesta esté dentro del límite
    ...                Tiempo en segundos (float)
    [Arguments]    ${response}    ${max_time}=${MAX_RESPONSE_TIME}
    ${elapsed_seconds}=    Evaluate    float(${response.elapsed.total_seconds()})
    ${max_time_float}=    Convert To Number    ${max_time}
    Should Be True    ${elapsed_seconds} <= ${max_time_float}
    ...    msg=❌ Response time ${elapsed_seconds}s excede el máximo ${max_time}s
    Log    ✅ Response time OK: ${elapsed_seconds}s    console=${TRUE}

# ==================== DATA HELPERS ====================

Create Object Body
    [Documentation]    Crea body JSON para creación de objetos
    ...                Acepta nombre y datos adicionales
    [Arguments]    ${name}    ${data}=${NONE}
    ${body}=    Create Dictionary    name=${name}
    Run Keyword If    ${data} is not ${NONE}    Set To Dictionary    ${body}    data=${data}
    RETURN    ${body}

Create Object With Data
    [Documentation]    Crea diccionario de datos para campo 'data'
    ...                Acepta pares key=value como argumentos
    [Arguments]    &{data_fields}
    ${data}=    Create Dictionary    &{data_fields}
    RETURN    ${data}

Extract Object ID
    [Documentation]    Extrae el ID de un objeto de la respuesta
    ...                Retorna ID como string
    [Arguments]    ${response}
    ${json}=    Set Variable    ${response.json()}
    ${id}=    Get From Dictionary    ${json}    id
    RETURN    ${id}

Extract Field From Response
    [Documentation]    Extrae un campo específico de la respuesta
    ...                Retorna valor del campo
    [Arguments]    ${response}    ${field_name}
    ${json}=    Set Variable    ${response.json()}
    ${value}=    Get From Dictionary    ${json}    ${field_name}
    RETURN    ${value}

# ==================== LIST HELPERS ====================

Get Object From List By ID
    [Documentation]    Busca un objeto en una lista por su ID
    ...                Retorna el objeto si lo encuentra
    [Arguments]    ${objects_list}    ${object_id}
    FOR    ${object}    IN    @{objects_list}
        ${id}=    Get From Dictionary    ${object}    id
        Return From Keyword If    '${id}' == '${object_id}'    ${object}
    END
    Fail    ❌ Objeto con ID ${object_id} no encontrado en la lista

Filter Objects By Name
    [Documentation]    Filtra objetos de una lista por nombre (contiene)
    ...                Retorna lista de objetos que coinciden
    [Arguments]    ${objects_list}    ${name_pattern}
    @{filtered}=    Create List
    FOR    ${object}    IN    @{objects_list}
        ${name}=    Get From Dictionary    ${object}    name
        ${contains}=    Evaluate    '${name_pattern}'.lower() in '${name}'.lower()
        Run Keyword If    ${contains}    Append To List    ${filtered}    ${object}
    END
    RETURN    ${filtered}

# ==================== JSON SCHEMA VALIDATION ====================

Validate JSON Schema From File
    [Documentation]    Valida respuesta contra schema JSON almacenado en archivo
    ...                Requiere path relativo desde la raíz del proyecto
    [Arguments]    ${response}    ${schema_file}
    ${schema_path}=    Set Variable    ${EXECDIR}/api_tests/schemas/${schema_file}
    ${schema_content}=    Get File    ${schema_path}
    ${schema}=    Evaluate    json.loads('''${schema_content}''')    json
    ${json}=    Set Variable    ${response.json()}
    # Validación básica de estructura
    ${is_valid}=    Run Keyword And Return Status    
    ...    Validate Dictionary Structure    ${json}    ${schema}
    Should Be True    ${is_valid}    msg=❌ Response no cumple con el schema esperado
    Log    ✅ Response cumple con el schema    console=${TRUE}

Validate Dictionary Structure
    [Documentation]    Valida estructura básica de un diccionario contra schema
    ...                Verifica presencia de campos requeridos
    [Arguments]    ${data}    ${schema}
    ${required_fields}=    Get From Dictionary    ${schema}    required
    FOR    ${field}    IN    @{required_fields}
        Dictionary Should Contain Key    ${data}    ${field}
    END

# ==================== CLEANUP HELPERS ====================

Cleanup Test Objects
    [Documentation]    Limpia objetos creados durante el test
    ...                Acepta lista de IDs a eliminar
    [Arguments]    @{object_ids}
    FOR    ${id}    IN    @{object_ids}
        ${status}=    Run Keyword And Return Status
        ...    DELETE Request    /objects/${id}    expected_status=any
        Run Keyword If    ${status}    Log    ✅ Objeto ${id} eliminado    console=${TRUE}
        ...    ELSE    Log    ⚠️ No se pudo eliminar objeto ${id}    console=${TRUE}
    END

# ==================== ASSERTION HELPERS ====================

Assert Equals
    [Documentation]    Assertion genérica con mensaje personalizado
    [Arguments]    ${actual}    ${expected}    ${message}=Valores no coinciden
    Should Be Equal    ${actual}    ${expected}    msg=❌ ${message}
    Log    ✅ ${message}: ${actual}    console=${TRUE}

Assert Greater Than
    [Documentation]    Valida que un valor sea mayor que otro
    [Arguments]    ${value}    ${minimum}    ${message}=Valor no es mayor
    Should Be True    ${value} > ${minimum}
    ...    msg=❌ ${message}: ${value} <= ${minimum}
    Log    ✅ ${message}: ${value} > ${minimum}    console=${TRUE}

Assert Contains
    [Documentation]    Valida que una cadena contenga un substring
    [Arguments]    ${string}    ${substring}    ${message}=String no contiene substring
    Should Contain    ${string}    ${substring}
    ...    msg=❌ ${message}: '${substring}' no encontrado en '${string}'
    Log    ✅ ${message}: '${substring}' encontrado    console=${TRUE}

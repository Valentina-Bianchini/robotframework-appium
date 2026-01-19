*** Settings ***
Documentation    Variables de configuración global para la suite de tests
...              Organiza endpoints, URLs y configuraciones de entorno

*** Variables ***
# ==================== ENVIRONMENT CONFIGURATION ====================

# Entornos disponibles
${ENV}                      ${ENV_DEV}
${ENV_DEV}                  development
${ENV_STAGING}              staging
${ENV_PROD}                 production

# URLs por entorno
${BASE_URL_DEV}             https://api.restful-api.dev
${BASE_URL_STAGING}         https://api.restful-api.dev
${BASE_URL_PROD}            https://api.restful-api.dev

# ==================== API ENDPOINTS ====================

# Base endpoints
${ENDPOINT_OBJECTS}         /objects
${ENDPOINT_OBJECT_BY_ID}    /objects/{id}

# Query parameters
${PARAM_ID}                 id

# ==================== HTTP METHODS ====================

${METHOD_GET}               GET
${METHOD_POST}              POST
${METHOD_PUT}               PUT
${METHOD_PATCH}             PATCH
${METHOD_DELETE}            DELETE

# ==================== CONTENT TYPES ====================

${CONTENT_TYPE_JSON}        application/json
${CONTENT_TYPE_XML}         application/xml
${CONTENT_TYPE_FORM}        application/x-www-form-urlencoded

# ==================== STATUS CODES ====================

# Success codes
${HTTP_200_OK}              200
${HTTP_201_CREATED}         201
${HTTP_204_NO_CONTENT}      204

# Client error codes
${HTTP_400_BAD_REQUEST}     400
${HTTP_401_UNAUTHORIZED}    401
${HTTP_403_FORBIDDEN}       403
${HTTP_404_NOT_FOUND}       404
${HTTP_405_METHOD_NOT_ALLOWED}    405
${HTTP_422_UNPROCESSABLE}   422

# Server error codes
${HTTP_500_SERVER_ERROR}    500
${HTTP_502_BAD_GATEWAY}     502
${HTTP_503_UNAVAILABLE}     503

# ==================== TIMEOUTS ====================

${TIMEOUT_SHORT}            5
${TIMEOUT_MEDIUM}           15
${TIMEOUT_LONG}             30
${TIMEOUT_VERY_LONG}        60

# ==================== RETRY CONFIGURATION ====================

${MAX_RETRIES}              3
${RETRY_DELAY}              2

# ==================== LOGGING ====================

${LOG_LEVEL}                INFO
${LOG_LEVEL_DEBUG}          DEBUG
${LOG_LEVEL_TRACE}          TRACE

# ==================== TEST EXECUTION ====================

${RUN_PARALLEL}             ${FALSE}
${STOP_ON_FAILURE}          ${FALSE}
${CONTINUE_ON_ERROR}        ${TRUE}

# ==================== SCREENSHOTS ====================

${SCREENSHOT_ON_FAILURE}    ${TRUE}
${SCREENSHOT_DIR}           ${EXECDIR}/api_tests/reports/screenshots

# ==================== REPORT CONFIGURATION ====================

${REPORT_DIR}               ${EXECDIR}/api_tests/reports
${REPORT_TITLE}             API Test Results - Restful API
${LOG_TITLE}                Detailed Test Execution Log

# ==================== POSTMAN CONFIGURATION ====================

${POSTMAN_WORKSPACE_NAME}   Restful API Tests
${POSTMAN_COLLECTION_NAME}  Restful API Collection
${POSTMAN_ENV_NAME}         Restful API Environment

# IDs (se completarán dinámicamente)
${POSTMAN_WORKSPACE_ID}     ${EMPTY}
${POSTMAN_COLLECTION_ID}    ${EMPTY}
${POSTMAN_ENV_ID}           ${EMPTY}

# ==================== DATA GENERATION ====================

${GENERATE_RANDOM_DATA}     ${TRUE}
${USE_MOCK_DATA}            ${TRUE}

# ==================== VALIDATION RULES ====================

${STRICT_VALIDATION}        ${TRUE}
${VALIDATE_SCHEMA}          ${TRUE}
${VALIDATE_TYPES}           ${TRUE}
${VALIDATE_REQUIRED}        ${TRUE}

# ==================== CLEANUP ====================

${AUTO_CLEANUP}             ${TRUE}
${CLEANUP_ON_FAILURE}       ${TRUE}
${PRESERVE_TEST_DATA}       ${FALSE}

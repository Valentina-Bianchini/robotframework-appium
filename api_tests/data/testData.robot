*** Settings ***
Documentation    Datos de prueba para tests de API
...              Contiene objetos de ejemplo, IDs y valores de test

*** Variables ***
# ==================== TEST OBJECTS ====================

# IDs de objetos reservados (mock data)
${OBJECT_ID_1}              1
${OBJECT_ID_2}              2
${OBJECT_ID_3}              3
${OBJECT_ID_INVALID}        999999
${OBJECT_ID_NONEXISTENT}    12345678

# Nombres de objetos de prueba
${OBJECT_NAME_PHONE}        iPhone 15 Pro Max
${OBJECT_NAME_LAPTOP}       Apple MacBook Pro 16
${OBJECT_NAME_TABLET}       iPad Pro 12.9
${OBJECT_NAME_WATCH}        Apple Watch Series 9
${OBJECT_NAME_HEADPHONES}   AirPods Pro 2

# ==================== OBJECT DATA EXAMPLES ====================

# Datos para smartphones
&{DATA_IPHONE_15}
...    color=Natural Titanium
...    capacity=512 GB
...    price=1199.99
...    year=2024

&{DATA_IPHONE_14}
...    color=Deep Purple
...    capacity=256 GB
...    price=899.99
...    year=2023

# Datos para laptops
&{DATA_MACBOOK_PRO}
...    color=Space Gray
...    RAM=32 GB
...    storage=1 TB SSD
...    processor=Apple M3 Max
...    year=2024
...    price=3499.99

&{DATA_MACBOOK_AIR}
...    color=Midnight
...    RAM=16 GB
...    storage=512 GB SSD
...    processor=Apple M2
...    year=2023
...    price=1499.99

# Datos para tablets
&{DATA_IPAD_PRO}
...    color=Silver
...    storage=256 GB
...    screen_size=12.9 inches
...    year=2024
...    price=1099.99

# Datos para wearables
&{DATA_APPLE_WATCH}
...    color=Midnight Aluminum
...    size=45mm
...    connectivity=GPS + Cellular
...    year=2024
...    price=499.99

# Datos para audio
&{DATA_AIRPODS_PRO}
...    color=White
...    noise_cancellation=${TRUE}
...    spatial_audio=${TRUE}
...    year=2024
...    price=249.99

# ==================== INVALID TEST DATA ====================

# Nombres inválidos
${EMPTY_NAME}               ${EMPTY}
${NULL_NAME}                ${NONE}

# Datos inválidos
&{INVALID_DATA_MISSING_FIELDS}
...    incomplete=true

&{INVALID_DATA_WRONG_TYPES}
...    price=not_a_number
...    year=invalid_year

# ==================== QUERY PARAMETERS ====================

# Para búsquedas por múltiples IDs
@{QUERY_IDS_VALID}          1    2    3    4    5
@{QUERY_IDS_MIXED}          1    ${OBJECT_ID_INVALID}    3
@{QUERY_IDS_ALL_INVALID}    ${OBJECT_ID_INVALID}    999998    999997

# ==================== EXPECTED VALUES ====================

# Objetos mock conocidos (para validación)
${EXPECTED_NAME_ID_1}       Google Pixel 6 Pro
${EXPECTED_NAME_ID_2}       Apple iPhone 12 Mini, 256GB, Blue
${EXPECTED_NAME_ID_3}       Apple iPhone 12 Pro Max

# Contadores esperados
${MIN_OBJECTS_IN_LIST}      10
${MAX_OBJECTS_IN_LIST}      1000

# ==================== UPDATE TEST DATA ====================

# Datos para actualizaciones PUT (completas)
&{UPDATE_DATA_COMPLETE}
...    name=iPhone 15 Pro - Updated
...    data=&{DATA_IPHONE_15}

# Datos para actualizaciones PATCH (parciales)
&{PATCH_DATA_PRICE_ONLY}
...    price=999.99

&{PATCH_DATA_COLOR_ONLY}
...    color=Blue Titanium

# ==================== PERFORMANCE THRESHOLDS ====================

${MAX_RESPONSE_TIME_GET}        1.5
${MAX_RESPONSE_TIME_POST}       2.0
${MAX_RESPONSE_TIME_PUT}        2.0
${MAX_RESPONSE_TIME_DELETE}     1.5
${MAX_RESPONSE_TIME_LIST}       3.0

# ==================== PAGINATION ====================

${DEFAULT_PAGE_SIZE}        10
${MAX_PAGE_SIZE}            100
${MIN_PAGE_SIZE}            1

# ==================== ERROR MESSAGES ====================

${ERROR_NOT_FOUND}              404
${ERROR_BAD_REQUEST}            400
${ERROR_INTERNAL_SERVER}        500

${MSG_OBJECT_NOT_FOUND}         Oject with id=[0-9]+ was not found
${MSG_INVALID_REQUEST}          Invalid request
${MSG_MISSING_FIELD}            required field

# ==================== TEST CATEGORIES ====================

@{TAGS_SMOKE}               smoke    critical    quick
@{TAGS_CRUD}                crud    integration    e2e
@{TAGS_VALIDATION}          validation    schema    data_quality
@{TAGS_NEGATIVE}            negative    error_handling    edge_case
@{TAGS_PERFORMANCE}         performance    timing    sla

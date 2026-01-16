*** Settings ***
Documentation    📊 Datos de prueba para BlazeDemo.com
...             Contiene todas las variables y datos necesarios para los tests

*** Variables ***
# 🌐 URLs de la aplicación
${BLAZEDEMO_URL}            https://blazedemo.com
${BLAZEDEMO_HOME}           ${BLAZEDEMO_URL}/index.php
${BLAZEDEMO_RESERVE}        ${BLAZEDEMO_URL}/reserve.php
${BLAZEDEMO_PURCHASE}       ${BLAZEDEMO_URL}/purchase.php
${BLAZEDEMO_CONFIRMATION}   ${BLAZEDEMO_URL}/confirmation.php

# 🏙️ Ciudades de origen disponibles
@{DEPARTURE_CITIES}         Boston
...                         Portland
...                         Philadelphia
...                         San Diego
...                         Mexico City
...                         São Paolo
...                         Paris

# 🌍 Ciudades de destino disponibles  
@{DESTINATION_CITIES}       Buenos Aires
...                         Rome
...                         London
...                         Berlin
...                         New York
...                         Dublin
...                         Cairo

# 👤 Datos de pasajeros de prueba
${TEST_NAME}                John Doe
${TEST_ADDRESS}             123 Test Street
${TEST_CITY}                Test City
${TEST_STATE}               TS
${TEST_ZIP}                 12345
${TEST_CARD_TYPE}           Visa
${TEST_CARD_NUMBER}         4111111111111111
${TEST_CARD_MONTH}          12
${TEST_CARD_YEAR}           2026
${TEST_NAME_ON_CARD}        John Doe

# 👤 Datos alternativos para tests adicionales
${TEST_NAME_2}              Jane Smith
${TEST_ADDRESS_2}           456 Demo Avenue
${TEST_CITY_2}              Demo City
${TEST_STATE_2}             DC
${TEST_ZIP_2}               54321
${TEST_CARD_NUMBER_2}       5555555555554444

# 💳 Tipos de tarjetas de crédito disponibles
@{CARD_TYPES}               Visa
...                         American Express
...                         Diner's Club

# ⏱️ Timeouts
${SHORT_TIMEOUT}            5s
${MEDIUM_TIMEOUT}           10s
${LONG_TIMEOUT}             30s

# 📋 Mensajes esperados
${SUCCESS_MESSAGE}          Thank you for your purchase today!
${PAGE_TITLE_HOME}          BlazeDemo
${PAGE_TITLE_RESERVE}       Flights from
${PAGE_TITLE_PURCHASE}      Your flight from
${PAGE_TITLE_CONFIRM}       BlazeDemo Confirmation

# 🎯 Datos inválidos para tests negativos
${INVALID_ZIP}              ABCDE
${INVALID_CARD}             1234
${EMPTY_VALUE}              ${EMPTY}
${SPECIAL_CHARS}            @#$%^&*()
${VERY_LONG_STRING}         ${"A" * 1000}

# 🔢 Índices de vuelos para selección
${FIRST_FLIGHT}             0
${SECOND_FLIGHT}            1
${THIRD_FLIGHT}             2
${LAST_FLIGHT}              -1

# 📱 Configuración Mobile
${MOBILE_WIDTH}             375
${MOBILE_HEIGHT}            667
${TABLET_WIDTH}             768
${TABLET_HEIGHT}            1024

*** Settings ***
Documentation    ✅ Page Object para la página de confirmación
...             Contiene todos los elementos y keywords de la página de confirmación de compra

Library          SeleniumLibrary
Library          String
Resource         ../data/locators.robot
Resource         ../data/testData.robot

Suite Setup      Initialize Purchase Details Suite Variable

*** Variables ***
${PURCHASE_DETAILS}    ${EMPTY}

*** Keywords ***
Initialize Purchase Details Suite Variable
    [Documentation]    Inicializa la variable de suite de detalles de compra
    ${empty_details}=    Create Dictionary
    ...    confirmation_code=${EMPTY}
    ...    status=${EMPTY}
    ...    amount=${EMPTY}
    ...    card_number=${EMPTY}
    ...    expiration=${EMPTY}
    ...    auth_code=${EMPTY}
    ...    timestamp=${EMPTY}
    Set Suite Variable    ${PURCHASE_DETAILS}    ${empty_details}

Verify Confirmation Page Is Displayed
    [Documentation]    Verifica que la página de confirmación está visible
    Wait Until Page Contains Element    ${CONFIRM_PAGE_HEADING}    ${MEDIUM_TIMEOUT}
    Element Should Be Visible    ${CONFIRM_TABLE}
    Location Should Contain    confirmation.php

Verify Success Message
    [Documentation]    Verifica el mensaje de éxito
    ${message}=    Get Text    ${CONFIRM_SUCCESS_MESSAGE}
    Should Contain    ${message}    ${SUCCESS_MESSAGE}
    Log    Confirmation message: ${message}

Get Confirmation Code
    [Documentation]    Obtiene el código de confirmación
    ${code}=    Get Text    ${CONFIRM_CONFIRMATION_CODE}
    Should Not Be Empty    ${code}
    Log    Confirmation code: ${code}
    RETURN    ${code}

Get Purchase Status
    [Documentation]    Obtiene el estado de la compra
    ${status}=    Get Text    ${CONFIRM_STATUS}
    Log    Purchase status: ${status}
    RETURN    ${status}

Get Total Amount
    [Documentation]    Obtiene el monto total pagado
    ${amount}=    Get Text    ${CONFIRM_AMOUNT}
    Should Not Be Empty    ${amount}
    Log    Total amount: ${amount}
    RETURN    ${amount}

Get Card Number
    [Documentation]    Obtiene el número de tarjeta (parcialmente oculto)
    ${card}=    Get Text    ${CONFIRM_CARD_NUMBER}
    Should Not Be Empty    ${card}
    Log    Card number: ${card}
    RETURN    ${card}

Get Card Expiration
    [Documentation]    Obtiene la fecha de expiración de la tarjeta
    ${expiration}=    Get Text    ${CONFIRM_EXPIRATION}
    Should Not Be Empty    ${expiration}
    Log    Card expiration: ${expiration}
    RETURN    ${expiration}

Get Authorization Code
    [Documentation]    Obtiene el código de autorización
    ${auth_code}=    Get Text    ${CONFIRM_AUTH_CODE}
    Should Not Be Empty    ${auth_code}
    Log    Authorization code: ${auth_code}
    RETURN    ${auth_code}

Get Transaction Timestamp
    [Documentation]    Obtiene la fecha/hora de la transacción
    ${timestamp}=    Get Text    ${CONFIRM_TIMESTAMP}
    Should Not Be Empty    ${timestamp}
    Log    Transaction timestamp: ${timestamp}
    RETURN    ${timestamp}

Verify Purchase Status Is Success
    [Documentation]    Verifica que el estado de compra es exitoso
    ${status}=    Get Purchase Status
    Should Contain    ${status}    PendingCapture    ignore_case=True

Verify Confirmation Code Is Generated
    [Documentation]    Verifica que se generó un código de confirmación
    ${code}=    Get Confirmation Code
    Should Match Regexp    ${code}    ^[A-Z0-9]+$
    ${code_length}=    Get Length    ${code}
    Should Be True    ${code_length} > 0

Verify Authorization Code Is Generated
    [Documentation]    Verifica que se generó un código de autorización
    ${auth_code}=    Get Authorization Code
    Should Not Be Equal    ${auth_code}    ${EMPTY}
    ${auth_length}=    Get Length    ${auth_code}
    Should Be True    ${auth_length} > 0

Verify Amount Matches Expected
    [Documentation]    Verifica que el monto coincide con el esperado
    [Arguments]    ${expected_amount}
    ${actual_amount}=    Get Total Amount
    Should Contain    ${actual_amount}    ${expected_amount}

Get All Purchase Details
    [Documentation]    Obtiene todos los detalles de la compra en un diccionario
    &{details}=    Create Dictionary
    ...    confirmation_code=${EMPTY}
    ...    status=${EMPTY}
    ...    amount=${EMPTY}
    ...    card_number=${EMPTY}
    ...    expiration=${EMPTY}
    ...    auth_code=${EMPTY}
    ...    timestamp=${EMPTY}
    
    ${details.confirmation_code}=    Get Confirmation Code
    ${details.status}=    Get Purchase Status
    ${details.amount}=    Get Total Amount
    ${details.card_number}=    Get Card Number
    ${details.expiration}=    Get Card Expiration
    ${details.auth_code}=    Get Authorization Code
    ${details.timestamp}=    Get Transaction Timestamp
    
    Log    Purchase details: ${details}
    RETURN    &{details}

Verify All Required Fields Are Present
    [Documentation]    Verifica que todos los campos requeridos están presentes
    Element Should Be Visible    ${CONFIRM_CONFIRMATION_CODE}
    Element Should Be Visible    ${CONFIRM_STATUS}
    Element Should Be Visible    ${CONFIRM_AMOUNT}
    Element Should Be Visible    ${CONFIRM_CARD_NUMBER}
    Element Should Be Visible    ${CONFIRM_EXPIRATION}
    Element Should Be Visible    ${CONFIRM_AUTH_CODE}
    Element Should Be Visible    ${CONFIRM_TIMESTAMP}

Verify Card Number Is Masked
    [Documentation]    Verifica que el número de tarjeta está parcialmente oculto
    ${card}=    Get Card Number
    Should Contain    ${card}    x    ignore_case=True

Verify Timestamp Format Is Valid
    [Documentation]    Verifica que el timestamp tiene un formato válido
    ${timestamp}=    Get Transaction Timestamp
    # Formato esperado: YYYY-MM-DD HH:MM:SS o similar
    Should Match Regexp    ${timestamp}    \\d+

Save Purchase Details To Suite Variable
    [Documentation]    Guarda los detalles de compra en variable de suite
    &{details}=    Get All Purchase Details
    Set Suite Variable    ${PURCHASE_DETAILS}    ${details}
    Log    Saved purchase details to suite variable

Log All Purchase Details
    [Documentation]    Registra todos los detalles de la compra en el log
    &{details}=    Get All Purchase Details
    Log    ========================================
    Log    PURCHASE CONFIRMATION DETAILS
    Log    ========================================
    Log    Confirmation Code: ${details.confirmation_code}
    Log    Status: ${details.status}
    Log    Amount: ${details.amount}
    Log    Card Number: ${details.card_number}
    Log    Expiration: ${details.expiration}
    Log    Auth Code: ${details.auth_code}
    Log    Timestamp: ${details.timestamp}
    Log    ========================================

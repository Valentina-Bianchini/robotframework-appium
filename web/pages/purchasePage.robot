*** Settings ***
Documentation    💳 Page Object para la página de compra/pago
...             Contiene todos los elementos y keywords del formulario de compra

Library          SeleniumLibrary
Resource         ../data/locators.robot
Resource         ../data/testData.robot

*** Keywords ***
Verify Purchase Page Is Displayed
    [Documentation]    Verifica que la página de compra está visible
    Wait Until Page Contains Element    ${PURCHASE_PAGE_HEADING}    ${MEDIUM_TIMEOUT}
    Element Should Be Visible    ${PURCHASE_NAME_INPUT}
    Location Should Contain    purchase.php

Verify Flight Details Are Shown
    [Documentation]    Verifica que los detalles del vuelo están visibles
    Element Should Be Visible    ${PURCHASE_FLIGHT_DETAILS}
    Element Should Be Visible    ${PURCHASE_TOTAL_COST}

Get Total Cost
    [Documentation]    Obtiene el costo total del vuelo
    ${cost}=    Get Text    ${PURCHASE_TOTAL_COST}
    Log    Total cost: ${cost}
    [Return]    ${cost}

Fill Personal Information
    [Documentation]    Llena los campos de información personal
    [Arguments]    ${name}    ${address}    ${city}    ${state}    ${zip}
    
    Wait Until Element Is Visible    ${PURCHASE_NAME_INPUT}    ${MEDIUM_TIMEOUT}
    Input Text    ${PURCHASE_NAME_INPUT}    ${name}
    Input Text    ${PURCHASE_ADDRESS_INPUT}    ${address}
    Input Text    ${PURCHASE_CITY_INPUT}    ${city}
    Input Text    ${PURCHASE_STATE_INPUT}    ${state}
    Input Text    ${PURCHASE_ZIP_INPUT}    ${zip}
    
    Log    Filled personal information for: ${name}

Fill Payment Information
    [Documentation]    Llena los campos de información de pago
    [Arguments]    ${card_type}    ${card_number}    ${card_month}    ${card_year}    ${name_on_card}
    
    Select From List By Label    ${PURCHASE_CARD_TYPE_SELECT}    ${card_type}
    Input Text    ${PURCHASE_CARD_NUMBER_INPUT}    ${card_number}
    Input Text    ${PURCHASE_CARD_MONTH_INPUT}    ${card_month}
    Input Text    ${PURCHASE_CARD_YEAR_INPUT}    ${card_year}
    Input Text    ${PURCHASE_NAME_ON_CARD_INPUT}    ${name_on_card}
    
    Log    Filled payment information with card type: ${card_type}

Fill Complete Purchase Form
    [Documentation]    Llena el formulario completo de compra con datos por defecto
    Fill Personal Information
    ...    ${TEST_NAME}
    ...    ${TEST_ADDRESS}
    ...    ${TEST_CITY}
    ...    ${TEST_STATE}
    ...    ${TEST_ZIP}
    
    Fill Payment Information
    ...    ${TEST_CARD_TYPE}
    ...    ${TEST_CARD_NUMBER}
    ...    ${TEST_CARD_MONTH}
    ...    ${TEST_CARD_YEAR}
    ...    ${TEST_NAME_ON_CARD}

Fill Complete Purchase Form With Custom Data
    [Documentation]    Llena el formulario completo con datos personalizados
    [Arguments]    &{user_data}
    
    Fill Personal Information
    ...    ${user_data.name}
    ...    ${user_data.address}
    ...    ${user_data.city}
    ...    ${user_data.state}
    ...    ${user_data.zip}
    
    Fill Payment Information
    ...    ${user_data.card_type}
    ...    ${user_data.card_number}
    ...    ${user_data.card_month}
    ...    ${user_data.card_year}
    ...    ${user_data.name_on_card}

Check Remember Me Checkbox
    [Documentation]    Marca el checkbox "Remember Me"
    Select Checkbox    ${PURCHASE_REMEMBER_CHECKBOX}
    Checkbox Should Be Selected    ${PURCHASE_REMEMBER_CHECKBOX}

Uncheck Remember Me Checkbox
    [Documentation]    Desmarca el checkbox "Remember Me"
    Unselect Checkbox    ${PURCHASE_REMEMBER_CHECKBOX}
    Checkbox Should Not Be Selected    ${PURCHASE_REMEMBER_CHECKBOX}

Click Purchase Flight Button
    [Documentation]    Hace click en el botón "Purchase Flight"
    Click Button    ${PURCHASE_SUBMIT_BTN}
    Wait Until Location Contains    confirmation.php    ${MEDIUM_TIMEOUT}

Verify Form Fields Are Empty
    [Documentation]    Verifica que los campos del formulario están vacíos
    ${name_value}=    Get Value    ${PURCHASE_NAME_INPUT}
    Should Be Empty    ${name_value}
    
    ${address_value}=    Get Value    ${PURCHASE_ADDRESS_INPUT}
    Should Be Empty    ${address_value}
    
    ${city_value}=    Get Value    ${PURCHASE_CITY_INPUT}
    Should Be Empty    ${city_value}

Verify Form Fields Are Filled
    [Documentation]    Verifica que los campos del formulario están llenos
    ${name_value}=    Get Value    ${PURCHASE_NAME_INPUT}
    Should Not Be Empty    ${name_value}
    
    ${address_value}=    Get Value    ${PURCHASE_ADDRESS_INPUT}
    Should Not Be Empty    ${address_value}
    
    ${city_value}=    Get Value    ${PURCHASE_CITY_INPUT}
    Should Not Be Empty    ${city_value}

Get Selected Card Type
    [Documentation]    Obtiene el tipo de tarjeta seleccionado
    ${card_type}=    Get Selected List Label    ${PURCHASE_CARD_TYPE_SELECT}
    [Return]    ${card_type}

Get All Card Types
    [Documentation]    Obtiene todos los tipos de tarjeta disponibles
    @{card_types}=    Get List Items    ${PURCHASE_CARD_TYPE_SELECT}
    [Return]    @{card_types}

Clear Personal Information Fields
    [Documentation]    Limpia todos los campos de información personal
    Clear Element Text    ${PURCHASE_NAME_INPUT}
    Clear Element Text    ${PURCHASE_ADDRESS_INPUT}
    Clear Element Text    ${PURCHASE_CITY_INPUT}
    Clear Element Text    ${PURCHASE_STATE_INPUT}
    Clear Element Text    ${PURCHASE_ZIP_INPUT}

Clear Payment Information Fields
    [Documentation]    Limpia todos los campos de información de pago
    Clear Element Text    ${PURCHASE_CARD_NUMBER_INPUT}
    Clear Element Text    ${PURCHASE_CARD_MONTH_INPUT}
    Clear Element Text    ${PURCHASE_CARD_YEAR_INPUT}
    Clear Element Text    ${PURCHASE_NAME_ON_CARD_INPUT}

Verify Purchase Button Is Enabled
    [Documentation]    Verifica que el botón de compra está habilitado
    Element Should Be Enabled    ${PURCHASE_SUBMIT_BTN}

Get Name Input Value
    [Documentation]    Obtiene el valor del campo de nombre
    ${value}=    Get Value    ${PURCHASE_NAME_INPUT}
    [Return]    ${value}

Get Card Number Input Value
    [Documentation]    Obtiene el valor del campo de número de tarjeta
    ${value}=    Get Value    ${PURCHASE_CARD_NUMBER_INPUT}
    [Return]    ${value}

Verify Required Fields Are Present
    [Documentation]    Verifica que todos los campos requeridos están presentes
    Element Should Be Visible    ${PURCHASE_NAME_INPUT}
    Element Should Be Visible    ${PURCHASE_ADDRESS_INPUT}
    Element Should Be Visible    ${PURCHASE_CITY_INPUT}
    Element Should Be Visible    ${PURCHASE_STATE_INPUT}
    Element Should Be Visible    ${PURCHASE_ZIP_INPUT}
    Element Should Be Visible    ${PURCHASE_CARD_TYPE_SELECT}
    Element Should Be Visible    ${PURCHASE_CARD_NUMBER_INPUT}
    Element Should Be Visible    ${PURCHASE_CARD_MONTH_INPUT}
    Element Should Be Visible    ${PURCHASE_CARD_YEAR_INPUT}
    Element Should Be Visible    ${PURCHASE_NAME_ON_CARD_INPUT}
    Element Should Be Visible    ${PURCHASE_SUBMIT_BTN}

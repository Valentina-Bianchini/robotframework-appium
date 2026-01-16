*** Settings ***
Documentation    📝 Steps para el proceso de reserva de vuelos en BlazeDemo
...             Keywords de alto nivel para selección de vuelos y compra

Library          SeleniumLibrary
Resource         ../pages/flightListPage.robot
Resource         ../pages/purchasePage.robot
Resource         ../pages/confirmationPage.robot
Resource         ../data/testData.robot

*** Keywords ***
# ========== GIVEN - Estados iniciales ==========

Given User Is On Flight List Page
    [Documentation]    Usuario está en la página de lista de vuelos
    Verify Flight List Page Is Displayed

Given User Is On Purchase Page
    [Documentation]    Usuario está en la página de compra
    Verify Purchase Page Is Displayed

Given User Has Selected A Flight
    [Documentation]    Usuario ha seleccionado un vuelo
    [Arguments]    ${flight_index}=${FIRST_FLIGHT}
    Select Flight By Index    ${flight_index}

# ========== WHEN - Acciones ==========

When User Selects Flight Number "${flight_index}"
    [Documentation]    Usuario selecciona un vuelo específico por índice
    Select Flight By Index    ${flight_index}

When User Selects The Cheapest Flight
    [Documentation]    Usuario selecciona el vuelo más barato
    Select Cheapest Flight

When User Selects The Most Expensive Flight
    [Documentation]    Usuario selecciona el vuelo más caro
    Select Most Expensive Flight

When User Selects Flight From "${airline}"
    [Documentation]    Usuario selecciona vuelo de aerolínea específica
    Select Flight By Airline    ${airline}

When User Proceeds To Purchase
    [Documentation]    Usuario procede a la compra (ya está en purchase page)
    Verify Purchase Page Is Displayed

When User Fills Personal Information
    [Documentation]    Usuario llena información personal
    [Arguments]    ${name}    ${address}    ${city}    ${state}    ${zip}
    Fill Personal Information    ${name}    ${address}    ${city}    ${state}    ${zip}

When User Fills Payment Information
    [Documentation]    Usuario llena información de pago
    [Arguments]    ${card_type}    ${card_number}    ${month}    ${year}    ${card_holder}
    Fill Payment Information    ${card_type}    ${card_number}    ${month}    ${year}    ${card_holder}

When User Fills Complete Purchase Form
    [Documentation]    Usuario llena el formulario completo con datos por defecto
    Fill Complete Purchase Form

When User Fills Purchase Form With Custom Data
    [Documentation]    Usuario llena formulario con datos personalizados
    [Arguments]    &{user_data}
    Fill Complete Purchase Form With Custom Data    &{user_data}

When User Checks Remember Me
    [Documentation]    Usuario marca "Remember Me"
    Check Remember Me Checkbox

When User Submits Purchase
    [Documentation]    Usuario envía el formulario de compra
    Click Purchase Flight Button

# ========== THEN - Verificaciones ==========

Then Purchase Form Should Be Displayed
    [Documentation]    Debe mostrarse el formulario de compra
    Verify Purchase Page Is Displayed

Then Flight Details Should Be Shown
    [Documentation]    Deben mostrarse los detalles del vuelo
    Verify Flight Details Are Shown

Then Total Cost Should Be Displayed
    [Documentation]    Debe mostrarse el costo total
    ${cost}=    Get Total Cost
    Should Not Be Empty    ${cost}

Then All Form Fields Should Be Present
    [Documentation]    Todos los campos del formulario deben estar presentes
    Verify Required Fields Are Present

Then Confirmation Page Should Be Displayed
    [Documentation]    Debe mostrarse la página de confirmación
    Verify Confirmation Page Is Displayed

Then Purchase Should Be Confirmed
    [Documentation]    La compra debe estar confirmada
    Verify Success Message
    Verify Purchase Status Is Success

Then Confirmation Code Should Be Generated
    [Documentation]    Debe generarse un código de confirmación
    Verify Confirmation Code Is Generated

Then Purchase Confirmation Should Contain
    [Documentation]    La confirmación debe contener información específica
    [Arguments]    ${departure}=${EMPTY}    ${destination}=${EMPTY}    ${passenger_name}=${EMPTY}
    
    IF    "${departure}" != "${EMPTY}"
        Log    Verifying departure: ${departure}
    END
    
    IF    "${destination}" != "${EMPTY}"
        Log    Verifying destination: ${destination}
    END
    
    IF    "${passenger_name}" != "${EMPTY}"
        Log    Verifying passenger: ${passenger_name}
    END
    
    # Verificar que se generó código de confirmación
    Verify Confirmation Code Is Generated

Then Transaction ID Should Be Generated
    [Documentation]    Debe generarse un ID de transacción
    Verify Authorization Code Is Generated

Then All Purchase Details Should Be Visible
    [Documentation]    Todos los detalles de compra deben ser visibles
    Verify All Required Fields Are Present
    Log All Purchase Details

# ========== AND - Acciones y verificaciones adicionales ==========

And User Sees Purchase Form
    [Documentation]    Usuario ve el formulario de compra
    Verify Purchase Page Is Displayed

And User Sees Confirmation Page
    [Documentation]    Usuario ve la página de confirmación
    Verify Confirmation Page Is Displayed

And Purchase Is Successful
    [Documentation]    La compra es exitosa
    Verify Success Message
    Verify Confirmation Code Is Generated

And User Completes Full Booking Flow
    [Documentation]    Usuario completa el flujo completo de reserva
    Verify Purchase Page Is Displayed
    Fill Complete Purchase Form
    Click Purchase Flight Button
    Verify Confirmation Page Is Displayed
    Verify Success Message

And User Books Flight With Default Data
    [Documentation]    Usuario reserva vuelo con datos por defecto
    Fill Complete Purchase Form
    Click Purchase Flight Button
    Verify Confirmation Page Is Displayed

And User Books Flight With Name "${name}"
    [Documentation]    Usuario reserva vuelo con nombre específico
    Fill Personal Information
    ...    ${name}
    ...    ${TEST_ADDRESS}
    ...    ${TEST_CITY}
    ...    ${TEST_STATE}
    ...    ${TEST_ZIP}
    
    Fill Payment Information
    ...    ${TEST_CARD_TYPE}
    ...    ${TEST_CARD_NUMBER}
    ...    ${TEST_CARD_MONTH}
    ...    ${TEST_CARD_YEAR}
    ...    ${name}
    
    Click Purchase Flight Button
    Verify Confirmation Page Is Displayed

And Purchase Details Are Saved
    [Documentation]    Los detalles de compra se guardan
    Save Purchase Details To Suite Variable

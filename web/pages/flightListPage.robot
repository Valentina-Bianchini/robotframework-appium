*** Settings ***
Documentation    ✈️ Page Object para la página de lista de vuelos
...             Contiene todos los elementos y keywords de la página de resultados

Library          SeleniumLibrary
Library          Collections
Resource         ../data/locators.robot
Resource         ../data/testData.robot

*** Variables ***
${SELECTED_FLIGHT}    ${EMPTY}

*** Keywords ***
Verify Flight List Page Is Displayed
    [Documentation]    Verifica que la página de lista de vuelos está visible
    Wait Until Page Contains Element    ${FLIGHTS_PAGE_HEADING}    ${MEDIUM_TIMEOUT}
    Element Should Be Visible    ${FLIGHTS_TABLE}
    Location Should Contain    reserve.php

Verify Page Shows Correct Route
    [Documentation]    Verifica que se muestran las ciudades correctas en el encabezado
    [Arguments]    ${departure}    ${destination}
    ${heading}=    Get Text    ${FLIGHTS_PAGE_HEADING}
    Should Contain    ${heading}    ${departure}
    Should Contain    ${heading}    ${destination}
    Log    Verified route: ${departure} to ${destination}

Get Number Of Available Flights
    [Documentation]    Obtiene el número de vuelos disponibles
    ${count}=    Get Element Count    ${FLIGHTS_TABLE_ROWS}
    Should Be True    ${count} > 0    No flights found
    RETURN    ${count}

Get Flight Details By Index
    [Documentation]    Obtiene los detalles de un vuelo por su índice (0-based)
    [Arguments]    ${index}
    ${row_index}=    Evaluate    ${index} + 1
    
    ${price}=    Get Text    xpath:(${FLIGHTS_TABLE_ROWS})[${row_index}]//td[1]
    ${number}=    Get Text    xpath:(${FLIGHTS_TABLE_ROWS})[${row_index}]//td[2]
    ${airline}=    Get Text    xpath:(${FLIGHTS_TABLE_ROWS})[${row_index}]//td[3]
    ${departure}=    Get Text    xpath:(${FLIGHTS_TABLE_ROWS})[${row_index}]//td[4]
    ${arrival}=    Get Text    xpath:(${FLIGHTS_TABLE_ROWS})[${row_index}]//td[5]
    
    &{flight_details}=    Create Dictionary
    ...    price=${price}
    ...    number=${number}
    ...    airline=${airline}
    ...    departure=${departure}
    ...    arrival=${arrival}
    
    Log    Flight ${index} details: ${flight_details}
    RETURN    &{flight_details}

Get All Flights Details
    [Documentation]    Obtiene los detalles de todos los vuelos disponibles
    ${flights_count}=    Get Number Of Available Flights
    @{all_flights}=    Create List
    
    FOR    ${i}    IN RANGE    ${flights_count}
        &{flight}=    Get Flight Details By Index    ${i}
        Append To List    ${all_flights}    ${flight}
    END
    
    RETURN    @{all_flights}

Select Flight By Index
    [Documentation]    Selecciona un vuelo por su índice (0-based)
    [Arguments]    ${index}
    ${row_index}=    Evaluate    ${index} + 1
    
    # Guardar detalles del vuelo antes de seleccionarlo
    &{flight_details}=    Get Flight Details By Index    ${index}
    Set Suite Variable    ${SELECTED_FLIGHT}    ${flight_details}
    
    # Click en el botón Choose This Flight
    Click Button    xpath:(${FLIGHTS_TABLE_ROWS})[${row_index}]//input[@type='submit']
    Wait Until Location Contains    purchase.php    ${MEDIUM_TIMEOUT}
    
    Log    Selected flight ${index}: ${flight_details}

Select Cheapest Flight
    [Documentation]    Selecciona el vuelo más barato
    @{flights}=    Get All Flights Details
    ${min_price}=    Set Variable    999999
    ${cheapest_index}=    Set Variable    0
    
    ${index}=    Set Variable    0
    FOR    ${flight}    IN    @{flights}
        ${price_text}=    Get From Dictionary    ${flight}    price
        ${price}=    Convert To Number    ${price_text.strip('$')}
        ${is_cheaper}=    Evaluate    ${price} < ${min_price}
        IF    ${is_cheaper}
            ${min_price}=    Set Variable    ${price}
            ${cheapest_index}=    Set Variable    ${index}
        END
        ${index}=    Evaluate    ${index} + 1
    END
    
    Log    Cheapest flight is at index ${cheapest_index} with price $${min_price}
    Select Flight By Index    ${cheapest_index}
    RETURN    ${cheapest_index}

Select Most Expensive Flight
    [Documentation]    Selecciona el vuelo más caro
    @{flights}=    Get All Flights Details
    ${max_price}=    Set Variable    0
    ${expensive_index}=    Set Variable    0
    
    ${index}=    Set Variable    0
    FOR    ${flight}    IN    @{flights}
        ${price_text}=    Get From Dictionary    ${flight}    price
        ${price}=    Convert To Number    ${price_text.strip('$')}
        ${is_more_expensive}=    Evaluate    ${price} > ${max_price}
        IF    ${is_more_expensive}
            ${max_price}=    Set Variable    ${price}
            ${expensive_index}=    Set Variable    ${index}
        END
        ${index}=    Evaluate    ${index} + 1
    END
    
    Log    Most expensive flight is at index ${expensive_index} with price $${max_price}
    Select Flight By Index    ${expensive_index}
    RETURN    ${expensive_index}

Select Flight By Airline
    [Documentation]    Selecciona el primer vuelo de una aerolínea específica
    [Arguments]    ${airline_name}
    ${flights_count}=    Get Number Of Available Flights
    
    FOR    ${i}    IN RANGE    ${flights_count}
        &{flight}=    Get Flight Details By Index    ${i}
        ${airline}=    Get From Dictionary    ${flight}    airline
        ${match}=    Run Keyword And Return Status    Should Contain    ${airline}    ${airline_name}
        IF    ${match}
            Select Flight By Index    ${i}
            Log    Selected flight from airline ${airline_name}
            RETURN
        END
    END
    
    Fail    No flight found for airline: ${airline_name}

Verify All Flights Have Required Fields
    [Documentation]    Verifica que todos los vuelos tienen los campos requeridos
    ${flights_count}=    Get Number Of Available Flights
    
    FOR    ${i}    IN RANGE    ${flights_count}
        &{flight}=    Get Flight Details By Index    ${i}
        Should Not Be Empty    ${flight.price}
        Should Not Be Empty    ${flight.number}
        Should Not Be Empty    ${flight.airline}
        Should Not Be Empty    ${flight.departure}
        Should Not Be Empty    ${flight.arrival}
    END
    
    Log    All ${flights_count} flights have required fields

Verify Prices Are In Valid Range
    [Documentation]    Verifica que los precios están en un rango válido
    [Arguments]    ${min_price}=0    ${max_price}=10000
    @{flights}=    Get All Flights Details
    
    FOR    ${flight}    IN    @{flights}
        ${price_text}=    Get From Dictionary    ${flight}    price
        ${price}=    Convert To Number    ${price_text.strip('$')}
        Should Be True    ${price} >= ${min_price}
        Should Be True    ${price} <= ${max_price}
    END
    
    Log    All prices are within range: $${min_price} - $${max_price}

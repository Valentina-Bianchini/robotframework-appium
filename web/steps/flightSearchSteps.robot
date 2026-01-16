*** Settings ***
Documentation    🔍 Steps para búsqueda de vuelos en BlazeDemo
...             Keywords de alto nivel usando sintaxis BDD (Given/When/Then)

Library          SeleniumLibrary
Resource         ../pages/homePage.robot
Resource         ../pages/flightListPage.robot

*** Keywords ***
# ========== GIVEN - Estados iniciales ==========

Given User Is On BlazeDemo Home Page
    [Documentation]    Usuario está en la página principal de BlazeDemo
    Navigate To BlazeDemo Home Page
    Verify Home Page Is Displayed

Given User Has Selected Cities
    [Documentation]    Usuario ha seleccionado ciudades de origen y destino
    [Arguments]    ${departure}    ${destination}
    Select Departure City    ${departure}
    Select Destination City    ${destination}

# ========== WHEN - Acciones ==========

When User Searches Flight From "${departure}" To "${destination}"
    [Documentation]    Usuario busca vuelo entre dos ciudades
    Select Departure City    ${departure}
    Select Destination City    ${destination}
    Click Find Flights Button

When User Selects Departure City "${city}"
    [Documentation]    Usuario selecciona ciudad de origen
    Select Departure City    ${city}

When User Selects Destination City "${city}"
    [Documentation]    Usuario selecciona ciudad de destino
    Select Destination City    ${city}

When User Clicks Find Flights
    [Documentation]    Usuario hace click en buscar vuelos
    Click Find Flights Button

When User Searches Random Flight
    [Documentation]    Usuario busca vuelo con ciudades aleatorias
    ${departure}=    Select Random Departure City
    ${destination}=    Select Random Destination City
    Click Find Flights Button
    Set Suite Variable    ${RANDOM_DEPARTURE}    ${departure}
    Set Suite Variable    ${RANDOM_DESTINATION}    ${destination}

# ========== THEN - Verificaciones ==========

Then Flight Results Page Should Be Displayed
    [Documentation]    Debe mostrarse la página de resultados de vuelos
    Verify Flight List Page Is Displayed

Then Available Flights Should Be Shown
    [Documentation]    Deben mostrarse vuelos disponibles
    ${count}=    Get Number Of Available Flights
    Should Be True    ${count} > 0    No flights found

Then Departure City Should Be "${expected_city}"
    [Documentation]    La ciudad de origen debe ser la esperada
    Verify Page Shows Correct Route    ${expected_city}    ignore

Then Destination City Should Be "${expected_city}"
    [Documentation]    La ciudad de destino debe ser la esperada
    # Verificar en el heading de la página de resultados
    ${heading}=    Get Text    ${FLIGHTS_PAGE_HEADING}
    Should Contain    ${heading}    ${expected_city}

Then Route Should Be From "${departure}" To "${destination}"
    [Documentation]    La ruta debe ser la esperada
    Verify Page Shows Correct Route    ${departure}    ${destination}

Then At Least "${min_count}" Flights Should Be Available
    [Documentation]    Debe haber al menos X vuelos disponibles
    ${actual_count}=    Get Number Of Available Flights
    Should Be True    ${actual_count} >= ${min_count}

Then All Flights Should Have Required Information
    [Documentation]    Todos los vuelos deben tener información completa
    Verify All Flights Have Required Fields

Then Flight Prices Should Be Valid
    [Documentation]    Los precios de vuelos deben ser válidos
    Verify Prices Are In Valid Range

# ========== AND - Acciones adicionales ==========

And User Sees Flight List
    [Documentation]    Usuario ve la lista de vuelos
    Verify Flight List Page Is Displayed

And Flights Are Available For Selection
    [Documentation]    Hay vuelos disponibles para seleccionar
    ${count}=    Get Number Of Available Flights
    Should Be True    ${count} > 0

And All Flight Details Are Visible
    [Documentation]    Todos los detalles de vuelos son visibles
    Verify All Flights Have Required Fields

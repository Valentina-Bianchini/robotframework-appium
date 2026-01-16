*** Settings ***
Documentation    🏠 Page Object para la página principal de BlazeDemo
...             Contiene todos los elementos y keywords de la home page

Library          SeleniumLibrary
Resource         ../data/locators.robot
Resource         ../data/testData.robot

*** Keywords ***
Navigate To BlazeDemo Home Page
    [Documentation]    Navega a la página principal de BlazeDemo
    Go To    ${BLAZEDEMO_HOME}
    Wait Until Page Contains Element    ${HOME_DEPARTURE_SELECT}    ${MEDIUM_TIMEOUT}
    Title Should Be    ${PAGE_TITLE_HOME}

Verify Home Page Is Displayed
    [Documentation]    Verifica que la página principal está visible
    Wait Until Page Contains Element    ${HOME_PAGE_HEADING}    ${MEDIUM_TIMEOUT}
    Element Should Be Visible    ${HOME_DEPARTURE_SELECT}
    Element Should Be Visible    ${HOME_DESTINATION_SELECT}
    Element Should Be Visible    ${HOME_FIND_FLIGHTS_BTN}

Select Departure City
    [Documentation]    Selecciona la ciudad de origen
    [Arguments]    ${city_name}
    Wait Until Element Is Visible    ${HOME_DEPARTURE_SELECT}    ${MEDIUM_TIMEOUT}
    Select From List By Label    ${HOME_DEPARTURE_SELECT}    ${city_name}
    ${selected}=    Get Selected List Label    ${HOME_DEPARTURE_SELECT}
    Should Be Equal    ${selected}    ${city_name}
    Log    Selected departure city: ${city_name}

Select Destination City
    [Documentation]    Selecciona la ciudad de destino
    [Arguments]    ${city_name}
    Wait Until Element Is Visible    ${HOME_DESTINATION_SELECT}    ${MEDIUM_TIMEOUT}
    Select From List By Label    ${HOME_DESTINATION_SELECT}    ${city_name}
    ${selected}=    Get Selected List Label    ${HOME_DESTINATION_SELECT}
    Should Be Equal    ${selected}    ${city_name}
    Log    Selected destination city: ${city_name}

Get Selected Departure City
    [Documentation]    Obtiene la ciudad de origen seleccionada
    ${city}=    Get Selected List Label    ${HOME_DEPARTURE_SELECT}
    [Return]    ${city}

Get Selected Destination City
    [Documentation]    Obtiene la ciudad de destino seleccionada
    ${city}=    Get Selected List Label    ${HOME_DESTINATION_SELECT}
    [Return]    ${city}

Get All Departure Cities
    [Documentation]    Obtiene lista de todas las ciudades de origen disponibles
    @{cities}=    Get List Items    ${HOME_DEPARTURE_SELECT}
    [Return]    @{cities}

Get All Destination Cities
    [Documentation]    Obtiene lista de todas las ciudades de destino disponibles
    @{cities}=    Get List Items    ${HOME_DESTINATION_SELECT}
    [Return]    @{cities}

Click Find Flights Button
    [Documentation]    Hace click en el botón "Find Flights"
    Wait Until Element Is Visible    ${HOME_FIND_FLIGHTS_BTN}    ${MEDIUM_TIMEOUT}
    Click Button    ${HOME_FIND_FLIGHTS_BTN}
    Wait Until Location Contains    reserve.php    ${MEDIUM_TIMEOUT}

Verify Find Flights Button Is Enabled
    [Documentation]    Verifica que el botón Find Flights está habilitado
    Element Should Be Enabled    ${HOME_FIND_FLIGHTS_BTN}

Click Vacation Link
    [Documentation]    Hace click en el link de vacaciones
    Click Element    ${HOME_VACATION_LINK}

Verify Page Title
    [Documentation]    Verifica el título de la página
    Title Should Be    ${PAGE_TITLE_HOME}

Select Random Departure City
    [Documentation]    Selecciona una ciudad de origen aleatoria
    @{cities}=    Get List Items    ${HOME_DEPARTURE_SELECT}
    ${random_city}=    Evaluate    random.choice(${cities})    random
    Select Departure City    ${random_city}
    [Return]    ${random_city}

Select Random Destination City
    [Documentation]    Selecciona una ciudad de destino aleatoria
    @{cities}=    Get List Items    ${HOME_DESTINATION_SELECT}
    ${random_city}=    Evaluate    random.choice(${cities})    random
    Select Destination City    ${random_city}
    [Return]    ${random_city}

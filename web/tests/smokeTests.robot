*** Settings ***
Documentation    🚭 Smoke Tests para BlazeDemo - Verificación básica de conectividad
...             Tests rápidos para verificar que la aplicación está funcionando

Library          SeleniumLibrary
Resource         ../steps/flightSearchSteps.robot
Resource         ../data/testData.robot

Suite Setup      Open Browser To BlazeDemo
Suite Teardown   Close Browser

*** Variables ***
${BROWSER}       Chrome
${HEADLESS}      False

*** Test Cases ***
Smoke Test 01: BlazeDemo Home Page Loads Successfully
    [Documentation]    Verifica que la página principal de BlazeDemo carga correctamente
    [Tags]    Smoke    Critical    Quick
    
    Given User Is On BlazeDemo Home Page
    Then Page Should Contain    Welcome to the Simple Travel Agency

Smoke Test 02: Departure Cities Dropdown Is Populated
    [Documentation]    Verifica que el dropdown de ciudades de origen contiene opciones
    [Tags]    Smoke    Quick
    
    Given User Is On BlazeDemo Home Page
    When User Sees Departure City Dropdown
    Then Dropdown Should Have Multiple Options    ${HOME_DEPARTURE_SELECT}

Smoke Test 03: Destination Cities Dropdown Is Populated
    [Documentation]    Verifica que el dropdown de ciudades de destino contiene opciones
    [Tags]    Smoke    Quick
    
    Given User Is On BlazeDemo Home Page
    When User Sees Destination City Dropdown
    Then Dropdown Should Have Multiple Options    ${HOME_DESTINATION_SELECT}

Smoke Test 04: Find Flights Button Is Clickable
    [Documentation]    Verifica que el botón Find Flights está habilitado
    [Tags]    Smoke    Quick
    
    Given User Is On BlazeDemo Home Page
    Then Find Flights Button Should Be Enabled

Smoke Test 05: Basic Flight Search Works
    [Documentation]    Verifica que la búsqueda básica de vuelos funciona
    [Tags]    Smoke    Critical    E2E
    
    Given User Is On BlazeDemo Home Page
    When User Searches Flight From "Boston" To "Rome"
    Then Flight Results Page Should Be Displayed
    And Available Flights Should Be Shown

*** Keywords ***
Open Browser To BlazeDemo
    [Documentation]    Abre el navegador y navega a BlazeDemo
    ${chrome_options}=    Evaluate    sys.modules['selenium.webdriver'].ChromeOptions()    sys, selenium.webdriver
    
    IF    ${HEADLESS}
        Call Method    ${chrome_options}    add_argument    --headless
        Call Method    ${chrome_options}    add_argument    --disable-gpu
    END
    
    Call Method    ${chrome_options}    add_argument    --start-maximized
    Call Method    ${chrome_options}    add_argument    --disable-blink-features=AutomationControlled
    
    Open Browser    ${BLAZEDEMO_HOME}    ${BROWSER}    options=${chrome_options}
    Set Selenium Speed    0.3s
    Set Selenium Timeout    ${MEDIUM_TIMEOUT}

User Sees Departure City Dropdown
    [Documentation]    Usuario ve el dropdown de ciudades de origen
    Element Should Be Visible    ${HOME_DEPARTURE_SELECT}

User Sees Destination City Dropdown
    [Documentation]    Usuario ve el dropdown de ciudades de destino
    Element Should Be Visible    ${HOME_DESTINATION_SELECT}

Dropdown Should Have Multiple Options
    [Documentation]    Verifica que un dropdown tiene múltiples opciones
    [Arguments]    ${locator}
    @{options}=    Get List Items    ${locator}
    ${count}=    Get Length    ${options}
    Should Be True    ${count} > 1    Dropdown should have multiple options

Find Flights Button Should Be Enabled
    [Documentation]    Verifica que el botón Find Flights está habilitado
    Verify Find Flights Button Is Enabled

Available Flights Should Be Shown
    [Documentation]    Verifica que los vuelos disponibles se muestran en la página de resultados
    Page Should Contain    Choose your flight

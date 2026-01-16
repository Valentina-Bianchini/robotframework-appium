*** Settings ***
Documentation    🛣️ Tests End-to-End completos para BlazeDemo
...             Tests de flujo completo desde búsqueda hasta confirmación

Library          SeleniumLibrary
Resource         ../steps/flightSearchSteps.robot
Resource         ../steps/flightBookingSteps.robot
Resource         ../data/testData.robot

Suite Setup      Open Browser To BlazeDemo
Suite Teardown   Close Browser

Test Setup       Go To BlazeDemo Home
Test Teardown    Run Keyword If Test Failed    Capture Page Screenshot

*** Variables ***
${BROWSER}       Chrome
${HEADLESS}      False

*** Test Cases ***
E2E Test 01: Complete Flight Booking From Boston To Buenos Aires
    [Documentation]    Test completo de reserva de vuelo desde Boston a Buenos Aires
    [Tags]    E2E    Critical    FullFlow    Booking
    
    # Búsqueda de vuelo
    Given User Is On BlazeDemo Home Page
    When User Searches Flight From "Boston" To "Buenos Aires"
    Then Flight Results Page Should Be Displayed
    And Available Flights Should Be Shown
    
    # Selección de vuelo
    When User Selects Flight Number "0"
    Then Purchase Form Should Be Displayed
    And Flight Details Should Be Shown
    
    # Completar compra
    When User Fills Complete Purchase Form
    And User Submits Purchase
    Then Confirmation Page Should Be Displayed
    And Purchase Should Be Confirmed
    And Confirmation Code Should Be Generated
    And Transaction ID Should Be Generated

E2E Test 02: Book Cheapest Flight From Portland To London
    [Documentation]    Reserva el vuelo más barato desde Portland a Londres
    [Tags]    E2E    Booking    PriceValidation
    
    Given User Is On BlazeDemo Home Page
    When User Searches Flight From "Portland" To "London"
    And User Selects The Cheapest Flight
    And User Books Flight With Default Data
    Then Purchase Should Be Confirmed
    And All Purchase Details Should Be Visible

E2E Test 03: Book Most Expensive Flight From San Diego To Rome
    [Documentation]    Reserva el vuelo más caro desde San Diego a Roma
    [Tags]    E2E    Booking    PriceValidation
    
    Given User Is On BlazeDemo Home Page
    When User Searches Flight From "San Diego" To "Rome"
    And User Selects The Most Expensive Flight
    And User Books Flight With Name "Maria Garcia"
    Then Purchase Should Be Confirmed

E2E Test 04: Complete Booking With Custom Passenger Data
    [Documentation]    Reserva completa con datos personalizados del pasajero
    [Tags]    E2E    Booking    CustomData
    
    # Datos personalizados
    &{passenger_data}=    Create Dictionary
    ...    name=Jane Smith
    ...    address=456 Oak Avenue
    ...    city=New York
    ...    state=NY
    ...    zip=10001
    ...    card_type=American Express
    ...    card_number=378282246310005
    ...    card_month=11
    ...    card_year=2027
    ...    name_on_card=Jane Smith
    
    Given User Is On BlazeDemo Home Page
    When User Searches Flight From "Philadelphia" To "Berlin"
    And User Selects Flight Number "1"
    And User Fills Purchase Form With Custom Data    &{passenger_data}
    And User Submits Purchase
    Then Purchase Should Be Confirmed
    And Purchase Confirmation Should Contain
    ...    passenger_name=Jane Smith

E2E Test 05: Multiple Consecutive Bookings
    [Documentation]    Realiza múltiples reservas consecutivas
    [Tags]    E2E    Booking    Stress
    
    FOR    ${i}    IN RANGE    1    4
        Log    Booking ${i} of 3
        Go To BlazeDemo Home
        Given User Is On BlazeDemo Home Page
        When User Searches Random Flight
        And User Selects Flight Number "0"
        And User Books Flight With Default Data
        Then Purchase Should Be Confirmed
    END

E2E Test 06: Complete Flow With Remember Me Checked
    [Documentation]    Flujo completo con checkbox "Remember Me" marcado
    [Tags]    E2E    Booking    RememberMe
    
    Given User Is On BlazeDemo Home Page
    When User Searches Flight From "Mexico City" To "Cairo"
    And User Selects Flight Number "0"
    And User Fills Complete Purchase Form
    And User Checks Remember Me
    And User Submits Purchase
    Then Purchase Should Be Confirmed

E2E Test 07: Verify All Cities Combinations Work
    [Documentation]    Verifica que todas las combinaciones de ciudades funcionan
    [Tags]    E2E    Validation    Comprehensive
    
    @{sample_routes}=    Create List
    ...    Boston-Rome
    ...    Portland-Dublin
    ...    Philadelphia-Cairo
    
    FOR    ${route}    IN    @{sample_routes}
        ${cities}=    Split String    ${route}    -
        ${departure}=    Get From List    ${cities}    0
        ${destination}=    Get From List    ${cities}    1
        
        Go To BlazeDemo Home
        When User Searches Flight From "${departure}" To "${destination}"
        Then Flight Results Page Should Be Displayed
        And Route Should Be From "${departure}" To "${destination}"
        And At Least "1" Flights Should Be Available
    END

E2E Test 08: Complete Booking With Visa Card
    [Documentation]    Reserva completa usando tarjeta Visa
    [Tags]    E2E    Booking    PaymentMethod    Visa
    
    Given User Is On BlazeDemo Home Page
    When User Searches Flight From "São Paolo" To "New York"
    And User Selects Flight Number "0"
    And User Fills Personal Information
    ...    ${TEST_NAME}
    ...    ${TEST_ADDRESS}
    ...    ${TEST_CITY}
    ...    ${TEST_STATE}
    ...    ${TEST_ZIP}
    And User Fills Payment Information
    ...    Visa
    ...    4111111111111111
    ...    12
    ...    2026
    ...    ${TEST_NAME}
    And User Submits Purchase
    Then Purchase Should Be Confirmed

E2E Test 09: Complete Booking With American Express
    [Documentation]    Reserva completa usando tarjeta American Express
    [Tags]    E2E    Booking    PaymentMethod    Amex
    
    Given User Is On BlazeDemo Home Page
    When User Searches Flight From "Paris" To "London"
    And User Selects Flight Number "0"
    And User Fills Personal Information
    ...    ${TEST_NAME_2}
    ...    ${TEST_ADDRESS_2}
    ...    ${TEST_CITY_2}
    ...    ${TEST_STATE_2}
    ...    ${TEST_ZIP_2}
    And User Fills Payment Information
    ...    American Express
    ...    378282246310005
    ...    10
    ...    2025
    ...    ${TEST_NAME_2}
    And User Submits Purchase
    Then Purchase Should Be Confirmed

E2E Test 10: Verify Purchase Details Are Complete
    [Documentation]    Verifica que todos los detalles de compra están completos
    [Tags]    E2E    Validation    PurchaseDetails
    
    Given User Is On BlazeDemo Home Page
    When User Searches Flight From "Boston" To "Buenos Aires"
    And User Selects Flight Number "0"
    And User Completes Full Booking Flow
    Then All Purchase Details Should Be Visible
    And Purchase Details Are Saved

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

Go To BlazeDemo Home
    [Documentation]    Navega a la página principal
    Go To    ${BLAZEDEMO_HOME}
    Wait Until Page Contains Element    ${HOME_FIND_FLIGHTS_BTN}    ${MEDIUM_TIMEOUT}

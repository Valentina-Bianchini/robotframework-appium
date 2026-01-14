*** Settings ***
Library    RequestsLibrary
Library    Collections

*** Variables ***
${BASE_URL}    https://api.restful-api.dev
${OBJECT_ID}    2
&{POST_DATA}    year=2019    price=1849.99    CPU model=Intel Core i9    Hard disk size=1 TB

*** Test Cases ***
Get Object By ID
    [Documentation]    Test GET request to retrieve object with ID 2
    [Tags]    API    GET
    Create Session    restful_api    ${BASE_URL}
    ${response}=    GET On Session    restful_api    /objects/${OBJECT_ID}
    
    # Verify response status code
    Should Be Equal As Strings    ${response.status_code}    200
    
    # Verify response body contains expected data
    Should Not Be Empty    ${response.json()}
    Dictionary Should Contain Key    ${response.json()}    id
    Should Be Equal As Strings    ${response.json()}[id]    ${OBJECT_ID}
    
    # Verify all text attributes have content
    Dictionary Should Contain Key    ${response.json()}    name
    Run Keyword If    '${response.json()}[name]' != 'None'    Should Not Be Empty    ${response.json()}[name]
    
    # Verify data object exists
    Dictionary Should Contain Key    ${response.json()}    data
    
    # Verify data object contains expected fields if data is not null
    Run Keyword If    ${response.json()}[data] is not None    Validate Data Fields    ${response.json()}[data]
    
    # Log response for debugging
    Log    Response Status: ${response.status_code}
    Log    Response Body: ${response.json()}
    
    [Teardown]    Delete All Sessions

Create New Object
    [Documentation]    Test POST request to create a new object
    [Tags]    API    POST
    Create Session    restful_api    ${BASE_URL}
    
    # Create request body
    ${body}=    Create Dictionary    name=Apple MacBook Pro 16    data=${POST_DATA}
    
    # Send POST request
    ${response}=    POST On Session    restful_api    /objects    json=${body}
    
    # Verify response status code (200 Created)
    Should Be Equal As Strings    ${response.status_code}    200
    
    # Verify response contains the created object
    Should Not Be Empty    ${response.json()}
    Dictionary Should Contain Key    ${response.json()}    id
    Dictionary Should Contain Key    ${response.json()}    name
    Should Be Equal As Strings    ${response.json()}[name]    Apple MacBook Pro 16
    
    # Verify data object
    Dictionary Should Contain Key    ${response.json()}    data
    ${response_data}=    Set Variable    ${response.json()}[data]
    
    # Verify all data fields match the sent values
    Should Be Equal As Numbers    ${response_data}[year]    2019
    Should Be Equal As Numbers    ${response_data}[price]    1849.99
    Should Be Equal As Strings    ${response_data}[CPU model]    Intel Core i9
    Should Be Equal As Strings    ${response_data}[Hard disk size]    1 TB
    
    # Log created object
    Log    Created Object ID: ${response.json()}[id]
    Log    Response Body: ${response.json()}
    
    [Teardown]    Delete All Sessions

*** Keywords ***
Validate Data Fields
    [Arguments]    ${data}
    Dictionary Should Contain Key    ${data}    year
    Dictionary Should Contain Key    ${data}    price
    Dictionary Should Contain Key    ${data}    CPU model
    Dictionary Should Contain Key    ${data}    Hard disk size
    
    # Verify text fields have content
    Should Not Be Empty    ${data}[CPU model]
    Should Not Be Empty    ${data}[Hard disk size]

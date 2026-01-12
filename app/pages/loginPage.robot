***Settings***

Library           AppiumLibrary
Resource          ../../app/base/helpers.robot

*** Variables ***
${LOGIN_TITLE}                  id=com.saucelabs.mydemoapp.android:id/loginTV
${SELECT_TEXT}                  id=com.saucelabs.mydemoapp.android:id/selectTextTV
${USERNAME_LABEL}               id=com.saucelabs.mydemoapp.android:id/usernameTV
${USERNAME_INPUT}               id=com.saucelabs.mydemoapp.android:id/nameET
${PASSWORD_LABEL}               id=com.saucelabs.mydemoapp.android:id/passwordTV
${PASSWORD_INPUT}               id=com.saucelabs.mydemoapp.android:id/passwordET
${LOGIN_BUTTON}                 accessibility_id=Tap to login with given credentials
${LOGOUT_ALERT_TITLE}           id=com.saucelabs.mydemoapp.android:id/alertTitle
${LOGOUT_CONFIRM_BUTTON}        id=android:id/button1


***Keywords***
Verify Login Screen Elements
    [Documentation]    Verifica que todos los elementos de login estén visibles
    Wait Until Element Is Visible    ${LOGIN_TITLE}    10
    Wait Until Element Is Visible    ${SELECT_TEXT}    10
    Wait Until Element Is Visible    ${USERNAME_LABEL}    10
    Wait Until Element Is Visible    ${USERNAME_INPUT}    10
    Wait Until Element Is Visible    ${PASSWORD_LABEL}    10
    Wait Until Element Is Visible    ${PASSWORD_INPUT}    10
    Wait Until Element Is Visible    ${LOGIN_BUTTON}    10

Enter Username
    [Arguments]    ${username}
    [Documentation]    Ingresa el nombre de usuario
    Wait And Input Text    ${USERNAME_INPUT}    ${username}

Enter Password
    [Arguments]    ${password}
    [Documentation]    Ingresa la contraseña
    Wait And Input Text    ${PASSWORD_INPUT}    ${password}

Click Login Button
    [Documentation]    Hace click en el botón de login
    Wait And Click Element    ${LOGIN_BUTTON}

Verify Logout Alert
    [Documentation]    Verifica que el alert de logout esté visible
    Wait Until Element Is Visible    ${LOGOUT_ALERT_TITLE}    10

Confirm Logout
    [Documentation]    Confirma el logout haciendo click en OK
    Wait And Click Element    ${LOGOUT_CONFIRM_BUTTON}

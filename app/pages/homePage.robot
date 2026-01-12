***Settings***
# Page Object para la pantalla Home de My Demo App
Library           AppiumLibrary
Resource          ../../app/base/helpers.robot

*** Variables ***
# ========================================
# LOCATORS DE LA PANTALLA HOME
# ========================================
# Formato: accessibility_id= para elementos con accessibility id
# Formato: id= para elementos con resource-id
# IMPORTANTE: Obtener estos locators usando Appium Inspector conectado al dispositivo real

${VIEW_MENU}                    accessibility_id=View menu                      # Botón del menú hamburguesa (arriba izquierda)
${SORTING_BUTTON}               accessibility_id=Shows current sorting order and displays available sorting options    # Botón de ordenamiento
${CART_BADGE}                   accessibility_id=Displays number of items in your cart    # Contador de items en carrito
${CONTAINER}                    accessibility_id=Container for fragments        # Contenedor principal de la pantalla

# ========================================
# LOCATORS DEL MENÚ LATERAL
# ========================================
${LOGIN_MENU_ITEM}              accessibility_id=Login Menu Item                # Opción "Login" en el menú lateral
${LOGOUT_MENU_ITEM}             accessibility_id=Logout Menu Item               # Opción "Logout" en el menú lateral (visible solo cuando está logueado)


***Keywords***
Verify Home Screen Elements
    [Documentation]    Verifica que los elementos principales del home estén visibles
    Wait Until Element Is Visible    ${VIEW_MENU}    10
    Wait Until Element Is Visible    ${SORTING_BUTTON}    10
    Wait Until Element Is Visible    ${CART_BADGE}    10
    Wait Until Element Is Visible    ${CONTAINER}    10

Click View Menu
    [Documentation]    Hace click en el menú hamburguesa
    Wait And Click Element    ${VIEW_MENU}

Click Login Menu Item
    [Documentation]    Hace click en la opción Login del menú
    Wait Until Element Is Visible    ${LOGIN_MENU_ITEM}    10
    Click Element    ${LOGIN_MENU_ITEM}

Verify Logout Menu Item Visible
    [Documentation]    Verifica que la opción Logout esté visible (usuario logueado)
    Wait Until Element Is Visible    ${LOGOUT_MENU_ITEM}    10

Click Logout Menu Item
    [Documentation]    Hace click en la opción Logout del menú
    Wait And Click Element    ${LOGOUT_MENU_ITEM}

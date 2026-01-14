***Settings***
# Librería AppiumLibrary para interactuar con elementos móviles
Library           AppiumLibrary


***Keywords***
# ========================================
# KEYWORD: Wait And Click Element
# ========================================
# Descripción: Espera a que un elemento sea visible y luego hace click
# Argumentos:
#   - element: Locator del elemento (id=, accessibility_id=, xpath=, etc.)
#   - timeout: Tiempo máximo de espera en segundos (por defecto 10)
# ========================================
Wait And Click Element
    [Arguments]    ${element}    ${timeout}=10
    [Documentation]    Espera que el elemento sea visible y hace click sobre él
    Wait Until Element Is Visible    ${element}    ${timeout}    # Espera hasta que el elemento esté visible
    Click Element    ${element}                                   # Hace click en el elemento

# ========================================
# KEYWORD: Wait And Input Text
# ========================================
# Descripción: Espera a que un campo de texto sea visible y luego ingresa texto
# Argumentos:
#   - element: Locator del campo de texto
#   - text: Texto a ingresar
#   - timeout: Tiempo máximo de espera en segundos (por defecto 10)
# ========================================
Wait And Input Text
    [Arguments]    ${element}    ${text}    ${timeout}=10
    [Documentation]    Espera que el campo de texto sea visible e ingresa el texto
    Wait Until Element Is Visible    ${element}    ${timeout}    # Espera hasta que el campo esté visible
    Input Text    ${element}    ${text}                          # Ingresa el texto en el campo

# ========================================
# KEYWORD: Get Element Text
# ========================================
# Descripción: Obtiene el texto de un elemento
# Argumentos:
#   - element: Locator del elemento
# Retorna: El texto contenido en el elemento
# ========================================
Get Element Text
    [Arguments]    ${element}
    [Documentation]    Obtiene el texto de un elemento visible
    Wait Until Element Is Visible    ${element}    10            # Espera que el elemento sea visible
    ${text}=    Get Text    ${element}                           # Obtiene el texto del elemento
    RETURN    ${text}                                            # Retorna el texto obtenido

# ========================================
# KEYWORD: Element Should Be Present
# ========================================
# Descripción: Verifica que un elemento esté presente y visible
# Argumentos:
#   - element: Locator del elemento a verificar
# ========================================
Element Should Be Present
    [Arguments]    ${element}
    [Documentation]    Verifica que el elemento esté presente en la pantalla
    Wait Until Element Is Visible    ${element}    10            # Espera que el elemento sea visible
    Element Should Be Visible    ${element}                      # Verifica que el elemento sea visible

# ========================================
# KEYWORD: Hide Keyboard
# ========================================
# Descripción: Oculta el teclado virtual si está visible
# Nota: Presiona la tecla BACK de Android para cerrar el teclado
# ========================================
Hide Keyboard
    [Documentation]    Oculta el teclado virtual del dispositivo
    Press Key Code    4                                          # BACK en Android

# ========================================
# KEYWORD: Scroll Down
# ========================================
# Descripción: Realiza un scroll hacia abajo en la pantalla
# Argumentos:
#   - times: Número de veces que se repite el scroll (por defecto 1)
# Nota: Las coordenadas deben ajustarse según el tamaño de pantalla del dispositivo
# ========================================
Scroll Down
    [Arguments]    ${times}=1
    [Documentation]    Realiza scroll hacia abajo en la pantalla
    FOR    ${i}    IN RANGE    ${times}
        Swipe    start_x=500    start_y=1200    end_x=500    end_y=400    duration=1000
    END

# ========================================
# KEYWORD: Scroll Up
# ========================================
# Descripción: Realiza un scroll hacia arriba en la pantalla
# Argumentos:
#   - times: Número de veces que se repite el scroll (por defecto 1)
# Nota: Las coordenadas deben ajustarse según el tamaño de pantalla del dispositivo
# ========================================
Scroll Up
    [Arguments]    ${times}=1
    [Documentation]    Realiza scroll hacia arriba en la pantalla
    FOR    ${i}    IN RANGE    ${times}
        Swipe    start_x=500    start_y=400    end_x=500    end_y=1200    duration=1000
    END

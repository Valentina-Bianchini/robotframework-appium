***Settings***
# ========================================
# STEPS: LOGIN Y LOGOUT
# ========================================
# Descripción: Steps para ejecutar el flujo de autenticación (login/logout)
# Estos steps permiten:
#   - Verificar la pantalla de login
#   - Ingresar credenciales
#   - Ejecutar el login
#   - Confirmar el logout
# ========================================

Library           AppiumLibrary
Resource          ../../app/pages/loginPage.robot    # Importa las funciones del Page Object de Login


***Keywords***
# ========================================
# STEP: Debo ver la pantalla de login
# ========================================
# Descripción: Verifica que todos los elementos de la pantalla de login están presentes
# Validación: Verifica la presencia de:
#   - Título "Login"
#   - Texto de selección
#   - Labels de Username y Password
#   - Campos de input para usuario y contraseña
#   - Botón de login
# Uso en tests: "Debo ver la pantalla de login"
# ========================================
Debo ver la pantalla de login
    [Documentation]    Verifica que todos los elementos de login están presentes
    Verify Login Screen Elements    # Valida todos los elementos de la pantalla de login

# ========================================
# STEP: Ingreso usuario "${username}" y contraseña "${password}"
# ========================================
# Descripción: Ingresa las credenciales de usuario en los campos correspondientes
# Argumentos:
#   - username: Email del usuario (ej: bob@example.com)
#   - password: Contraseña del usuario (ej: 10203040)
# Uso en tests: Ingreso usuario "bob@example.com" y contraseña "10203040"
# Implementación:
#   1. Espera a que el campo de usuario sea visible
#   2. Ingresa el email en el campo (id=com.saucelabs.mydemoapp.android:id/nameET)
#   3. Espera a que el campo de contraseña sea visible
#   4. Ingresa la contraseña (id=com.saucelabs.mydemoapp.android:id/passwordET)
# ========================================
Ingreso usuario "${username}" y contraseña "${password}"
    [Documentation]    Ingresa credenciales de login
    Enter Username    ${username}    # Ingresa el email en el campo de usuario
    Enter Password    ${password}    # Ingresa la contraseña en el campo de password

# ========================================
# STEP: Hago click en el botón de login
# ========================================
# Descripción: Ejecuta el login haciendo click en el botón "Login"
# Prerequisito: Las credenciales deben estar ingresadas
# Resultado: Si las credenciales son correctas, inicia sesión y navega al home
# Locator usado: accessibility_id=Tap to login with given credentials
# Uso en tests: "Hago click en el botón de login"
# ========================================
Hago click en el botón de login
    [Documentation]    Ejecuta el login
    Click Login Button    # Click en accessibility_id=Tap to login with given credentials

# ========================================
# STEP: Debo ver el alert de logout
# ========================================
# Descripción: Verifica que aparece el diálogo de confirmación de logout
# Validación: Verifica la presencia del título del alert
# Locator usado: id=com.saucelabs.mydemoapp.android:id/alertTitle
# Uso en tests: "Debo ver el alert de logout"
# ========================================
Debo ver el alert de logout
    [Documentation]    Verifica que aparece el alert de confirmación de logout
    Verify Logout Alert    # Valida que el alert title está visible

# ========================================
# STEP: Confirmo el logout
# ========================================
# Descripción: Confirma el logout haciendo click en el botón "OK" del alert
# Resultado: Cierra la sesión del usuario y vuelve al home sin autenticar
# Locator usado: id=android:id/button1 (botón estándar de Android para "OK")
# Uso en tests: "Confirmo el logout"
# ========================================
Confirmo el logout
    [Documentation]    Confirma el logout en el alert
    Confirm Logout    # Click en id=android:id/button1 (botón OK del alert)

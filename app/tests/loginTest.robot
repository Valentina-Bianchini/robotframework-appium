***Settings***
# ========================================
# TEST SUITE: LOGIN Y LOGOUT
# ========================================
# Descripción: Suite de tests para validar el flujo completo de login y logout
# Aplicación: My Demo App (com.saucelabs.mydemoapp.android)
# Dispositivo: moto g82 5G (ZY22FLDZMN)
# ========================================

# Importar recursos necesarios
Resource          ../../app/base/base.robot           # Configuración base de Appium y dispositivo
Resource          ../../app/steps/splashStep.robot    # Steps para manejo del splash screen
Resource          ../../app/steps/homeStep.robot      # Steps para navegación en home
Resource          ../../app/steps/loginStep.robot     # Steps para login/logout

# ========================================
# CONFIGURACIÓN DE SETUP Y TEARDOWN
# ========================================
# Test Setup: Se ejecuta ANTES de cada test case
# - Abre sesión de Appium con el dispositivo real
# - Instala/abre la aplicación
Test Setup        Open Session

# Test Teardown: Se ejecuta DESPUÉS de cada test case (incluso si falla)
# - Toma screenshot final
# - Cierra la aplicación y sesión de Appium
Test Teardown     Close Session


***Test Cases***
# ========================================
# TEST CASE: Debe realizar login y logout correctamente
# ========================================
# Objetivo: Validar el flujo completo de autenticación
# Credenciales de prueba:
#   - Usuario: bob@example.com
#   - Contraseña: 10203040
# Flujo:
#   1. Esperar carga del splash screen
#   2. Verificar pantalla home
#   3. Navegar a login desde menú lateral
#   4. Ingresar credenciales válidas
#   5. Verificar login exitoso (opción logout visible)
#   6. Realizar logout y confirmar
# ========================================
Debe realizar login y logout correctamente
    [Documentation]    Test completo de login y logout con credenciales válidas
    [Tags]    login    authentication    smoke
    
    # PASO 1: Esperar que cargue el splash screen (3 segundos)
    Espero que cargue el splash
    
    # PASO 2: Verificar que estamos en la pantalla home
    Estoy en la pantalla home
    
    # PASO 3: Abrir el menú lateral (hamburguesa)
    Abro el menú lateral
    
    # PASO 4: Seleccionar la opción "Login" del menú
    Selecciono la opción Login
    
    # PASO 5: Verificar que se abrió la pantalla de login
    Debo ver la pantalla de login
    
    # PASO 6: Ingresar credenciales (usuario: bob@example.com / contraseña: 10203040)
    Ingreso usuario "bob@example.com" y contraseña "10203040"
    
    # PASO 7: Hacer click en el botón de login
    Hago click en el botón de login
    
    # PASO 8: Abrir nuevamente el menú lateral para verificar logout
    Abro el menú lateral
    
    # PASO 9: Verificar que la opción "Logout" está visible (usuario logueado correctamente)
    Debo ver la opción Logout en el menú
    
    # PASO 10: Seleccionar la opción "Logout"
    Selecciono la opción Logout
    
    # PASO 11: Verificar que aparece el alert de confirmación de logout
    Debo ver el alert de logout
    
    # PASO 12: Confirmar el logout haciendo click en "OK"
    Confirmo el logout

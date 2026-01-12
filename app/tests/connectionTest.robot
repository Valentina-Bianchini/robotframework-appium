***Settings***
# ========================================
# TEST SUITE: VERIFICACIÓN DE CONEXIÓN
# ========================================
# Descripción: Test básico para verificar la conexión con el dispositivo real
# Propósito:
#   - Validar que Appium Server está corriendo
#   - Verificar que el dispositivo está conectado correctamente
#   - Confirmar que la aplicación se instala/abre correctamente
#   - Validar que los elementos básicos son visibles
# Aplicación: My Demo App (com.saucelabs.mydemoapp.android)
# Dispositivo: moto g82 5G (UDID: ZY22FLDZMN)
# ========================================

# Importar configuración base de Appium y dispositivo
Resource          ../../app/base/base.robot

# ========================================
# CONFIGURACIÓN DE SETUP Y TEARDOWN
# ========================================
# Test Setup: Se ejecuta ANTES de cada test case
# - Conecta con el servidor Appium (http://localhost:4723)
# - Establece sesión con el dispositivo físico usando UDID
# - Instala/abre la aplicación en el dispositivo
Test Setup        Open Session

# Test Teardown: Se ejecuta DESPUÉS de cada test case
# - Captura screenshot (útil para debugging)
# - Cierra la aplicación
# - Finaliza la sesión de Appium
Test Teardown     Close Session


***Test Cases***
# ========================================
# TEST CASE: Debe conectarse a la aplicación correctamente
# ========================================
# Objetivo: Validar la conexión básica del framework con el dispositivo real
# Prerequisitos:
#   1. Appium Server corriendo (http://localhost:4723)
#   2. Dispositivo Android conectado por USB (verificar con: adb devices)
#   3. Depuración USB habilitada en el dispositivo
#   4. APK disponible en la ruta especificada en base.robot
# Flujo:
#   1. Espera 3 segundos para que la app cargue completamente
#   2. Verifica que el texto "Products" esté presente en la pantalla
# Resultado esperado: La app se abre y muestra la pantalla principal con "Products"
# ========================================
Debe conectarse a la aplicación correctamente
    [Documentation]    Verifica que la app se inicia y conecta correctamente con el dispositivo real
    [Tags]    smoke    connection    sanity
    
    # PASO 1: Esperar 3 segundos para que la aplicación termine de cargar
    # Nota: Este tiempo puede ajustarse según el dispositivo y la velocidad de carga
    Sleep    3s
    
    # PASO 2: Verificar que el texto "Products" está presente en la pantalla
    # Esto confirma que:
    #   - La aplicación se instaló correctamente
    #   - La sesión de Appium está activa
    #   - Los elementos de la UI son accesibles
    #   - El dispositivo responde correctamente
    Page Should Contain Text    Products    timeout=10

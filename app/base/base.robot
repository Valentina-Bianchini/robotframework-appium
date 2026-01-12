***Settings***
# Librerías necesarias para el framework
Library           AppiumLibrary          # Librería principal de Appium para Robot Framework
Resource          helpers.robot          # Funciones auxiliares reutilizables
Library           ../../resources/libs/extend.py    # Librería Python personalizada (opcional)


*** Variables ***
# ========================================
# CONFIGURACIÓN DE APPIUM SERVER
# ========================================
${BASE_URL}                     http://localhost:4723    # URL del servidor Appium (debe estar corriendo)

# ========================================
# CONFIGURACIÓN DEL DISPOSITIVO REAL
# ========================================
# IMPORTANTE: Estas capabilities deben coincidir con tu dispositivo físico Android
${AUTOMATION_NAME}              UiAutomator2             # Driver de automatización para Android
${PLATFORM_NAME}                Android                  # Sistema operativo del dispositivo
${PLATFORM_VERSION}             13.0                     # ⚠️ Versión de Android del dispositivo real (obtener con: adb shell getprop ro.build.version.release)
${DEVICE_NAME}                  moto g82 5G              # ⚠️ Nombre del dispositivo (informativo, puede ser cualquier texto)
${UDID}                         ZY22FLDZMN               # ⚠️ UDID único del dispositivo real (obtener con: adb devices)

# ========================================
# CONFIGURACIÓN DE LA APLICACIÓN
# ========================================
${APP}                          C:/Users/ValentinaBianchini/Desktop/robot-framework-appium/resources/android/mda-2.2.0-25.apk    # ⚠️ Ruta absoluta del APK a testear
${APP_PACKAGE}                  com.saucelabs.mydemoapp.android                # Package name de la app (obtener con Appium Inspector)
${APP_ACTIVITY}                 .view.activities.SplashActivity                # Activity inicial de la app
${WAIT_FOR_IDLE_TIMEOUT}        ${10000}                 # Timeout en milisegundos para esperar que la app esté idle (debe ser número entero)

# ========================================
# TIMEOUTS GENERALES
# ========================================
${TIMEOUT}                      10                       # Timeout por defecto en segundos para elementos

***Keywords***
# ========================================
# KEYWORD: Open Session
# ========================================
# Descripción: Inicia una nueva sesión de Appium con el dispositivo real
# Prerequisitos:
#   - Appium Server corriendo en http://localhost:4723
#   - Dispositivo Android conectado por USB (verificar con: adb devices)
#   - Depuración USB habilitada en el dispositivo
# ========================================
Open Session
    [Documentation]    Abre una sesión de Appium con el dispositivo físico Android
    Set Appium Timeout    ${TIMEOUT}                     # Establece timeout para operaciones de Appium
    Open Application    ${BASE_URL}                      # Conecta con el servidor Appium
    ...                 platformName=${PLATFORM_NAME}                  # Android
    ...                 appium:platformVersion=${PLATFORM_VERSION}     # ⚠️ Versión de Android (13.0 en este caso)
    ...                 appium:deviceName=${DEVICE_NAME}               # ⚠️ Nombre del dispositivo (moto g82 5G)
    ...                 appium:udid=${UDID}                           # ⚠️ UDID único del dispositivo físico
    ...                 appium:automationName=${AUTOMATION_NAME}       # UiAutomator2 driver
    ...                 appium:app=${APP}                             # ⚠️ Ruta del APK a instalar/ejecutar
    ...                 appium:appPackage=${APP_PACKAGE}               # Package de la aplicación
    ...                 appium:appActivity=${APP_ACTIVITY}             # Activity inicial
    ...                 appium:waitForIdleTimeout=${WAIT_FOR_IDLE_TIMEOUT}    # Tiempo de espera para idle

# ========================================
# KEYWORD: Close Session
# ========================================
# Descripción: Cierra la sesión de Appium y toma screenshot final
# ========================================
Close Session
    [Documentation]    Cierra la aplicación y la sesión de Appium
    Capture Page Screenshot                              # Toma screenshot antes de cerrar (útil para debugging)
    Close Application                                    # Cierra la app y finaliza la sesión

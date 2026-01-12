***Settings***
# ========================================
# STEPS: SPLASH SCREEN
# ========================================
# Descripción: Steps para manejar el splash screen inicial de la aplicación
# El splash screen es la pantalla de bienvenida que aparece al iniciar la app
# ========================================

Library           AppiumLibrary
Resource          ../../app/pages/splashPage.robot    # Importa las funciones del Page Object de Splash


***Keywords***
# ========================================
# STEP: Espero que cargue el splash
# ========================================
# Descripción: Espera el tiempo necesario para que el splash screen cargue completamente
# Uso en tests: "Espero que cargue el splash"
# Implementación: Llama al keyword Wait For Splash To Load del page object
# ========================================
Espero que cargue el splash
    [Documentation]    Espera a que el splash screen cargue completamente
    Wait For Splash To Load    # Ejecuta un Sleep de 3 segundos (definido en splashPage.robot)

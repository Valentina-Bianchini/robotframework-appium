***Settings***
# ========================================
# STEPS: HOME Y NAVEGACIÓN
# ========================================
# Descripción: Steps para interactuar con la pantalla Home y el menú lateral
# Estos steps permiten:
#   - Verificar que estamos en la pantalla home
#   - Abrir el menú hamburguesa (lateral)
#   - Navegar a diferentes opciones del menú (Login, Logout)
# ========================================

Library           AppiumLibrary
Resource          ../../app/pages/homePage.robot    # Importa las funciones del Page Object de Home


***Keywords***
# ========================================
# STEP: Estoy en la pantalla home
# ========================================
# Descripción: Verifica que la aplicación está en la pantalla principal (Home)
# Validación: Verifica la presencia de elementos clave del home:
#   - Menú hamburguesa (View menu)
#   - Botón de ordenamiento
#   - Badge del carrito
#   - Contenedor principal
# Uso en tests: "Estoy en la pantalla home"
# ========================================
Estoy en la pantalla home
    [Documentation]    Verifica que estoy en la pantalla home
    Verify Home Screen Elements    # Valida todos los elementos principales de la pantalla

# ========================================
# STEP: Abro el menú lateral
# ========================================
# Descripción: Hace click en el botón del menú hamburguesa (arriba izquierda)
# Resultado: Se abre el menú lateral con opciones como Login, Logout, etc.
# Uso en tests: "Abro el menú lateral"
# ========================================
Abro el menú lateral
    [Documentation]    Abre el menú hamburguesa
    Click View Menu    # Click en el botón del menú (accessibility_id=View menu)

# ========================================
# STEP: Selecciono la opción Login
# ========================================
# Descripción: Hace click en la opción "Login" del menú lateral
# Prerequisito: El menú lateral debe estar abierto (usar "Abro el menú lateral" antes)
# Resultado: Navega a la pantalla de login
# Uso en tests: "Selecciono la opción Login"
# ========================================
Selecciono la opción Login
    [Documentation]    Hace click en Login del menú
    Click Login Menu Item    # Click en accessibility_id=Login Menu Item

# ========================================
# STEP: Debo ver la opción Logout en el menú
# ========================================
# Descripción: Verifica que la opción "Logout" está visible en el menú lateral
# Propósito: Confirmar que el usuario está logueado (Logout solo aparece si hay sesión activa)
# Prerequisito: El menú lateral debe estar abierto
# Uso en tests: "Debo ver la opción Logout en el menú"
# ========================================
Debo ver la opción Logout en el menú
    [Documentation]    Verifica que el usuario está logueado
    Verify Logout Menu Item Visible    # Valida que accessibility_id=Logout Menu Item existe

# ========================================
# STEP: Selecciono la opción Logout
# ========================================
# Descripción: Hace click en la opción "Logout" del menú lateral
# Prerequisito: El usuario debe estar logueado y el menú abierto
# Resultado: Muestra un alert de confirmación de logout
# Uso en tests: "Selecciono la opción Logout"
# ========================================
Selecciono la opción Logout
    [Documentation]    Hace click en Logout del menú
    Click Logout Menu Item    # Click en accessibility_id=Logout Menu Item

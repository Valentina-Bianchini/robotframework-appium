# 🤖 Robot Framework + Appium - Testing Framework para Android

Framework de testing automatizado usando Robot Framework, Appium y Python para testear aplicaciones Android en dispositivos reales.

**Aplicación bajo prueba:** My Demo App (com.saucelabs.mydemoapp.android)  
**Dispositivo:** moto g82 5G (Android 13.0)

---

## 📋 Tabla de Contenidos

- [Características](#-características)
- [Prerequisitos](#-prerequisitos)
- [Instalación](#-instalación)
- [Estructura del Proyecto](#-estructura-del-proyecto)
- [Configuración del Dispositivo Real](#-configuración-del-dispositivo-real)
- [Ejecutar Tests](#-ejecutar-tests)
- [Arquitectura](#-arquitectura)
- [Documentación Adicional](#-documentación-adicional)

---

## ✨ Características

✅ **Page Object Model (POM)** - Separación clara entre elementos, acciones y tests  
✅ **Keywords reutilizables** - Funciones auxiliares en helpers.robot  
✅ **Tests legibles** - Sintaxis clara y descriptiva  
✅ **Dispositivos reales** - Configurado para Android físico con UDID  
✅ **Código completamente comentado** - Documentación inline en todos los archivos  
✅ **Reportes automáticos** - HTML reports generados por Robot Framework  
✅ **Screenshots automáticos** - Capturas en caso de errores  

---

## 🔧 Prerequisitos

### Software Requerido

1. **Python 3.8+** - [Descargar Python](https://www.python.org/downloads/)
2. **Node.js** - [Descargar Node.js](https://nodejs.org/)
3. **Appium Server** - Instalar globalmente:
   ```bash
   npm install -g appium
   ```
4. **Android SDK** - [Descargar Android Studio](https://developer.android.com/studio)
5. **ADB (Android Debug Bridge)** - Incluido en Android SDK

### Configuración de Variables de Entorno

```bash
# Agregar al PATH (Windows):
ANDROID_HOME = C:\Users\TU_USUARIO\AppData\Local\Android\Sdk
PATH += %ANDROID_HOME%\platform-tools
PATH += %ANDROID_HOME%\tools
```

### Dispositivo Android

- ✅ Depuración USB habilitada
- ✅ Conectado por cable USB
- ✅ Drivers instalados correctamente

---

## 🚀 Instalación

### 1. Clonar el Repositorio

```bash
git clone https://github.com/Valentina-Bianchini/robotframework-appium.git
cd robotframework-appium
```

### 2. Instalar Dependencias de Python

```bash
pip install robotframework-appiumlibrary
```

**Nota:** Si ya tienes Robot Framework y Appium instalados, solo necesitas instalar `robotframework-appiumlibrary`.

### 3. Verificar Instalación de Appium

```bash
appium --version
```

### 4. Verificar Conexión del Dispositivo

```bash
adb devices
```

**Salida esperada:**
```
List of devices attached
ZY22FLDZMN      device
```

### 5. Iniciar Appium Server

```bash
appium
```

**Salida esperada:**
```
[Appium] Welcome to Appium v2.x.x
[Appium] Appium REST http interface listener started on http://localhost:4723
```

---

## 📁 Estructura del Proyecto

```
robot-framework-appium/
├── app/
│   ├── base/
│   │   ├── base.robot              # ⚙️ Configuración de Appium y capabilities del dispositivo
│   │   └── helpers.robot           # 🛠️ Funciones auxiliares reutilizables
│   ├── pages/
│   │   ├── splashPage.robot        # 📱 Page Object: Splash Screen
│   │   ├── homePage.robot          # 📱 Page Object: Home y Menú Lateral
│   │   └── loginPage.robot         # 📱 Page Object: Login/Logout
│   ├── steps/
│   │   ├── splashStep.robot        # 🎬 Steps: Splash Screen
│   │   ├── homeStep.robot          # 🎬 Steps: Navegación Home
│   │   └── loginStep.robot         # 🎬 Steps: Autenticación
│   └── tests/
│       ├── connectionTest.robot    # ✅ Test: Verificación de conexión
│       └── loginTest.robot         # ✅ Test: Login y Logout completo
├── resources/
│   ├── android/
│   │   └── mda-2.2.0-25.apk       # 📦 APK de la aplicación bajo prueba
│   └── libs/
│       └── extend.py               # 🐍 Librería Python personalizada
├── results/                        # 📊 Reportes generados automáticamente
│   ├── log.html
│   ├── report.html
│   └── output.xml
├── requirements.txt                # 📋 Dependencias de Python
└── README.md                       # 📖 Este archivo
```

---

## 📱 Configuración del Dispositivo Real

### Obtener Información del Dispositivo

1. **UDID del dispositivo:**
   ```bash
   adb devices
   ```
   
2. **Versión de Android:**
   ```bash
   adb shell getprop ro.build.version.release
   ```

3. **Modelo del dispositivo:**
   ```bash
   adb shell getprop ro.product.model
   ```

### Actualizar Capabilities en base.robot

Editar `app/base/base.robot` con los datos de tu dispositivo:

```robot
${PLATFORM_VERSION}             13.0              # ⚠️ Tu versión de Android
${DEVICE_NAME}                  moto g82 5G       # ⚠️ Nombre de tu dispositivo
${UDID}                         ZY22FLDZMN        # ⚠️ UDID de tu dispositivo (adb devices)
${APP}                          C:/ruta/completa/al/apk    # ⚠️ Ruta absoluta de tu APK
```

---

## ▶️ Ejecutar Tests

### Test de Conexión (Smoke Test)

Verifica que todo está configurado correctamente:

```bash
robot -d results app/tests/connectionTest.robot
```

### Test de Login Completo

Ejecuta el flujo completo de autenticación:

```bash
robot -d results app/tests/loginTest.robot
```

### Ejecutar Todos los Tests

```bash
robot -d results app/tests/
```

### Ver Reportes

Los reportes se generan automáticamente en la carpeta `results/`:

- **report.html** - Resumen ejecutivo del test
- **log.html** - Log detallado con capturas de pantalla
- **output.xml** - Salida en formato XML

Abrir en navegador:
```bash
start results/report.html    # Windows
open results/report.html     # Mac
xdg-open results/report.html # Linux
```

---

## 🏗️ Arquitectura

### Page Object Model (POM)

El framework sigue el patrón **Page Object Model** para mantener el código organizado y mantenible:

```
┌─────────────┐
│   TESTS     │  ← Define los casos de prueba
└──────┬──────┘
       │ usa
┌──────▼──────┐
│   STEPS     │  ← Acciones de negocio (Dado, Cuando, Entonces)
└──────┬──────┘
       │ usa
┌──────▼──────┐
│   PAGES     │  ← Locators y keywords de elementos UI
└──────┬──────┘
       │ usa
┌──────▼──────┐
│   HELPERS   │  ← Funciones auxiliares reutilizables
└─────────────┘
```

### Capas del Framework

1. **Base Layer** (`app/base/`)
   - Configuración de Appium y capabilities
   - Keywords auxiliares reutilizables

2. **Page Object Layer** (`app/pages/`)
   - Locators de elementos (accessibility_id, id, xpath)
   - Keywords específicos de cada pantalla

3. **Step Layer** (`app/steps/`)
   - Acciones de negocio escritas en lenguaje natural
   - Encapsulan la lógica de los page objects

4. **Test Layer** (`app/tests/`)
   - Casos de prueba end-to-end
   - Combinan steps para crear flujos completos

---

## 📝 Capabilities Utilizadas

```json
{
  "platformName": "Android",
  "appium:platformVersion": "13.0",
  "appium:deviceName": "moto g82 5G",
  "appium:udid": "ZY22FLDZMN",
  "appium:automationName": "UiAutomator2",
  "appium:app": "C:/ruta/completa/resources/android/mda-2.2.0-25.apk",
  "appium:appPackage": "com.saucelabs.mydemoapp.android",
  "appium:appActivity": ".view.activities.SplashActivity",
  "appium:waitForIdleTimeout": 10000
}
```

---

## 🔍 Documentación Adicional

### Código Completamente Comentado

Todos los archivos `.robot` incluyen comentarios detallados:

- **Propósito** de cada keyword
- **Prerequisitos** necesarios
- **Argumentos** y valores de retorno
- **Locators** utilizados
- **Uso** en tests

### Comandos Útiles

```bash
# Listar dispositivos conectados
adb devices

# Ver logs del dispositivo en tiempo real
adb logcat

# Instalar APK manualmente
adb install resources/android/mda-2.2.0-25.apk

# Desinstalar aplicación
adb uninstall com.saucelabs.mydemoapp.android

# Reiniciar ADB
adb kill-server && adb start-server

# Ver información del dispositivo
adb shell getprop
```

### Extensiones Recomendadas para VS Code

```
RobotCode - Robot Framework Support (d-biehl.robotcode)
Rainbow End (jduponchelle.rainbow-end)
```

Instalar desde VS Code:
```
Ctrl+Shift+X → Buscar "RobotCode"
```

---

## 🐛 Troubleshooting

### Error: "No devices found"
```bash
# Solución:
adb kill-server
adb start-server
adb devices
```

### Error: "Session not created"
- Verificar que Appium Server esté corriendo
- Verificar que el UDID en base.robot sea correcto
- Verificar que la ruta del APK sea absoluta y correcta

### Error: "Element not found"
- Usar Appium Inspector para verificar los locators
- Ajustar los timeouts en helpers.robot
- Verificar que la app esté en la pantalla correcta

---

## 👥 Contribuciones

Las contribuciones son bienvenidas. Por favor:

1. Fork el repositorio
2. Crea una rama para tu feature (`git checkout -b feature/nueva-funcionalidad`)
3. Commit tus cambios (`git commit -m 'Agregar nueva funcionalidad'`)
4. Push a la rama (`git push origin feature/nueva-funcionalidad`)
5. Abre un Pull Request

---

## 📄 Licencia

Este proyecto está bajo la Licencia MIT.

---

## 📞 Contacto

**Autor:** Valentina Bianchini  
**Repositorio:** https://github.com/Valentina-Bianchini/robotframework-appium

---

⭐ Si este proyecto te resultó útil, ¡considera darle una estrella en GitHub!

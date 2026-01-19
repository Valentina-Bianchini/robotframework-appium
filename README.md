# 🤖 Robot Framework Appium - Test Automation Suite

## 📖 Descripción General

Suite completa de automatización de tests para **BlazeDemo.com** (aplicación web de reservas de vuelos) y **APIs REST**. Este proyecto utiliza **Robot Framework** con **SeleniumLibrary** y **RequestsLibrary**, siguiendo el patrón **Page Object Model (POM)** para crear tests mantenibles, escalables y reutilizables.

### 🎯 Características Principales

✅ **Testing Web UI** - Selenium + Robot Framework  
✅ **Testing de APIs REST** - RequestsLibrary + JSON validation  
✅ **Page Object Model** - Arquitectura limpia y mantenible  
✅ **Tests BDD** - Sintaxis Given/When/Then legible  
✅ **Cobertura completa** - Smoke, E2E, negativos y validaciones  
✅ **Datos parametrizados** - Variables centralizadas y reutilizables  
✅ **Cross-browser** - Chrome, Firefox, Edge  
✅ **Screenshots automáticos** - Capturas en caso de falla  
✅ **Reportes detallados** - HTML reports con logs completos  
✅ **Agente AI integrado** - Generación automática de tests con IA  

---

## 📁 Estructura del Proyecto

```
robot-framework-appium/
│
├── 🌐 web/                          # Tests de aplicación web (BlazeDemo)
│   ├── pages/                       # Page Objects
│   │   ├── homePage.robot          # Página principal
│   │   ├── flightListPage.robot    # Lista de vuelos
│   │   ├── purchasePage.robot      # Formulario de compra
│   │   └── confirmationPage.robot  # Confirmación de reserva
│   │
│   ├── steps/                       # Business Logic Steps (BDD)
│   │   ├── flightSearchSteps.robot # Steps de búsqueda
│   │   └── flightBookingSteps.robot# Steps de reserva
│   │
│   ├── tests/                       # Test Cases
│   │   ├── smokeTests.robot        # Tests básicos (conectividad)
│   │   ├── fullFlowTests.robot     # Tests end-to-end
│   │   └── negativeTests.robot     # Tests de validación y error handling
│   │
│   ├── data/                        # Test Data & Locators
│   │   ├── testData.robot          # Variables y datos de prueba
│   │   └── locators.robot          # Localizadores de elementos
│   │
│   └── run_tests.bat               # Script de ejecución (Windows)
│
├── 🔌 api/                          # Tests de APIs REST
│   ├── config/                      # Configuración base
│   │   ├── base.robot              # Setup de RequestsLibrary
│   │   └── helpers.robot           # Keywords auxiliares
│   │
│   ├── data/                        # Datos de prueba
│   │   ├── testData.robot          # Variables globales
│   │   ├── variables.robot         # Configuraciones
│   │   └── environments.robot      # Environments (dev/staging/prod)
│   │
│   ├── schemas/                     # Validación de respuestas
│   │   ├── objectSchema.json       # JSON schema para objetos
│   │   └── errorSchema.json        # JSON schema para errores
│   │
│   ├── tests/                       # Test Cases
│   │   ├── smokeTests.robot        # Tests básicos
│   │   ├── crudTests.robot         # Tests CRUD completos
│   │   ├── validationTests.robot   # Tests de validación
│   │   └── negativeTests.robot     # Tests negativos
│   │
│   ├── postman/                     # Integración Postman
│   │   ├── collection.json         # Colección Postman exportada
│   │   └── environment.json        # Environment Postman
│   │
│   └── reports/                     # Reportes de API tests
│       ├── log.html
│       ├── output.xml
│       └── report.html
│
├── 📱 app/                          # Tests Mobile (Appium)
│   ├── base/                        # Base keywords
│   │   ├── base.robot              # Setup de Appium
│   │   └── helpers.robot           # Keywords auxiliares
│   │
│   ├── pages/                       # Page Objects Mobile
│   │   ├── splashPage.robot        # Pantalla splash
│   │   ├── loginPage.robot         # Login page
│   │   └── homePage.robot          # Home page mobile
│   │
│   ├── steps/                       # BDD Steps
│   │   ├── splashStep.robot
│   │   ├── loginStep.robot
│   │   └── homeStep.robot
│   │
│   └── tests/                       # Test Cases
│       ├── connectionTest.robot    # Tests de conectividad
│       └── loginTest.robot         # Tests de login
│
├── 📦 resources/                    # Recursos compartidos
│   ├── libs/                        # Librerías Python customizadas
│   │   ├── extend.py               # Extensiones personalizadas
│   │   └── __pycache__/
│   │
│   └── android/                     # Recursos Android
│
├── 📊 results/                      # Reportes generados
│   ├── log.html                    # Log detallado
│   ├── report.html                 # Reporte ejecutivo
│   └── output.xml                  # Output para CI/CD
│
├── 🤖 .github/agents/               # Agentes AI
│   └── api-test-generator.agent.md # Generador automático de tests API
│
├── ⚙️ .vscode/                      # Configuración VSCode
│   ├── settings.json               # Configuraciones de editor
│   └── mcp.json                    # Configuración MCP Postman
│
├── 📋 requirements.txt              # Dependencias Python
├── 📖 README.md                     # Este archivo
└── 📄 LICENSE                       # Licencia MIT
```

---

## 🚀 Instalación y Configuración

### Prerequisitos

```bash
# Python 3.8 o superior
python --version

# pip actualizado
python -m pip install --upgrade pip
```

### 1️⃣ Instalación de Dependencias

```bash
# Clonar o descargar el proyecto
git clone https://github.com/tu-repo/robot-framework-appium.git
cd robot-framework-appium

# Crear entorno virtual (recomendado)
python -m venv .venv

# Activar entorno virtual
# Windows:
.venv\Scripts\activate
# macOS/Linux:
source .venv/bin/activate

# Instalar dependencias desde requirements.txt
pip install -r requirements.txt
```

### 2️⃣ Verificar Instalación

```bash
# Verificar Robot Framework
robot --version

# Verificar SeleniumLibrary
python -m pip show robotframework-seleniumlibrary

# Verificar RequestsLibrary
python -m pip show robotframework-requests

# Verificar webdriver-manager
python -m pip show webdriver-manager
```

### 3️⃣ Configuración de VSCode (Recomendado)

Extensiones necesarias:
- **RobotCode** - Soporte de Robot Framework
- **Python** - Soporte de Python
- **Postman** - Integración con Postman (opcional)

Configuración en `.vscode/settings.json`:
```json
{
  "robotcode.robot.strictSettingsHeader": false,
  "[robotframework]": {
    "editor.tabSize": 4,
    "editor.insertSpaces": true
  }
}
```

---

## ▶️ Ejecutar Tests

### 🌐 Tests Web (BlazeDemo)

#### Smoke Tests (Rápidos - 2 min)

```bash
# Ejecutar todos los smoke tests
robot -d results web/tests/smokeTests.robot

# Con log detallado
robot -d results -L DEBUG web/tests/smokeTests.robot

# Con screenshot en fallo
robot -d results --screenshot on:failure web/tests/smokeTests.robot
```

#### Tests End-to-End Completos

```bash
# Ejecutar todos los tests E2E
robot -d results web/tests/fullFlowTests.robot

# Ejecutar test específico
robot -d results -t "E2E Test 01*" web/tests/fullFlowTests.robot

# Ejecutar con tag específico
robot -d results -i Critical web/tests/fullFlowTests.robot

# Ejecutar con navegador específico
robot -d results -v BROWSER:Firefox web/tests/fullFlowTests.robot
```

#### Tests Negativos (Validaciones)

```bash
# Ejecutar todos los tests negativos
robot -d results web/tests/negativeTests.robot

# Solo tests de validación
robot -d results -i Validation web/tests/negativeTests.robot

# Solo tests de seguridad
robot -d results -i Security web/tests/negativeTests.robot
```

#### Ejecutar Todos los Tests Web

```bash
# Suite completa
robot -d results web/tests/

# Con ejecución paralela (requiere pabot)
# pip install robotframework-pabot
pabot -d results --processes 4 web/tests/
```

---

### 🔌 Tests de API REST

#### Smoke Tests API

```bash
# Tests básicos de conectividad
robot -d results api/tests/smokeTests.robot

# Con validación de response time
robot -d results -v TIMEOUT:5s api/tests/smokeTests.robot
```

#### Tests CRUD Completos

```bash
# Operaciones completas: Create, Read, Update, Delete
robot -d results api/tests/crudTests.robot

# Solo tests de creación
robot -d results -i Create api/tests/crudTests.robot

# Solo tests de eliminación
robot -d results -i Delete api/tests/crudTests.robot
```

#### Tests de Validación

```bash
# Validación de schemas y datos
robot -d results api/tests/validationTests.robot

# Validación de campos específicos
robot -d results -i FieldValidation api/tests/validationTests.robot
```

#### Tests Negativos API

```bash
# Casos de error y edge cases
robot -d results api/tests/negativeTests.robot

# Solo tests de 404 (no encontrado)
robot -d results -i NotFound api/tests/negativeTests.robot

# Solo tests de 400 (bad request)
robot -d results -i BadRequest api/tests/negativeTests.robot
```

#### Tests con Environment Específico

```bash
# Ejecutar contra staging
robot -d results -v ENV:staging api/tests/

# Ejecutar contra producción (con precaución)
robot -d results -v ENV:production api/tests/smokeTests.robot
```

---

### 📱 Tests Mobile (Appium)

#### Tests de Conectividad

```bash
# Verificar conexión con dispositivo/emulador
robot -d results app/tests/connectionTest.robot
```

#### Tests de Login

```bash
# Tests de autenticación mobile
robot -d results app/tests/loginTest.robot

# Con credenciales específicas
robot -d results -v USERNAME:user1 -v PASSWORD:pass1 app/tests/loginTest.robot
```

---

### 🎯 Ejecuciones Personalizadas

#### Ejecutar todos los tests

```bash
# Suite completa (web + api + mobile)
robot -d results web/ api/ app/

# Solo tests críticos de todas las suites
robot -d results -i Critical web/ api/
```

#### Con variables personalizadas

```bash
# Múltiples variables
robot -d results \
  -v BROWSER:Chrome \
  -v HEADLESS:False \
  -v ENV:staging \
  web/tests/

# Desde archivo de variables
robot -d results -V variables.yaml web/tests/
```

#### Generar reportes personalizados

```bash
# Con título personalizado
robot -d results \
  --reporttitle "BlazeDemo Test Report" \
  --logtitle "Execution Log" \
  web/tests/

# Generar solo output XML (para integración)
robot -d results --output output.xml --log NONE --report NONE web/tests/
```

---

## 📊 Ver Resultados

Los reportes se generan automáticamente en la carpeta `results/`:

### Abrir Reportes

```bash
# Windows
start results/report.html       # Reporte ejecutivo
start results/log.html          # Log detallado
start results/output.xml        # Output XML

# macOS
open results/report.html
open results/log.html

# Linux
xdg-open results/report.html
xdg-open results/log.html
```

### Interpretar Resultados

- **report.html** - Resumen ejecutivo con gráficos
- **log.html** - Log detallado de cada paso ejecutado
- **output.xml** - XML para integración con CI/CD
- **Screenshots** - Capturas automáticas en caso de fallo

---

## 🎨 Personalización

### Cambiar Navegador

Editar `web/data/testData.robot`:

```robot
*** Variables ***
${BROWSER}          Chrome      # Opciones: Chrome, Firefox, Edge, Safari
${HEADLESS}         False       # True para modo headless
${TIMEOUT}          10s         # Timeout por defecto
```

O pasar como parámetro:

```bash
robot -d results -v BROWSER:Firefox -v HEADLESS:True web/tests/
```

### Cambiar Timeouts

Editar `web/data/testData.robot`:

```robot
*** Variables ***
${SHORT_TIMEOUT}    3s
${MEDIUM_TIMEOUT}   10s
${LONG_TIMEOUT}     30s
```

### Agregar Nuevas Ciudades (BlazeDemo)

Editar `web/data/testData.robot`:

```robot
*** Variables ***
@{DEPARTURE_CITIES}    Boston    Portland    Philadelphia    Miami    Denver
@{DESTINATION_CITIES}  Rome      London      Berlin          Paris    Madrid
```

### Cambiar URL Base de API

Editar `api/data/environments.robot`:

```robot
*** Variables ***
${DEV_URL}          https://api-dev.example.com
${STAGING_URL}      https://api-staging.example.com
${PROD_URL}         https://api.example.com
```

---

## 🏷️ Tags Disponibles

### Tags Web

| Tag | Descripción | Uso |
|-----|-------------|-----|
| `Smoke` | Tests básicos de conectividad | `-i Smoke` |
| `Critical` | Tests críticos que deben pasar | `-i Critical` |
| `E2E` | Tests end-to-end completos | `-i E2E` |
| `Booking` | Proceso de reserva | `-i Booking` |
| `Negative` | Casos negativos | `-i Negative` |
| `Validation` | Validación de datos | `-i Validation` |
| `Security` | Tests de seguridad | `-i Security` |
| `Quick` | Tests rápidos (< 30s) | `-i Quick` |

### Tags API

| Tag | Descripción | Uso |
|-----|-------------|-----|
| `GET` | Tests GET requests | `-i GET` |
| `POST` | Tests POST requests | `-i POST` |
| `PUT` | Tests PUT requests | `-i PUT` |
| `DELETE` | Tests DELETE requests | `-i DELETE` |
| `Create` | Creación de recursos | `-i Create` |
| `Read` | Lectura de recursos | `-i Read` |
| `Update` | Actualización de recursos | `-i Update` |
| `Delete` | Eliminación de recursos | `-i Delete` |
| `Schema` | Validación de schemas | `-i Schema` |

### Ejemplos de Uso

```bash
# Solo tests críticos
robot -d results -i Critical web/tests/

# Tests rápidos para CI
robot -d results -i Quick web/tests/

# Excluir tests lentos
robot -d results -e Stress web/tests/

# Combinar múltiples tags
robot -d results -i E2E -i Critical web/tests/

# GET requests de API
robot -d results -i GET api/tests/
```

---

## 🐛 Debugging y Troubleshooting

### Modo Verbose (Debug completo)

```bash
robot -d results -L DEBUG web/tests/smokeTests.robot
```

### Pausar Ejecución Manual

```robot
*** Test Cases ***
Test Con Pausa
    # Pausa de 10 segundos
    Sleep    10s
    
    # Pausa hasta presionar OK
    Import Library    Dialogs
    Pause Execution
    
    # Screenshot manual
    Capture Page Screenshot    screenshot_manual.png
```

### Validar Sintaxis Sin Ejecutar

```bash
robot --dryrun web/tests/smokeTests.robot
```

---

## 🐛 Errores Comunes y Soluciones

### Error: "WebDriverException"

```bash
# Actualizar webdriver-manager
pip install --upgrade webdriver-manager

# O descargar driver manualmente:
# Chrome: https://chromedriver.chromium.org/
# Firefox: https://github.com/mozilla/geckodriver/releases
```

### Error: "Element not found"

**Causa:** Timeout insuficiente o localizador incorrecto

```robot
# Solución 1: Aumentar timeout en testData.robot
${MEDIUM_TIMEOUT}    15s  # En lugar de 10s

# Solución 2: Verificar localizador
Wait Until Page Contains Element    ${LOCATOR}    ${LONG_TIMEOUT}

# Solución 3: Usar Wait keywords
Wait Until Element Is Visible    ${LOCATOR}    10s
```

### Error: "Browser not opening"

```bash
# Verificar instalación del navegador
google-chrome --version      # Linux
chrome --version             # Windows cmd
/Applications/Chrome.app/Contents/MacOS/Google\ Chrome --version  # macOS
```

### Error: "ConnectionError" en API tests

```bash
# Verificar URL base
# Revisar variables en api/data/environments.robot

# Verificar conectividad
ping api.ejemplo.com

# Aumentar timeout
robot -d results -v TIMEOUT:30s api/tests/
```

### Tests lentos

```robot
# Reducir Selenium Speed
Set Selenium Speed    0.05s  # Más rápido

# O usar Headless
robot -d results -v HEADLESS:True web/tests/
```

---

## 🔧 Integración CI/CD

### GitHub Actions

```yaml
# .github/workflows/robot-tests.yml
name: Robot Framework Tests

on: [push, pull_request]

jobs:
  test:
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v3
      
      - name: Set up Python
        uses: actions/setup-python@v4
        with:
          python-version: '3.10'
      
      - name: Install dependencies
        run: pip install -r requirements.txt
      
      - name: Run Web Tests
        run: robot -d results -v HEADLESS:True web/tests/
      
      - name: Run API Tests
        run: robot -d results api/tests/
      
      - name: Upload reports
        if: always()
        uses: actions/upload-artifact@v3
        with:
          name: robot-reports
          path: results/
      
      - name: Publish results
        if: always()
        uses: dorny/test-reporter@v1
        with:
          name: Robot Framework Results
          path: results/output.xml
          reporter: 'java-junit'
```

### Jenkins Pipeline

```groovy
pipeline {
    agent any
    
    stages {
        stage('Setup') {
            steps {
                sh 'pip install -r requirements.txt'
            }
        }
        
        stage('Web Tests') {
            steps {
                sh 'robot -d results -v HEADLESS:True web/tests/'
            }
        }
        
        stage('API Tests') {
            steps {
                sh 'robot -d results api/tests/'
            }
        }
    }
    
    post {
        always {
            publishHTML([
                reportDir: 'results',
                reportFiles: 'report.html',
                reportName: 'Robot Test Report'
            ])
        }
    }
}
```

---

## 🤖 Agente AI - Generador Automático de Tests

### 📌 Descripción

Este proyecto incluye un **Agente AI integrado** que genera automáticamente tests completos para APIs REST usando Robot Framework y Postman. El agente analiza endpoints, detecta métodos HTTP y crea casos de prueba robustos sin intervención manual.

### 🎯 Capacidades del Agente

✅ **Análisis automático de APIs** - Detecta endpoints y métodos HTTP  
✅ **Generación de tests** - Crea casos de prueba CRUD, validación y negativos  
✅ **Integración Postman** - Crea colecciones y environments en Postman  
✅ **Validación de schemas** - Valida respuestas contra JSON schemas  
✅ **Tests parametrizados** - Soporta múltiples ambientes (dev, staging, prod)  
✅ **Reportes organizados** - Agrupa por endpoint y método HTTP  

### 🚀 Cómo Usar el Agente

#### Activación Automática

El agente se activa mencionando palabras clave:

```
"Genera tests para la API de https://api.ejemplo.com"
"Crea tests CRUD para mis endpoints"
"Genera suite de tests para APIs REST"
```

#### Comandos Principales

**1. Generación Completa**

```
"Genera tests completos para la API de https://api.restful-api.dev/objects 
que incluya CRUD, validaciones y casos negativos. 
Crea también una colección en Postman."
```

**Resultado:**
- ✅ Estructura completa en `api/tests/`
- ✅ Tests CRUD, validación y negativos
- ✅ Colección Postman automática
- ✅ Environments configurados
- ✅ Reportes generados

**2. Tests Específicos por Tipo**

```
"Crea solo smoke tests para validar conectividad"
```

```
"Genera tests de validación de schemas JSON"
```

```
"Crea tests negativos para casos de error"
```

**3. Tests con Datos Personalizados**

```
"Genera tests usando estos ambientes: development, staging, production"
```

```
"Crea tests con autenticación Bearer token"
```

#### Características del Agente

- **Detección automática** - Analiza la API y detecta endpoints
- **Generación inteligente** - Crea tests relevantes para cada endpoint
- **Reutilizable** - Keywords genéricos para múltiples APIs
- **Mantenible** - Estructura clara y bien organizada
- **Documentación** - Genera comentarios explicativos

#### Ejemplo de Flujo

1. **Usuario solicita:**
   ```
   "Genera tests para https://jsonplaceholder.typicode.com/posts"
   ```

2. **Agente analiza:**
   - GET /posts (listar todos)
   - POST /posts (crear)
   - GET /posts/{id} (obtener uno)
   - PUT /posts/{id} (actualizar)
   - DELETE /posts/{id} (eliminar)

3. **Agente genera:**
   - ✅ Smoke tests de conectividad
   - ✅ CRUD tests completos
   - ✅ Validation tests con schemas
   - ✅ Negative tests (404, 400, etc.)
   - ✅ Colección Postman
   - ✅ Reportes HTML

4. **Usuario ejecuta:**
   ```bash
   robot -d results api/tests/
   # O desde Postman directamente
   ```

#### Configuración Requerida para el Agente

Para que el agente funcione con Postman MCP:

1. **Postman API Key** (archivo `.env`):
   ```
   POSTMAN_API_KEY=your_api_key_here
   POSTMAN_WORKSPACE_ID=your_workspace_id
   ```

2. **Configuración MCP** (`.vscode/mcp.json`):
   ```json
   {
     "servers": {
       "com.postman/postman-mcp-server": {
         "type": "stdio",
         "command": "npx",
         "args": ["@postman/postman-mcp-server@2.5.4"],
         "env": {
           "POSTMAN_API_KEY": "${input:POSTMAN_API_KEY}"
         }
       }
     }
   }
   ```

### 📖 Documentación del Agente

Para detalles completos sobre el agente, ver:
- **Archivo:** `.github/agents/api-test-generator.agent.md`
- **Contiene:** Casos de uso, configuración avanzada, ejemplos

---

## 🎓 Conceptos Clave

### Page Object Model (POM)

La arquitectura del proyecto sigue el patrón POM:

```
pages/            → Contienen localizadores y keywords de elementos
steps/            → Lógica de negocio en sintaxis BDD
tests/            → Casos de prueba que usan los steps
```

**Ventajas:**
- 🔄 Reutilización de código
- 🛠️ Fácil mantenimiento
- 📊 Cambios centralizados
- 👥 Colaboración efectiva

### Estructura de un Test BDD

```robot
Test Example
    [Documentation]    Descripción del test
    [Tags]    Tag1    Tag2    Critical
    
    # Given - Estado inicial (Dado)
    Given User Is On BlazeDemo Home Page
    
    # When - Acciones (Cuando)
    When User Searches Flight From "Boston" To "Rome"
    And User Selects First Available Flight
    
    # Then - Verificaciones (Entonces)
    Then Flight Results Page Should Be Displayed
    And Available Flights Should Be Shown
    And Total Price Should Be Greater Than Zero
```

### Flujo Típico de Ejecución

1. **Suite Setup** - Inicialización global
2. **Test Setup** - Preparación por test
3. **Acciones** - Ejecución de pasos
4. **Validaciones** - Verificación de resultados
5. **Test Teardown** - Limpieza por test
6. **Suite Teardown** - Limpieza global

---

## 📚 Recursos Adicionales

### Documentación Oficial

- [Robot Framework Documentation](https://robotframework.org/robotframework/)
- [SeleniumLibrary Keywords](https://robotframework.org/SeleniumLibrary/SeleniumLibrary.html)
- [RequestsLibrary Documentation](https://marketsquare.github.io/robotframework-requests/)
- [Appium Documentation](http://appium.io/)
- [Postman API Documentation](https://learning.postman.com/docs/developer/postman-api/)

### Tutoriales Recomendados

- [Robot Framework Tutorial](https://robotframework.org/#tutorials)
- [Page Object Model Pattern](https://www.selenium.dev/documentation/test_practices/encouraged/page_object_models/)
- [BDD with Robot Framework](https://robotframework.org/robotframework/latest/RobotFrameworkUserGuide.html#behavior-driven-style)

### Sitios de Prueba

- [BlazeDemo](https://blazedemo.com/) - Aplicación de prueba oficial
- [JSONPlaceholder](https://jsonplaceholder.typicode.com/) - API REST fake
- [Reqres.in](https://reqres.in/) - API REST de prueba con usuarios

---

## 🎯 Mejores Prácticas

✅ **Usar Page Object Model** - Mantén localizadores en pages/  
✅ **Datos parametrizados** - Centraliza variables en data/  
✅ **Nombres descriptivos** - Keywords y tests claros  
✅ **Tags organizadas** - Agrupa tests por categoría  
✅ **Setup/Teardown** - Limpieza automática de datos  
✅ **Validaciones explícitas** - Assertions claras y descriptivas  
✅ **Logging detallado** - Facilita debugging  
✅ **Reutilización de código** - DRY (Don't Repeat Yourself)  

---

## 📝 Licencia

Este proyecto está disponible bajo la licencia **MIT**.

```
MIT License

Copyright (c) 2026 Robot Framework Appium Contributors

Permission is hereby granted, free of charge...
```

---

## 🤝 Contribución

Para contribuir al proyecto:

1. Fork el repositorio
2. Crea una rama para tu feature (`git checkout -b feature/AmazingFeature`)
3. Commit tus cambios (`git commit -m 'Add some AmazingFeature'`)
4. Push a la rama (`git push origin feature/AmazingFeature`)
5. Abre un Pull Request

---

## 📞 Soporte

Si encuentras problemas o tienes preguntas:

1. **Revisa la sección de Troubleshooting** en este README
2. **Consulta la documentación** de Robot Framework
3. **Crea un issue** en el repositorio
4. **Usa el Agente AI** para generar soluciones

---

**Creado con ❤️ por Valentina Bianchini**  
**Última actualización:** Enero 2026  
**Versión:** 2.0.0

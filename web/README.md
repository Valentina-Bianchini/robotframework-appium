# 🤖 BlazeDemo Test Generator Agent

## 📖 Descripción General

Framework de testing automatizado para **BlazeDemo.com** - aplicación de demostración de reservas de vuelos. Este proyecto utiliza **Robot Framework** con **SeleniumLibrary** siguiendo el patrón **Page Object Model (POM)** para crear tests mantenibles y escalables.

## 🎯 Características Principales

✅ **Generación automática de tests** - El agente crea tests completos para BlazeDemo  
✅ **Page Object Model** - Arquitectura limpia y mantenible  
✅ **Tests BDD** - Sintaxis Given/When/Then legible  
✅ **Cobertura completa** - Smoke, E2E, negativos y validaciones  
✅ **Datos parametrizados** - Variables centralizadas y reutilizables  
✅ **Cross-browser** - Compatible con Chrome, Firefox, Edge  
✅ **Screenshots automáticos** - Capturas en caso de falla  
✅ **Reportes detallados** - HTML reports con logs completos  

## 📁 Estructura del Proyecto

```
blazedemo_tests/
├── pages/                          # 📱 Page Objects
│   ├── homePage.robot             # Página principal
│   ├── flightListPage.robot       # Lista de vuelos
│   ├── purchasePage.robot         # Formulario de compra
│   └── confirmationPage.robot     # Confirmación de reserva
│
├── steps/                          # 🎬 Business Logic Steps
│   ├── flightSearchSteps.robot    # Steps de búsqueda
│   └── flightBookingSteps.robot   # Steps de reserva
│
├── tests/                          # ✅ Test Cases
│   ├── smokeTests.robot           # Tests de conectividad
│   ├── fullFlowTests.robot        # Tests end-to-end
│   └── negativeTests.robot        # Tests negativos
│
├── data/                           # 📊 Test Data
│   ├── testData.robot             # Variables y datos
│   └── locators.robot             # Localizadores de elementos
│
├── mobile/                         # 📱 Mobile Tests
│   └── (futuro soporte mobile)
│
└── results/                        # 📈 Test Reports
    └── (generados automáticamente)
```

## 🚀 Instalación y Configuración

### Prerequisitos

```bash
# Python 3.8 o superior
python --version

# pip actualizado
python -m pip install --upgrade pip
```

### Instalación de Dependencias

```bash
# Instalar Robot Framework y Selenium
pip install robotframework
pip install robotframework-seleniumlibrary

# Instalar webdrivers (Chrome)
pip install webdriver-manager
```

### Verificar Instalación

```bash
# Verificar Robot Framework
robot --version

# Verificar SeleniumLibrary
pip show robotframework-seleniumlibrary
```

## ▶️ Ejecutar Tests

### Tests Básicos (Smoke Tests)

```bash
# Ejecutar smoke tests
robot -d results blazedemo_tests/tests/smokeTests.robot

# Con log detallado
robot -d results -L DEBUG blazedemo_tests/tests/smokeTests.robot
```

### Tests Completos (E2E)

```bash
# Ejecutar todos los tests E2E
robot -d results blazedemo_tests/tests/fullFlowTests.robot

# Ejecutar test específico por nombre
robot -d results -t "E2E Test 01*" blazedemo_tests/tests/fullFlowTests.robot

# Ejecutar tests con tag específico
robot -d results -i Critical blazedemo_tests/tests/fullFlowTests.robot
```

### Tests Negativos

```bash
# Ejecutar tests negativos
robot -d results blazedemo_tests/tests/negativeTests.robot

# Ejecutar solo tests de validación
robot -d results -i Validation blazedemo_tests/tests/negativeTests.robot

# Ejecutar solo tests de seguridad
robot -d results -i Security blazedemo_tests/tests/negativeTests.robot
```

### Ejecutar Todos los Tests

```bash
# Ejecutar toda la suite
robot -d results blazedemo_tests/tests/

# Con variables personalizadas
robot -d results -v BROWSER:Firefox blazedemo_tests/tests/

# En modo headless
robot -d results -v HEADLESS:True blazedemo_tests/tests/
```

## 🎯 Ejemplos de Uso del Agente

### Comando 1: Generar Tests Completos

```
"Genera tests completos para BlazeDemo con Robot Framework"
```

**Resultado**: Crea toda la estructura con smoke, E2E y tests negativos

### Comando 2: Tests Específicos

```
"Crea tests de búsqueda de vuelos desde Boston a Rome para BlazeDemo"
```

**Resultado**: Genera tests enfocados en esa ruta específica

### Comando 3: Tests con Validaciones Avanzadas

```
"Genera tests BlazeDemo con validaciones de precios y datos de pasajeros"
```

**Resultado**: Incluye verificaciones detalladas de datos

### Comando 4: Tests Negativos

```
"Crea tests negativos para el formulario de compra de BlazeDemo"
```

**Resultado**: Genera tests de validación y casos edge

## 📊 Ver Resultados

Los reportes se generan automáticamente en la carpeta `results/`:

```bash
# Abrir reporte en navegador (Windows)
start results/report.html

# Abrir log detallado
start results/log.html

# Ver output XML
start results/output.xml
```

## 🎨 Personalización

### Cambiar Navegador

```bash
# Firefox
robot -d results -v BROWSER:Firefox blazedemo_tests/tests/smokeTests.robot

# Edge
robot -d results -v BROWSER:Edge blazedemo_tests/tests/smokeTests.robot

# Chrome Headless
robot -d results -v BROWSER:Chrome -v HEADLESS:True blazedemo_tests/tests/smokeTests.robot
```

### Cambiar Timeouts

Editar archivo `data/testData.robot`:

```robot
${SHORT_TIMEOUT}     3s
${MEDIUM_TIMEOUT}    10s
${LONG_TIMEOUT}      30s
```

### Agregar Nuevas Ciudades

Editar `data/testData.robot`:

```robot
@{DEPARTURE_CITIES}    Boston    Portland    Philadelphia    TuCiudad
@{DESTINATION_CITIES}  Rome      London      Berlin          TuDestino
```

## 🏷️ Tags Disponibles

| Tag | Descripción | Uso |
|-----|-------------|-----|
| `Smoke` | Tests básicos de conectividad | `-i Smoke` |
| `Critical` | Tests críticos que deben pasar siempre | `-i Critical` |
| `E2E` | Tests end-to-end completos | `-i E2E` |
| `Booking` | Tests de proceso de reserva | `-i Booking` |
| `Negative` | Tests de casos negativos | `-i Negative` |
| `Validation` | Tests de validación de datos | `-i Validation` |
| `Security` | Tests de seguridad | `-i Security` |
| `Quick` | Tests rápidos (< 30s) | `-i Quick` |

### Ejemplos de Uso de Tags

```bash
# Solo tests críticos
robot -d results -i Critical blazedemo_tests/tests/

# Tests rápidos para CI/CD
robot -d results -i Quick blazedemo_tests/tests/

# Excluir tests lentos
robot -d results -e Stress blazedemo_tests/tests/

# Combinar tags
robot -d results -i E2E -i Critical blazedemo_tests/tests/
```

## 🐛 Debugging

### Modo Verbose

```bash
robot -d results -L DEBUG blazedemo_tests/tests/smokeTests.robot
```

### Pausar Ejecución

Agregar en el test:

```robot
# Pausar para inspección manual
Sleep    10s    # Espera 10 segundos

# O usar el debugger
Import Library    Dialogs
Pause Execution    # Pausa hasta que presiones OK
```

### Screenshots Manuales

```robot
Capture Page Screenshot    nombre_descriptivo.png
```

## 📈 Integración CI/CD

### GitHub Actions

```yaml
name: BlazeDemo Tests

on: [push, pull_request]

jobs:
  test:
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v2
      - uses: actions/setup-python@v2
        with:
          python-version: '3.10'
      - run: pip install robotframework robotframework-seleniumlibrary
      - run: robot -d results -v HEADLESS:True blazedemo_tests/tests/
      - uses: actions/upload-artifact@v2
        if: always()
        with:
          name: test-results
          path: results/
```

## 🎓 Conceptos Clave

### Page Object Model (POM)

- **Pages**: Contienen localizadores y keywords de elementos
- **Steps**: Lógica de negocio en sintaxis BDD
- **Tests**: Casos de prueba que usan los steps

### Estructura de un Test

```robot
Test Example
    [Documentation]    Descripción del test
    [Tags]    Tag1    Tag2
    
    # Given - Estado inicial
    Given User Is On BlazeDemo Home Page
    
    # When - Acciones
    When User Searches Flight From "Boston" To "Rome"
    
    # Then - Verificaciones
    Then Flight Results Page Should Be Displayed
    And Available Flights Should Be Shown
```

## 🔧 Troubleshooting

### Error: "WebDriverException"

```bash
# Actualizar webdriver
pip install --upgrade webdriver-manager
```

### Error: "Element not found"

```robot
# Aumentar timeout en testData.robot
${MEDIUM_TIMEOUT}    15s  # En lugar de 10s
```

### Error: "Browser not opening"

```bash
# Verificar instalación del navegador
google-chrome --version  # Linux
chrome --version         # Windows
```

## 📚 Recursos Adicionales

- [Robot Framework Documentation](https://robotframework.org/robotframework/)
- [SeleniumLibrary Keywords](https://robotframework.org/SeleniumLibrary/SeleniumLibrary.html)
- [BlazeDemo Official Site](https://blazedemo.com)
- [Page Object Model Pattern](https://www.selenium.dev/documentation/test_practices/encouraged/page_object_models/)

## 🤝 Contribuir

Este proyecto es generado automáticamente por el agente. Para modificaciones:

1. Editar templates del agente
2. Regenerar tests con el agente
3. Validar con `robot --dryrun`
4. Ejecutar suite completa

## 📝 Licencia

Este proyecto es de código abierto y está disponible bajo la licencia MIT.

---

**Generado por**: BlazeDemo Test Generator Agent 🤖  
**Fecha**: 2026-01-15  
**Versión**: 1.0.0

# 🤖 Guía de Uso del BlazeDemo Test Generator Agent

## 📋 Índice

1. [Activación del Agente](#activación-del-agente)
2. [Comandos Principales](#comandos-principales)
3. [Casos de Uso Comunes](#casos-de-uso-comunes)
4. [Personalización Avanzada](#personalización-avanzada)
5. [Troubleshooting](#troubleshooting)
6. [FAQs](#faqs)

---

## 🚀 Activación del Agente

El agente se activa automáticamente cuando mencionas **"BlazeDemo"** o **"generar tests"** en tu conversación. No requiere comandos especiales de activación.

### Ejemplos de Activación:

```
✅ "Genera tests para BlazeDemo"
✅ "Necesito tests de BlazeDemo con Robot Framework"
✅ "Crea tests end-to-end para la aplicación de vuelos"
✅ "Genera validaciones para el formulario de compra de BlazeDemo"
```

---

## 💬 Comandos Principales

### 1. Generación Completa

**Comando:**
```
"Genera tests completos para BlazeDemo con Robot Framework"
```

**Resultado:**
- ✅ Estructura completa de carpetas
- ✅ Page Objects para todas las páginas
- ✅ Steps con sintaxis BDD
- ✅ Smoke, E2E y Negative tests
- ✅ Datos de prueba parametrizados
- ✅ Localizadores organizados
- ✅ README con documentación

**Tiempo estimado:** 2-3 minutos

---

### 2. Tests Específicos por Tipo

#### Smoke Tests

**Comando:**
```
"Crea solo smoke tests para BlazeDemo"
```

**Resultado:**
- 5 tests básicos de conectividad
- Verificación de elementos principales
- Ejecución rápida (< 2 min)

#### E2E Tests

**Comando:**
```
"Genera tests end-to-end completos para BlazeDemo"
```

**Resultado:**
- 10 tests de flujo completo
- Desde búsqueda hasta confirmación
- Múltiples escenarios de reserva

#### Negative Tests

**Comando:**
```
"Crea tests negativos y de validación para BlazeDemo"
```

**Resultado:**
- Tests de campos vacíos
- Validaciones de formato
- Tests de seguridad (SQL Injection, XSS)
- Casos edge

---

### 3. Tests para Rutas Específicas

**Comando:**
```
"Genera tests para vuelos desde Boston a Rome en BlazeDemo"
```

**Resultado:**
- Tests específicos para esa ruta
- Validaciones de ciudades correctas
- Verificación de disponibilidad

---

### 4. Tests con Validaciones Avanzadas

**Comando:**
```
"Crea tests BlazeDemo con validaciones de precios y datos de pasajeros"
```

**Resultado:**
- Verificación de rangos de precios
- Validación de datos personales
- Comprobación de información de tarjeta
- Validación de códigos de confirmación

---

## 🎯 Casos de Uso Comunes

### Caso 1: Iniciar Proyecto de Testing desde Cero

**Situación:** Necesitas empezar a testear BlazeDemo y no tienes nada preparado.

**Comando:**
```
"Genera tests completos para BlazeDemo con Robot Framework"
```

**Siguiente paso:**
```bash
cd blazedemo_tests
robot -d results tests/smokeTests.robot
```

---

### Caso 2: Agregar Tests de Seguridad

**Situación:** Ya tienes tests básicos pero necesitas agregar casos de seguridad.

**Comando:**
```
"Agrega tests de seguridad para el formulario de BlazeDemo (SQL injection, XSS)"
```

**Resultado:**
- Tests de inyección SQL
- Tests de XSS
- Validación de sanitización de inputs

---

### Caso 3: Tests para CI/CD Pipeline

**Situación:** Necesitas tests rápidos para integración continua.

**Comando:**
```
"Crea smoke tests optimizados para CI/CD en BlazeDemo"
```

**Configuración adicional:**
```bash
robot -d results -v HEADLESS:True -i Quick blazedemo_tests/tests/
```

---

### Caso 4: Tests de Regresión Completos

**Situación:** Vas a hacer un release y necesitas validar toda la funcionalidad.

**Comando:**
```
"Genera suite completa de tests de regresión para BlazeDemo"
```

**Ejecución:**
```bash
robot -d results -i Critical blazedemo_tests/tests/
```

---

### Caso 5: Tests con Datos Personalizados

**Situación:** Necesitas testear con datos específicos de tu organización.

**Comando:**
```
"Genera tests BlazeDemo usando las ciudades: Madrid, Barcelona, Valencia"
```

**El agente modifica:** `data/testData.robot` con tus ciudades.

---

## 🎨 Personalización Avanzada

### Cambiar Configuración de Browser

**En el archivo de test, modifica:**
```robot
*** Variables ***
${BROWSER}       Chrome      # Cambiar a: Firefox, Edge
${HEADLESS}      False       # True para modo headless
```

### Agregar Nuevos Datos de Prueba

**Edita** `data/testData.robot`:

```robot
# Agregar nuevo pasajero
${TEST_NAME_3}              Carlos Rodriguez
${TEST_ADDRESS_3}           789 Main St
${TEST_CITY_3}              Miami
${TEST_STATE_3}             FL
${TEST_ZIP_3}               33101
```

### Crear Nuevos Localizadores

**Edita** `data/locators.robot`:

```robot
# Agregar nuevo localizador
${MY_NEW_ELEMENT}           xpath://div[@id='myElement']
```

### Agregar Keyword Personalizado

**En** `pages/homePage.robot`:

```robot
My Custom Keyword
    [Documentation]    Descripción de tu keyword
    [Arguments]    ${param1}    ${param2}
    
    # Tu lógica aquí
    Log    Ejecutando con ${param1} y ${param2}
```

---

## 🐛 Troubleshooting

### Error: "No se encuentra el módulo robotframework"

**Solución:**
```bash
pip install robotframework robotframework-seleniumlibrary
```

---

### Error: "WebDriver no encontrado"

**Solución:**
```bash
pip install webdriver-manager
```

O descarga manualmente:
- [ChromeDriver](https://chromedriver.chromium.org/)
- [GeckoDriver (Firefox)](https://github.com/mozilla/geckodriver/releases)

---

### Error: "Element not found"

**Posibles causas:**
1. Elemento no cargó a tiempo → Aumentar timeout
2. Localizador incorrecto → Verificar en `data/locators.robot`
3. Página cambió → Actualizar localizadores

**Solución:**
```robot
# Aumentar timeout
${MEDIUM_TIMEOUT}    15s  # En data/testData.robot
```

---

### Tests muy lentos

**Optimizaciones:**
```robot
# Reducir Selenium Speed
Set Selenium Speed    0.1s  # Más rápido

# Usar Headless
${HEADLESS}    True

# Ejecutar solo tests críticos
robot -i Critical tests/
```

---

### BlazeDemo no responde

**Verificar:**
1. Conexión a internet
2. BlazeDemo.com está activo
3. Firewall no bloquea conexión

**Solución temporal:**
```robot
# Aumentar timeout inicial
${LONG_TIMEOUT}    60s
```

---

## ❓ FAQs

### ¿Puedo usar este framework para otra aplicación?

**Respuesta:** Este agente está especializado en BlazeDemo. Para otras aplicaciones, necesitas:
1. Modificar los localizadores en `data/locators.robot`
2. Actualizar las URLs en `data/testData.robot`
3. Adaptar los Page Objects a la nueva estructura

---

### ¿Cómo agrego tests mobile?

**Respuesta:**
```
"Genera tests mobile para BlazeDemo usando Appium"
```

El agente creará tests en la carpeta `mobile/` compatibles con Appium.

---

### ¿Puedo integrar con Jenkins/GitLab CI?

**Respuesta:** Sí, ejemplo para Jenkins:

```groovy
stage('BlazeDemo Tests') {
    steps {
        sh 'pip install robotframework robotframework-seleniumlibrary'
        sh 'robot -d results -v HEADLESS:True blazedemo_tests/tests/'
    }
    post {
        always {
            publishHTML([
                reportDir: 'results',
                reportFiles: 'report.html',
                reportName: 'Robot Framework Report'
            ])
        }
    }
}
```

---

### ¿Cómo ejecuto tests en paralelo?

**Respuesta:** Usa Pabot:

```bash
pip install robotframework-pabot

pabot -d results --processes 4 blazedemo_tests/tests/
```

---

### ¿Los tests funcionan en todos los browsers?

**Respuesta:** Sí, soporta:
- ✅ Chrome
- ✅ Firefox
- ✅ Edge
- ✅ Safari (con limitaciones)

Cambiar browser:
```bash
robot -v BROWSER:Firefox tests/
```

---

### ¿Cómo guardo los resultados de tests?

**Respuesta:** Los resultados se guardan automáticamente en `results/`:
- `report.html` - Reporte ejecutivo
- `log.html` - Log detallado
- `output.xml` - XML para procesamiento

---

### ¿Puedo agregar tests de API además de UI?

**Respuesta:**
```
"Agrega tests de API REST para BlazeDemo usando RequestsLibrary"
```

El agente generará tests de API en carpeta separada.

---

## 📞 Soporte Adicional

### Comandos de Ayuda

Para obtener ayuda sobre cualquier keyword:

```bash
python -m robot.libdoc SeleniumLibrary list
python -m robot.libdoc SeleniumLibrary Show
```

### Documentación Keyword Específico

```bash
python -m robot.libdoc SeleniumLibrary::Input_Text show
```

### Validar Sintaxis Sin Ejecutar

```bash
robot --dryrun blazedemo_tests/tests/smokeTests.robot
```

---

## 🎓 Mejores Prácticas

1. **Siempre ejecuta smoke tests primero**
   ```bash
   robot -d results tests/smokeTests.robot
   ```

2. **Usa tags para organizar ejecuciones**
   ```bash
   robot -i Critical -i E2E tests/
   ```

3. **Revisa logs cuando falle un test**
   ```bash
   start results/log.html
   ```

4. **Mantén actualizados los localizadores**
   - BlazeDemo puede cambiar elementos
   - Revisa `data/locators.robot` regularmente

5. **Usa variables para datos sensibles**
   - No hardcodear datos reales
   - Usar variables en `testData.robot`

---

## 🔄 Actualizar Tests Existentes

Para actualizar tests ya generados:

```
"Actualiza los tests de BlazeDemo con nuevas validaciones de seguridad"
```

El agente:
- ✅ Mantiene tests existentes
- ✅ Agrega nuevos casos
- ✅ Actualiza keywords si es necesario
- ✅ Preserva personalizaciones

---

## 📊 Métricas y Reporting

### Ver Estadísticas

```bash
# Ejecutar con statistics
robot -d results --reporttitle "BlazeDemo Tests" tests/
```

### Combinar Múltiples Ejecuciones

```bash
rebot --output combined.xml --merge results/output1.xml results/output2.xml
```

---

**Última actualización:** 2026-01-15  
**Versión del agente:** 1.0.0  
**Contacto:** GitHub Copilot / Claude Sonnet 4.5

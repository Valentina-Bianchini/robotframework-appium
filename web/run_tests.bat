@echo off
REM ==============================================================================
REM 🤖 BlazeDemo Test Runner - Script de ejecución rápida
REM ==============================================================================

echo.
echo ========================================
echo 🤖 BlazeDemo Test Generator Agent
echo ========================================
echo.

REM Verificar que Robot Framework está instalado
robot --version >nul 2>&1
if errorlevel 1 (
    echo ❌ Error: Robot Framework no está instalado
    echo.
    echo Por favor instala las dependencias:
    echo   pip install robotframework robotframework-seleniumlibrary
    pause
    exit /b 1
)

:menu
echo.
echo Selecciona el tipo de test a ejecutar:
echo.
echo  1. 🚭 Smoke Tests (Rápidos - 2 min)
echo  2. 🛣️  E2E Tests (Completos - 10 min)
echo  3. ⚠️  Negative Tests (Validaciones - 5 min)
echo  4. 📦 Todos los Tests (Completo - 15 min)
echo  5. 🎯 Test Específico por Tag
echo  6. 🌙 Tests en Headless Mode
echo  7. ❌ Salir
echo.

set /p choice="Ingresa tu opción (1-7): "

if "%choice%"=="1" goto smoke
if "%choice%"=="2" goto e2e
if "%choice%"=="3" goto negative
if "%choice%"=="4" goto all
if "%choice%"=="5" goto bytag
if "%choice%"=="6" goto headless
if "%choice%"=="7" goto end

echo ❌ Opción inválida
goto menu

:smoke
echo.
echo 🚭 Ejecutando Smoke Tests...
robot -d results blazedemo_tests\tests\smokeTests.robot
goto results

:e2e
echo.
echo 🛣️ Ejecutando E2E Tests...
robot -d results blazedemo_tests\tests\fullFlowTests.robot
goto results

:negative
echo.
echo ⚠️ Ejecutando Negative Tests...
robot -d results blazedemo_tests\tests\negativeTests.robot
goto results

:all
echo.
echo 📦 Ejecutando TODOS los Tests...
robot -d results blazedemo_tests\tests\
goto results

:bytag
echo.
set /p tag="Ingresa el tag a ejecutar (ej: Critical, E2E, Booking): "
echo.
echo 🎯 Ejecutando tests con tag: %tag%
robot -d results -i %tag% blazedemo_tests\tests\
goto results

:headless
echo.
echo 🌙 Ejecutando tests en modo Headless...
robot -d results -v HEADLESS:True blazedemo_tests\tests\smokeTests.robot
goto results

:results
echo.
echo ========================================
echo ✅ Ejecución completada
echo ========================================
echo.
echo 📊 Ver reportes:
echo   - report.html : start results\report.html
echo   - log.html    : start results\log.html
echo.

set /p openreport="¿Abrir reporte automáticamente? (s/n): "
if /i "%openreport%"=="s" (
    start results\report.html
)

echo.
set /p again="¿Ejecutar más tests? (s/n): "
if /i "%again%"=="s" goto menu

:end
echo.
echo 👋 ¡Hasta luego!
echo.
pause

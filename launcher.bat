@echo off
REM Script de lancement des variantes du Benchmark

set PROJECT_DIR=C:\Users\youbitech\Desktop\Benchmark
cd /d %PROJECT_DIR%

echo.
echo ====================================
echo Benchmark REST Services Launcher
echo ====================================
echo.
echo Variantes disponibles:
echo 1. Variante A (Jersey + JPA)
echo 2. Variante C (Spring MVC + JPA)
echo 3. Variante D (Spring Data REST)
echo 4. Demarrer infrastructure Docker
echo 5. Arreter infrastructure Docker
echo 6. Afficher status
echo 0. Quitter
echo.

:choice_menu
set /p choice="Choisissez une option [0-6]: "

if "%choice%"=="1" goto variant_a
if "%choice%"=="2" goto variant_c
if "%choice%"=="3" goto variant_d
if "%choice%"=="4" goto docker_start
if "%choice%"=="5" goto docker_stop
if "%choice%"=="6" goto docker_status
if "%choice%"=="0" goto end

echo Choix invalide. Veuillez reessayer.
goto choice_menu

:variant_a
echo.
echo Compilation et lancement de la Variante A (Jersey)...
echo.
call mvn clean compile
call mvn spring-boot:run -Dspring-boot.run.profiles=jersey -Dspring-boot.run.arguments="--server.port=8080"
goto choice_menu

:variant_c
echo.
echo Compilation et lancement de la Variante C (Spring MVC)...
echo.
call mvn clean compile
call mvn spring-boot:run -Dspring-boot.run.profiles=mvc -Dspring-boot.run.arguments="--server.port=8080"
goto choice_menu

:variant_d
echo.
echo Compilation et lancement de la Variante D (Spring Data REST)...
echo.
call mvn clean compile
call mvn spring-boot:run -Dspring-boot.run.profiles=data-rest -Dspring-boot.run.arguments="--server.port=8080"
goto choice_menu

:docker_start
echo.
echo Demarrage de l'infrastructure Docker Compose...
echo (PostgreSQL, Prometheus, Grafana, InfluxDB)
echo.
call docker-compose up -d
echo.
echo Infrastructure demarree!
echo - PostgreSQL: localhost:5432
echo - Prometheus: http://localhost:9090
echo - Grafana: http://localhost:3000 (admin/admin)
echo - InfluxDB: http://localhost:8086
echo.
pause
goto choice_menu

:docker_stop
echo.
echo Arret de l'infrastructure Docker Compose...
echo.
call docker-compose down
echo.
echo Infrastructure arretee!
echo.
pause
goto choice_menu

:docker_status
echo.
echo Status de l'infrastructure Docker:
echo.
call docker-compose ps
echo.
pause
goto choice_menu

:end
echo.
echo Fermeture du launcher.
echo.
pause
exit /b 0


@echo off
setlocal enabledelayedexpansion

echo [%DATE% %TIME%] Iniciando build e deploy do Jamii Java SDK para o GitHub...
cd /d "%~dp0"

:: 1. Compilar e gerar os artefatos locais do Maven
call mvn clean deploy
if %ERRORLEVEL% neq 0 (
    echo.
    echo [ERRO] Falha na compilacao ou geracao local do SDK.
    pause
    exit /b %ERRORLEVEL%
)

:: 2. Entrar na pasta staging onde os pacotes foram colocados
cd target\mvn-repo

:: 3. Inicializar Git temporario e enviar forçado para o GitHub
echo.
echo [%DATE% %TIME%] Enviando artefatos para a branch 'maven-repo' no GitHub...
git init
git add .
git commit -m "Auto-deploy Java SDK"
git remote add origin https://github.com/icemagno/jamii-java-sdk.git
git push origin master:maven-repo --force

if %ERRORLEVEL% neq 0 (
    echo.
    echo [ERRO] Falha ao enviar para o GitHub. Verifique suas credenciais de push do Git.
    pause
    exit /b %ERRORLEVEL%
)

echo.
echo [SUCESSO] Jamii Java SDK publicado com sucesso no GitHub!
pause

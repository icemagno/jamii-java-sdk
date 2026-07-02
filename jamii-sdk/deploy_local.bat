@echo off
echo [%DATE% %TIME%] Iniciando build e geracao de pacotes de deploy do Jamii Java SDK...
cd /d "%~dp0"
call mvn clean deploy
if %ERRORLEVEL% neq 0 (
    echo.
    echo [ERRO] Falha ao gerar o build e pacotes de deploy do SDK.
    pause
    exit /b %ERRORLEVEL%
)
echo.
echo [SUCESSO] Pacotes do SDK gerados com sucesso na pasta staging: sdk\jamii-sdk\target\mvn-repo
echo Para concluir, envie o conteudo desta pasta para a branch 'maven-repo' do github:
echo    icemagno/jamii-java-sdk
pause

@echo off
:: Instellingen
set SERVER=localhost
set DATABASE=jamin_b
set USER=root
set SCRIPT_PATH=./

:: Controleer of de scriptmap bestaat
if not exist "%SCRIPT_PATH%" (
    echo [FOUT] Map met SQL-scripts niet gevonden: %SCRIPT_PATH%
    exit /b 1
)

:: SQL-scripts recursief zoeken en uitvoeren
echo [INFO] SQL-scripts worden uitgevoerd...
for /r "%SCRIPT_PATH%" %%f in (*.sql) do (
    echo [INFO] Bezig met uitvoeren van: %%~nxf
    mysql -h %SERVER% -u %USER%  %DATABASE% < "%%f"
    if %ERRORLEVEL% NEQ 0 (
        echo [FOUT] Er is een fout opgetreden bij het uitvoeren van %%~nxf.
        exit /b 1
    )
)

echo [INFO] Alle SQL-scripts zijn succesvol uitgevoerd.
exit /b 0
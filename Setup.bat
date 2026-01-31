@echo off
setlocal enabledelayedexpansion
echo Welcome to the Hytale Server Setup - Made by WesGoof
echo Make sure you have Java 25+ and Hytale installed before proceeding.
pause

SET /P DESTINATION=Server Path: 

set GAMEFOLDER=%APPDATA%\Hytale\install\release\package\game\latest
set ASSETSZIP=%GAMEFOLDER%\Assets.zip

if not exist "%GAMEFOLDER%" (
    echo Error: Please download Hytale. - store.hytale.com
    pause
    exit /b 1
) else (
    echo Copying Server Folder...
    xcopy "%GAMEFOLDER%\Server\*" "%DESTINATION%\" /E /I /Y
    echo Done!
    echo Making Run File...
    (
        echo @echo off
        echo Rem Don't Mess With unless file names are different (They Shouldn't be^)
        echo java -jar HytaleServer.jar --assets Assets.zip
    ) > "%DESTINATION%\run.bat"
    echo Done!
    echo Copying Asset Files...
    echo This will take a few minutes... Please wait, and don't close this window.
    copy "!ASSETSZIP!" "!DESTINATION!"
    if !ERRORLEVEL! EQU 0 (
        echo Done!
        start "" "%DESTINATION%\run.bat"
    ) else (
        echo Error: Assets Failed to Copy! Please try again.
    )
    pause
)
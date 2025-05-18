@echo off
setlocal enabledelayedexpansion
:: Скрипт для сжатия папки с драйверами (7-Zip -> WinRAR -> PowerShell)

:: Генерация имени папки и архива
set "DRdir=%~dp0windows_driver_%DATE:/=-%"
set "ZIPfile=%DRdir%.zip"

:: Проверка существования исходной папки
if not exist "%DRdir%\*" (
    exit /b 1
)

:: Если архив имеется то завершить работу
if exist "%ZIPfile%" (
    exit /b 1
)

:: Поиск 7-Zip в стандартных расположениях
set "sevenzip="
if exist "%ProgramFiles%\7-Zip\7z.exe" set "sevenzip=%ProgramFiles%\7-Zip\7z.exe"
if exist "%ProgramFiles(x86)%\7-Zip\7z.exe" set "sevenzip=%ProgramFiles(x86)%\7-Zip\7z.exe"

:: Поиск WinRAR в стандартных расположениях
set "winrar="
if exist "%ProgramFiles%\WinRAR\WinRAR.exe" set "winrar=%ProgramFiles%\WinRAR\WinRAR.exe"
if exist "%ProgramFiles(x86)%\WinRAR\WinRAR.exe" set "winrar=%ProgramFiles(x86)%\WinRAR\WinRAR.exe"

:: Выбор архиватора по приоритету
if defined sevenzip (
    "%sevenzip%" a -tzip "%ZIPfile%" "%DRdir%"
) else if defined winrar (
     "%winrar%" a -afzip -ibck -y "%ZIPfile%" "%DRdir%"
) else (
    powershell -nologo -noprofile -command "Compress-Archive -Path \"%DRdir%\" -DestinationPath \"%ZIPfile%\" -Force"
)

endlocal
TIMEOUT /T 5 /NOBREAK
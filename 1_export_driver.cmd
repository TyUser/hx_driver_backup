@echo off
setlocal enabledelayedexpansion
:: Скрипт для экспорта драйверов системы и подготовки установочного файла драйверов
:: Запуск с правами администратора

:: Проверка прав администратора
net session >nul 2>&1
if %errorlevel% neq 0 (
    exit /b 1
)

:: Генерация имени папки с датой (формат: windows_driver_дд-мм-гггг)
set "DRdir=%~dp0windows_driver_%DATE:/=-%"

:: Если директория существует то завершаем работу
if exist "%DRdir%" (
    exit /b 1
)

:: Создание папки
mkdir "%DRdir%"

:: Экспорт драйверов из текущей системы
dism /online /export-driver /destination:"%DRdir%"

:: Копирование скрипта установки
if exist "%~dp0install_drivers" (
    copy "%~dp0install_drivers" "%DRdir%\install_drivers.cmd" >nul
)

endlocal
TIMEOUT /T 5 /NOBREAK
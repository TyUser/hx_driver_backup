# hx driver backup

* 1_export_driver.cmd - создать резервную копию драйверов (Windows 10,11). Запуск от имени администратора. Будет создана
  папка windows_driver_текущая_дата с драйверами. Внутри будет лежать установщик драйверов install_drivers.cmd
* 2_compress_driver.cmd - скрипт для сжатия папки с драйверами. Использует архиваторы 7-Zip -> WinRAR -> PowerShell

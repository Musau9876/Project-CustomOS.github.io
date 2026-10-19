@echo off
title UEFI Bootloader Automated Build Pipeline
echo ===================================================
echo       CustomOS Automated Compilation System
echo ===================================================
echo.

set "SOURCE_DIR=%~dp0files"
set "OUTPUT_DIR=%~dp0UefiDisk\EFI\BOOT"
set "BINARY_NAME=bootx64.efi"

cd /d "%SOURCE_DIR%"

echo [^] Compiling and linking unified CustomOS binary...
gcc -shared -nostdlib -mno-red-zone -fno-builtin -Wl,-e,efi_main -Wl,--subsystem,10 -mabi=ms -D__X86_64__ -o "%BINARY_NAME%" bootloader.c kernel.c
if %ERRORLEVEL% NEQ 0 goto :FAIL

if not exist "%OUTPUT_DIR%" mkdir "%OUTPUT_DIR%"

echo [^] Deploying system executable to UefiDisk storage mapping...
copy /Y "%BINARY_NAME%" "%OUTPUT_DIR%\%BINARY_NAME%" >nul
del "%BINARY_NAME%" >nul

echo.
echo ===================================================
echo  SUCCESS: System fully compiled and deployed!
echo ===================================================
pause
exit /b 0

:FAIL
echo.
echo [X] Error occurred in building!
pause
exit /b 1
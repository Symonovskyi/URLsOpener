@echo off
setlocal EnableDelayedExpansion

:: =====================================================
:: Batch Script to Open URLs from a File
:: -----------------------------------------------------
:: This script reads URLs from a text file (URLs.txt),
:: validates them, and opens each in the default browser.
:: 
:: Features:
:: - Ensures each URL has a valid protocol (http/https).
:: - Automatically adds "https://" if missing.
:: - Handles empty lines gracefully.
:: - Provides detailed error messages for debugging.
:: 
:: Usage:
:: - Place URLs (one per line) in URLs.txt.
:: - Run this script from the same directory.
:: - Ensure URLs.txt is encoded properly (UTF-8 or ANSI).
:: 
:: Requirements:
:: - Windows OS with a default web browser configured.
:: =====================================================

:: Check if URLs.txt exists
if not exist URLs.txt (
    echo [ERROR] URLs.txt not found. Please create the file and add URLs.
    exit /b 1
)

:: Process each line in URLs.txt
for /f "usebackq delims=" %%i in ("URLs.txt") do (
    set "url=%%i"

    :: Skip empty lines to avoid unnecessary errors
    if "!url!"=="" (
        echo [WARNING] Empty line detected. Skipping...
    ) else (
        :: Extract first 7 and 8 characters to check protocol
        set "first7=!url:~0,7!"
        set "first8=!url:~0,8!"

        :: Check if URL starts with "http://"
        if /i "!first7!"=="http://" (
            echo [INFO] Opening: !url!
            start "" "!url!" || echo [ERROR] Failed to open: !url!
        ) else (
            :: Check if URL starts with "https://"
            if /i "!first8!"=="https://" (
                echo [INFO] Opening: !url!
                start "" "!url!" || echo [ERROR] Failed to open: !url!
            ) else (
                :: If protocol is missing, add "https://"
                set "url=https://!url!"
                echo [INFO] No protocol detected. Adding "https://". Opening: !url!
                start "" "!url!" || echo [ERROR] Failed to open: !url!
            )
        )
    )
)

endlocal

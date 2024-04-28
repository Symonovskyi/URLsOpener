@echo off
:: Batch Script to Open URLs from a File
:: --------------------------------------
:: This script reads URLs from a text file 'urls.txt'
:: and opens each URL in the default web browser.
:: Ensure each URL is on a separate line in the file.

:: Open each URL from the file in the web browser
for /f "delims=" %%i in (URLs.txt) do (start "" %%i)
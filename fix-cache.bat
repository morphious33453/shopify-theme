@echo off
REM Fix Nuxt cache issues - Clear and rebuild (Windows)

echo Fixing Nuxt cache...
echo.

echo 1. Removing cache directories...
if exist .nuxt rmdir /s /q .nuxt
if exist node_modules\.cache rmdir /s /q node_modules\.cache
if exist dist rmdir /s /q dist

echo 2. Cache cleared!
echo.
echo Done! Now restart your dev server:
echo    yarn dev
echo.

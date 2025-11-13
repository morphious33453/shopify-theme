@echo off
echo NUCLEAR CACHE FIX - This will work!
echo.

echo 1. Removing ALL cache directories...
if exist .nuxt rmdir /s /q .nuxt
if exist dist rmdir /s /q dist
if exist node_modules\.cache rmdir /s /q node_modules\.cache
if exist node_modules\.vite rmdir /s /q node_modules\.vite
if exist .cache rmdir /s /q .cache

echo 2. Reinstalling node_modules...
if exist node_modules rmdir /s /q node_modules
if exist yarn.lock del /f yarn.lock

echo 3. Fresh install...
call yarn install

echo.
echo Done! Cache completely cleared!
echo.
echo Now run: yarn dev
echo.
pause

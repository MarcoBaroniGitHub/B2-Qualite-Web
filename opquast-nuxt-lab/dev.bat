@echo off
cd /d "%~dp0"
rmdir /s /q .nuxt 2>nul
node node_modules/nuxt/bin/nuxt.mjs dev
pause

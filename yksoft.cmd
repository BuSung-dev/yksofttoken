@echo off
wsl.exe --cd "%~dp0" -- ./yksoft %*
exit /b %errorlevel%

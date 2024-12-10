@echo off

set "dest=%~1"
if "%dest:~-1%"=="\" (set "dest=%dest:~0,-1%")

if not exist "%dest%" (
  echo File Not Found: %dest%
  goto end
)

echo Change ACL: %dest%
if exist "%dest%\" (
  set "diropt1=/r /d y"
  set "diropt2=/t"
  set "diropt3=/T"
  echo Target Is Directory: YES
)

takeown /f "%dest%" /a %diropt1% >nul
icacls "%dest%" /setowner "Everyone" %diropt3% /C /q
echo y| cacls  "%dest%" /p everyone:r %diropt2% /c

:end
exit /b 0



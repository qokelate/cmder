@ECHO OFF

pushd "%~dp0"
set "GOROOT=%CD%"
set "PATH=%GOROOT%\bin;%PATH%"
popd

start cmd.exe /d /k

exit /b 0

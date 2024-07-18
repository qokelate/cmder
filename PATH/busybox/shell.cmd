@echo off

pushd "%~dp0"
set "bbox_root=%CD%"
set "PATH=%CD%\..\curl.http3;%PATH%"
popd

"%bbox_root%\busybox64.exe" sh -l


exit

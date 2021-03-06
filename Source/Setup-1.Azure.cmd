@echo off
setlocal
CD /d "%~dp0"

::Test If script has Admin Priviledges/is elevated
REG QUERY "HKU\S-1-5-19"
IF %ERRORLEVEL% NEQ 0 (
    ECHO Please run this script as an administrator
    pause
    EXIT /B 1
)
cls

IF EXIST %WINDIR%\SysWow64 (
set powerShellDir=%WINDIR%\SysWow64\windowspowershell\v1.0
) ELSE (
set powerShellDir=%WINDIR%\system32\windowspowershell\v1.0
)

call %powerShellDir%\powershell.exe -Command Set-ExecutionPolicy unrestricted

cls

REM call %powerShellDir%\powershell.exe -Command "&'.\Setup\tasks\show-consent-message.ps1' -SetupAzure "; exit $LASTEXITCODE

IF %ERRORLEVEL% == 1 GOTO exit

cls

%powerShellDir%\powershell.exe -NonInteractive -command ".\Setup\copyvhds.ps1" ".\Config.Azure.xml" 

:exit

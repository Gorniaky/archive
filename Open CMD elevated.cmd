@echo off
CD /D "%~dp0"
>nul 2>nul reg query HKU\S-1-5-19 && goto gotAdmin || goto UACPrompt
:UACPrompt
(echo Set UAC = CreateObject^("Shell.Application"^)
echo UAC.ShellExecute "%~s0", "", "", "runas", 1)>"%temp%\getadmin.vbs"
"%temp%\getadmin.vbs"
if exist "%temp%\getadmin.vbs" (del "%temp%\getadmin.vbs")
exit /B
:gotAdmin
cmd

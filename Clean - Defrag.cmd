@echo off
>nul 2>nul reg query HKU\S-1-5-19 && goto gotAdmin || goto UACPrompt
:UACPrompt
(echo Set UAC = CreateObject^("Shell.Application"^)
echo UAC.ShellExecute "%~s0", "", "", "runas", 1)> "%temp%\getadmin.vbs"
"%temp%\getadmin.vbs"
if exist "%temp%\getadmin.vbs" (del "%temp%\getadmin.vbs")
exit /B
:gotAdmin
echo Start %time% %date%>>CleanDefrag.log
>nul 2>nul (for %%a in ("%temp%"
"%windir%\temp"
"%windir%\SoftwareDistribution\Download"
"%programdata%\temp"
"%systemdrive%\$Recycle.Bin"
"%appdata%\Adobe\Common\Media Cache Files"
"%localappdata%\Packages\Microsoft.DesktopAppInstaller_8wekyb3d8bbwe\TempState\WinGet") do if exist %%a (forfiles /p %%a /c "cmd /c if @isdir==TRUE (rd /s /q @file) else (del /f /s /q @file)"))
echo Clean %time% %date%>>CleanDefrag.log
for %%a in (a b c d e f g h i j k l m n o p q r s t u v w x y z) do if exist %%a: (cls&defrag %%a: /u /v)
echo Finish defrag %time% %date%>>CleanDefrag.log

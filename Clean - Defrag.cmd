@echo off
>nul 2>nul reg query HKU\S-1-5-19
if '%errorlevel%' NEQ '0' (goto UACPrompt) else (goto gotAdmin)
:UACPrompt
echo Set UAC = CreateObject^("Shell.Application"^) > "%temp%\getadmin.vbs"
echo UAC.ShellExecute "%~s0", "", "", "runas", 1 >> "%temp%\getadmin.vbs"
"%temp%\getadmin.vbs"
if exist "%temp%\getadmin.vbs" (del "%temp%\getadmin.vbs")
exit /B
:gotAdmin
echo Start %time% %date%>>CleanDefrag.log
>nul 2>nul (del /f /s /q %temp%\*.*
del /f /s /q %windir%\temp\*.*
del /f /s /q %windir%\SoftwareDistribution\Download\*.*
del /f /s /q %programdata%\temp\*.*
del /f /s /q %systemdrive%\$Recycle.Bin\*.*
del /f /s /q %appdata%\Adobe\Common\"Media Cache Files"\*.*
del /f /s /q %localappdata%\Packages\Microsoft.DesktopAppInstaller_8wekyb3d8bbwe\TempState\WinGet)
echo Clean %time% %date%>>CleanDefrag.log
for %%a in (a b c d e f g h i j k l m n o p q r s t u v w x y z) do if exist %%a: (cls&defrag %%a: /u /v)
echo Finish defrag %time% %date%>>CleanDefrag.log
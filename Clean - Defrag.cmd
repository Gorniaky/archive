@echo off&goto:start

:searchpath
for %%b in ($Recycle.Bin,Windows.old,Windows10Upgrade) do %nul% forfiles /m %%b* /p %1\ /c "cmd /c echo @path>>%temp%\erasepaths.txt"
exit/b

:erasepath
for /f delims^=^" %%c in (%temp%\erasepaths.txt) do call:erase %%c
exit/b

:erase
set noerase=
for %%d in ($Recycle.Bin) do echo "%1"|%nul% findstr /i %%d && set noerase=1
if defined noerase (%nul% del /f /s /q "%1"\*.*) else (%nul% takeown /f "%1" /r /d N
%nul% icacls "%1" /grant *S-1-1-0:F /t /c /q
%nul% rd /s /q "%1"
if exist "%1" (echo Fail to erase "%1") else (echo "%1" erased))
exit/b

:setdrivelist
set drivelist=%drivelist% %1
exit/b

:start
set "nul=>nul 2>nul"
%nul% reg query HKU\S-1-5-19 && goto:gotAdmin||goto:UACPrompt
:UACPrompt
(echo Set UAC = CreateObject^("Shell.Application"^)
echo UAC.ShellExecute "%~s0", "", "", "runas", 1)> "%temp%\getadmin.vbs"
"%temp%\getadmin.vbs"
if exist "%temp%\getadmin.vbs" (del "%temp%\getadmin.vbs")
exit /B
:gotAdmin
echo Start %time% %date%>>"%~dp0\CleanDefrag.log"
for %%a in (A B C D E F G H I J K L M N O P Q R S T U V W X Y Z) do if exist %%a:\ (call:setdrivelist %%a)
if exist "%temp%\erasepaths.txt" (del "%temp%\erasepaths.txt")
for %%a in (%drivelist%) do if exist %%a:\ (call:searchpath %%a:)
if exist "%temp%\erasepaths.txt" call:erasepath

%nul% (for %%a in ("%temp%"
"%windir%\temp"
"%windir%\SoftwareDistribution\Download"
"%programdata%\temp"
"%appdata%\Adobe\Common\Media Cache Files"
"%localappdata%\Packages\Microsoft.DesktopAppInstaller_8wekyb3d8bbwe\TempState\WinGet") do if exist %%a (forfiles /p %%a /c "cmd /c if @isdir==TRUE (rd /s /q @file) else (del /f /s /q @file)"))
echo Clean %time% %date%>>"%~dp0\CleanDefrag.log"

for %%a in (%drivelist%) do if exist %%a:\ (cls&defrag %%a:)
echo Finish defrag %time% %date%>>"%~dp0\CleanDefrag.log"

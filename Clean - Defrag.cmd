@echo off
goto:start

:searchpath
for %%b in ($Recycle.Bin,Windows.old,Windows10Upgrade) do %nul% forfiles /m %%b* /p %drivepath%\ /c "cmd /c echo @path>>%temp%\erasepaths.txt"
exit/b

:erasepath
for /f delims^=^" %%c in (%temp%\erasepaths.txt) do set erasepath=%%c&call:erase
exit/b

:erase
set noerase=
for %%d in ($Recycle.Bin) do echo "%erasepath%"|%nul% findstr /i %%d && set noerase=1
if not defined noerase (%nul% takeown /f "%erasepath%" /r /d N
%nul% icacls "%erasepath%" /grant *S-1-1-0:F /t /c /q
%nul% rd /s /q "%erasepath%"
if exist "%erasepath%" (echo Fail to erase "%erasepath%") else (echo "%erasepath%" erased)
) else (%nul% del /f /s /q "%erasepath%"\*.*)
exit/b

:setdrivelist
set drivelist=%drivelist%%drive% 
exit/b

:start
CD /D "%~dp0"
set "nul=>nul 2>nul"
%nul% reg query HKU\S-1-5-19 && goto gotAdmin || goto UACPrompt
:UACPrompt
(echo Set UAC = CreateObject^("Shell.Application"^)
echo UAC.ShellExecute "%~s0", "", "", "runas", 1)> "%temp%\getadmin.vbs"
"%temp%\getadmin.vbs"
if exist "%temp%\getadmin.vbs" (del "%temp%\getadmin.vbs")
exit /B
:gotAdmin
echo Start %time% %date%>>CleanDefrag.log
for %%a in (A B C D E F G H I J K L M N O P Q R S T U V W X Y Z) do if exist %%a:\ (set drive=%%a&call:setdrivelist)
if exist "%temp%\erasepaths.txt" (del "%temp%\erasepaths.txt")
for %%a in (%drivelist%) do if exist %%a:\ (set drivepath=%%a:&call:searchpath)
if exist "%temp%\erasepaths.txt" call:erasepath

%nul% (for %%a in ("%temp%"
"%windir%\temp"
"%windir%\SoftwareDistribution\Download"
"%programdata%\temp"
"%appdata%\Adobe\Common\Media Cache Files"
"%localappdata%\Packages\Microsoft.DesktopAppInstaller_8wekyb3d8bbwe\TempState\WinGet") do if exist %%a (forfiles /p %%a /c "cmd /c if @isdir==TRUE (rd /s /q @file) else (del /f /s /q @file)"))
echo Clean %time% %date%>>CleanDefrag.log

for %%a in (%drivelist%) do if exist %%a:\ (cls&defrag %%a:)
echo Finish defrag %time% %date%>>CleanDefrag.log

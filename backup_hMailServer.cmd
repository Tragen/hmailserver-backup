::Change Working Directory to the script path.
::On Vista, the path is system32 when you start the script as an administrator
cd /D "%~dp0"

setlocal

set CURRENT_DATE=%DATE%
set PRETTY_DATE=%CURRENT_DATE:~-4%-%CURRENT_DATE:~3,2%-%CURRENT_DATE:~0,2%
::Pretty date format yyyy-mm-dd. Works for date format dd.mm.yyyy

set TMPVBSWD=%TEMP%\_TMP$.VBS
echo SetLocale("en-us") >%TMPVBSWD%
echo WScript.Echo WeekDay( Date, vbMonday ) >>%TMPVBSWD%
for /F %%? in ('CSCRIPT //NOLOGO %TMPVBSWD%') do set WEEKDAY=%%?
del %TMPVBSWD%
echo SetLocale("en-us") >%TMPVBSWD%
echo WScript.Echo WeekDayName( WeekDay( Date, vbMonday ), False, vbMonday ) >>%TMPVBSWD%
for /F %%? in ('CSCRIPT //NOLOGO %TMPVBSWD%') do set WEEKDAYNAME=%%?
del %TMPVBSWD%

set LOGFILE="c:\Backup\hmailserver_backup-%PRETTY_DATE%.log"
::Only needed with integrated MSSQL / MYSQL Database
@echo Stopping hMailServer>%LOGFILE%
net stop hMailServer>>%LOGFILE%

diskshadow -s diskshadow.script>>%LOGFILE%

::In case something goes wrong in the script
@echo Starting hMailServer>>%LOGFILE%
net start hMailServer>>%LOGFILE%

endlocal

:::pause

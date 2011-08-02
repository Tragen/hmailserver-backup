::@echo off

@echo Starting hMailServer
@net start hMailServer

set ZIP=%~dp07za_9.20.exe
set ZIPPWD=mysecretpwd

set SOURCES="b:\Program Files (x86)\hMailServer"
::set SOURCES=%SOURCES% "b:\Program Files\Microsoft SQL Server\MSSQL10_50.MyInstance\Databases\hMailServer.mdf"
::set SOURCES=%SOURCES% "b:\Program Files\Microsoft SQL Server\MSSQL10_50.MyInstance\Databases\hMailServer.ldf"

set DESTINATION="c:\Backup\hmailserver-%PRETTY_DATE%-%WEEKDAYNAME%.7z"
set DESTINATIONFULL="c:\Backup\hmailserver-fullbackup.7z"
set DESTINATIONINC="c:\Backup\hmailserver-%PRETTY_DATE%-%WEEKDAYNAME%-inc.7z"

if %WEEKDAY% NEQ 1 goto INCREMENTAL
:FULLBACKUP
"%ZIP%" a -r -mx1 -ms=off -mmt=on -p%ZIPPWD% -xr!*\Logs\* %DESTINATION% %SOURCES%
del %DESTINATIONFULL%
copy %DESTINATION% %DESTINATIONFULL%
goto NEXT

:INCREMENTAL
"%ZIP%" u %DESTINATIONFULL% -r -mx1 -ms=off -mmt=on -p%ZIPPWD% -xr!*\Logs\* -u- -up0q3r2x2y2z0w2!%DESTINATIONINC% %SOURCES%
goto NEXT

:NEXT
::echo do whatever you need here

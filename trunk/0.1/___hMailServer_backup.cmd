@echo Starting hMailServer
net start hMailServer

set CURRENT_DATE=%DATE%
set PRETTY_DATE=%CURRENT_DATE:~-4%-%CURRENT_DATE:~3,2%-%CURRENT_DATE:~0,2%
set zip=%~dp07za_9.20.exe
set SOURCES="b:\Program Files (x86)\hMailServer"
::set SOURCES=%SOURCES% "www\*"

c:
cd \
"%zip%" a -r -mx1 -ms=off -mmt=on -xr!*\Logs\* "c:\Backup\hmailserver-%PRETTY_DATE%.7z" %SOURCES%

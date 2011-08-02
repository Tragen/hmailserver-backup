::Change Working Directory to the script path.
::On Vista, the path is system32 when you start the script as an administrator
cd /D "%~dp0"

::Only needed with integrated MSSQL / MYSQL Database
@echo Stopping hMailServer
net stop hMailServer

diskshadow -s diskshadow.script

::In case something goes wrong in the script
@echo Starting hMailServer
net start hMailServer

pause

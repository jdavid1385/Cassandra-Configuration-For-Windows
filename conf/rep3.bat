rem @echo off
setLocal EnableDelayedExpansion
set DSCINSTALLDIR=%1

rem comes with quotes; remove them
set DSCINSTALLDIR=%DSCINSTALLDIR:"=%

cd "%DSCINSTALLDIR%apache-cassandra\conf"

if exist newfile.txt del newfile.txt

rem replace back slash with forward slash. cassandra needs it
set temp=%DSCINSTALLDIR%
set temp=%temp:\=/%
set temp=%temp: =\ %
set temp=%temp:(=\(%
set temp=%temp:)=\)%

for /f "tokens=* delims=]" %%a in (log4j-server.properties) do (
set str=%%a
set str=!str:/var/log/cassandra/system.log="%temp%logs/cassandra.log"!
for %%I In (^") do set str=!str:%%I=!
echo !str! >> newfile.txt
)

move newfile.txt log4j-server.properties
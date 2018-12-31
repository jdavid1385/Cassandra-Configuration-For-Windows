@echo off
setLocal EnableDelayedExpansion
set DSCINSTALLDIR=%1

REM comes with quotes; remove them
set DSCINSTALLDIR=%DSCINSTALLDIR:"=%

cd "%DSCINSTALLDIR%apache-cassandra\conf"

REM replace back slash with forward slash. cassandra needs it
set temp=%DSCINSTALLDIR%
set temp=%temp:\=/%

if exist newfile.txt del newfile.txt

for /f "tokens=* delims=]" %%a in (cassandra.yaml) do (
set str=%%a
set str=!str:/var/lib/cassandra/data="%temp%data/data"!
set str=!str:/var/lib/cassandra/commitlog="%temp%data/commitlog"!
set str=!str:/var/lib/cassandra/saved_caches="%temp%data/saved_caches"!
set str=!str:/var/lib/cassandra/hints="%temp%data/hints"!
echo !str! >> newfile.txt
)

move newfile.txt cassandra.yaml

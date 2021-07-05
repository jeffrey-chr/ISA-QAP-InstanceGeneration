@echo off

REM Ensure that current directory is the location of this batch file.
set mypath=%~dp0
for /f %%i in ('cd') do set curdir=%%i
cd %mypath%

REM Set up linkdir.txt
set argC=0
for %%x in (%*) do Set /A argC+=1

if %argC%==0 (
    if exist ..\Utilities\qap_readFile.m (
        cd ..\Utilities\
        for /f %%i in ('cd') do set loc=%%i
        cd %mypath%
    ) else (
        set /P loc="Enter location of utilities folder containing qap_readFile.m, etc: " 
    )
) else (
    set loc=%1
)

REM Write the location of utilities in the first line of linkdir.txt
echo Setting utilities folder location as %loc%
echo %loc% > .\linkdir.txt

REM Create any required folders
if not exist .\Generators\StuFer\output (
    echo Creating output directory .\Generators\StuFer\output
    mkdir .\Generators\StuFer\output
)

if not exist .\Generators\DruganComposite\output (
    echo Creating output directory .\Generators\DruganComposite\output
    mkdir .\Generators\DruganComposite\output
)

cd %curdir%
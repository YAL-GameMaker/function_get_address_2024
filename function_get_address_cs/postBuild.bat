@echo off
set dllPath=%~1
set solutionDir=%~2
set projectDir=%~3
set arch=%~4
set config=%~5

echo Running post-build for %config%

set extName=function_get_address_cs
set dllName=function_get_address_cs
set gmlDir23=%solutionDir%function_get_address_23
set ext23=%gmlDir23%\extensions\%extName%
set dllRel=%dllName%.dll
set csRel=%dllName%.cs
set csPath=%ext23%\%csRel%
set gmlPath=%ext23%\*.gml
set docName=%extName%.html
set docPath=%solutionDir%export\%docName%

where /q gmxgen
if %ERRORLEVEL% EQU 0 (
	
	echo Combining the source files...
	type "%projectDir%*.cs" >"%csPath%" 2>nul
	
	echo Running GmxGen...
	
	gmxgen "%ext23%\%extName%.yy" ^
	--copy "%dllPath%" "%dllRel%:%arch%"

) else (

	echo Copying DLLs...
	if "%arch%" EQU "x64" (
		copy /Y "%dllPath%" "%ext23%\%dllName%_x64.dll"
	) else (
		copy /Y "%dllPath%" "%ext23%\%dllRel%"
	)

	echo postBuild.bat: Warning N/A: Could not find GmxGen - extensions will not be updated automatically. See https://github.com/YAL-GameMaker-Tools/GmxGen for setup.
)
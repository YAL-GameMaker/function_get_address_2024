@echo off
set dllPath=%~1
set solutionDir=%~2
set projectDir=%~3
set arch=%~4
set config=%~5

echo Running pre-build for %config%

where /q GmlCppExtFuncs
if %ERRORLEVEL% EQU 0 (
	echo Running GmlCppExtFuncs...
	GmlCppExtFuncs ^
	--prefix function_get_address^
	--cpp "%projectDir%autogen.cpp"^
	--gml "%solutionDir%function_get_address_23/extensions/function_get_address/autogen.gml"^
	%projectDir%function_get_address.cpp
)
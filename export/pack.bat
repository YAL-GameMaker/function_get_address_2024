@echo off

if not exist "function_get_address-for-GMS2.3+\extensions" mkdir "function_get_address-for-GMS2.3+\extensions"
if not exist "function_get_address-for-GMS2.3+\datafiles" mkdir "function_get_address-for-GMS2.3+\datafiles"
cmd /C copyre ..\function_get_address_23\extensions\function_get_address function_get_address-for-GMS2.3+\extensions\function_get_address
cmd /C copyre ..\function_get_address_23\datafiles\function_get_address.html function_get_address-for-GMS2.3+\datafiles\function_get_address.html
cd function_get_address-for-GMS2.3+
cmd /C 7z a function_get_address-for-GMS2.3+.zip *
move /Y function_get_address-for-GMS2.3+.zip ../function_get_address-for-GMS2.3+.yymps
cd ..

pause
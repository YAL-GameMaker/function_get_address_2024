@echo off
set /p ver="Version?: "
echo Uploading %ver%...
set user=yellowafterlife
set ext=gamemaker-function-get-address
cmd /C itchio-butler push function_get_address-for-GMS2.3+.yymps %user%/%ext%:gms2.3 --userversion=%ver%

pause
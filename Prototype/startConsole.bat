@ECHO OFF
echo.##############################################
echo.##                                          ##
echo.##        SoftWware Build Environment       ##
echo.##                                          ##
echo.##############################################
echo.
echo.

CALL C:\Windoes\system32\cmd.exe /k make all PLATFORM=S32R4xx TARGET=a53 OSENV=linux COMPILER=gcc
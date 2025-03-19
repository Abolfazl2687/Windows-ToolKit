
@echo off
title ToolKit
color 0a
mode con: cols=80 lines=20
set __compat_layer=runasinvoker

:menu
cls
echo.
echo ==========================
echo          ToolKit
echo ==========================
echo 1. Windows Activator
echo 2. Run File with UAC Bypass
echo 3. Run CMD with UAC Bypass
echo 4. Show Wifi PassWords (Save To Wifi.txt)
echo 5. Restart To Bios/UEFI (5 Sec Timer)
echo 6. Open StartUp Folders
echo 7. Change Registered Owner
echo 8. Clean TEMP and RecycleBin
echo 9. Set Shecan ON (DNS)
echo 10. Set Shecan OFF (DNS)
echo 11. Generate QRCode (From Text)
echo 0. Exit
echo ==========================
echo.
set /p "choice= Select an option : "

if "%choice%"=="1" (
    echo.
    powershell -Command "irm https://get.activated.win | iex"
    echo.
    goto menu

) else if "%choice%"=="2" (
    set /p "FilePath= Enter The Files Path Or Drag File Here : "

) else if "%choice%"=="3" (
    start msconfig.exe
    echo msgbox "In <System Configuration> (Opened) Window, go to the <Tools> tab and select <Command Prompt>, then click the <Launch> button." > %tmp%\tmp.vbs
    cscript /nologo %tmp%\tmp.vbs
    del %tmp%\tmp.vbs
    echo.
    goto menu

) else if "%choice%"=="4" (
    echo.
    netsh wlan export profile key=clear > nul && findstr /c:"<keyMaterial>" *.xml > WiFi.txt && powershell -Command "(gc WiFi.txt) -replace '<keyMaterial>', '' -replace '</keyMaterial>', '' -replace 'Wi-Fi-', '' -replace '.xml:', ':' | Out-File -encoding ASCII WiFi.txt" && del /f /s /q *.xml > nul && start WiFi.txt
    echo.
    goto menu

) else if "%choice%"=="5" (
    echo.
    powershell -Command "Start-Process cmd -ArgumentList '/c shutdown /r /fw /f /t 5' -Verb RunAs"
    echo.
    goto menu

) else if "%choice%"=="6" (
    echo.
    start "" "%userprofile%\AppData\Roaming\Microsoft\Windows\Start Menu\Programs\Startup"
    start "" "C:\ProgramData\Microsoft\Windows\Start Menu\Programs\Startup"
    echo.
    goto menu

) else if "%choice%"=="7" (
    set /p "NewOwner=Enter new registered owner name: "

) else if "%choice%"=="8" (
    echo.
    del /f /q %temp%\*.* && rd /s /q %systemdrive%\$Recycle.Bin
    echo.
    goto menu

) else if "%choice%"=="9" (
    echo.
    powershell -Command "Start-Process cmd -ArgumentList '/c netsh interface ip set dns "Wi-Fi" static 178.22.122.100 && netsh interface ip add dns "Wi-Fi" 185.51.200.2 index=2' -Verb RunAs"
    echo Shecan Is On
    echo.
    pause
    goto menu

) else if "%choice%"=="10" (
    echo.
    powershell -Command "Start-Process cmd -ArgumentList '/c netsh interface ip set dns "Wi-Fi" dhcp' -Verb RunAs"
    echo Shecan Is Off
    echo.
    pause
    goto menu

) else if "%choice%"=="11" (
    set /p "Text=Enter text or URL to generate QR Code: "

) else if "%choice%"=="0" (
    exit

) else (
    echo Invalid option. Please try again.
    echo.
    goto menu
)

if "%FilePath%"=="" (
    echo.
) else (
    echo path : "%FilePath%"
    start "" %FilePath%
)

if "%Text%"=="" (
    echo.
) else (
    start https://api.qrserver.com/v1/create-qr-code/?data=%Text%
)

if "%NewOwner%"=="" (
    echo.
) else (
    powershell -Command "Start-Process cmd -ArgumentList '/c reg add \"HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows NT\CurrentVersion\" /v RegisteredOwner /t REG_SZ /d \"%NewOwner%\" /f' -Verb RunAs"
)

goto menu

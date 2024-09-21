:: Made by Alex Ibrahim Ojea - 2024
@echo off
echo Starting process...
:: Enable delayed expansion to allow variable changes within loops
setlocal enabledelayedexpansion

:: Define the local directory from where files will be uploaded
set "origin_path=C:\YOUR_PATH\"
:: Define the FTP server, username, and password
set "ftp_server=YOUR_FTP_SERVER"
set "ftp_user=YOUR_FTP_USER"
set "ftp_pass=YOUR_FTP_PASSWORD"
:: Define the destination directory path on the FTP server
set "ftp_endPath=/END_PATH_TO_LEAVE_FILES/A_FOLDER_FOR_EXAMPLE/"

:: Get the current date and time in UTC (YearMonthDay_HourMinuteSecond)
for /f "skip=1 tokens=1" %%a in ('wmic os get localdatetime') do (
    set "datetime=%%a"
    goto :continue
)

:continue
:: Extract the date and time components (first 14 characters)
set "YYYY=%datetime:~0,4%"
set "MM=%datetime:~4,2%"
set "DD=%datetime:~6,2%"
set "HH=%datetime:~8,2%"
set "Min=%datetime:~10,2%"
set "Sec=%datetime:~12,2%"

:: Formatted commands and result log file with date and time
set "ftpCmdFile=ftp_cmd_%YYYY%%MM%%DD%_%HH%%Min%%Sec%.dat"
set "ftpLogFile=ftp_result_%YYYY%%MM%%DD%_%HH%%Min%%Sec%.log"

:: Try to delete CMD and log file if they already exist (shouldn't be the case but just to be safe)
del %ftpCmdFile%
del %ftpLogFile%

:: Start writing all FTP commands to a file
echo Starting to write all FTP commands to %ftpCmdFile%
:: Command to open the FTP connection
echo open %ftp_server%>> %ftpCmdFile%
:: Send user credentials
echo user %ftp_user% !ftp_pass!>> %ftpCmdFile%
:: Set FTP to binary mode for file transfer
echo binary>> %ftpCmdFile%
:: Create the destination folder on the FTP server if it doesn't exist
echo mkdir "%ftp_endPath%">> %ftpCmdFile%
:: Change to the specified folder on the FTP server
echo cd "%ftp_endPath%">> %ftpCmdFile%

:: Set the current folder being worked on to the end path
set "currentFolder=%ftp_endPath%"

:: Loop through all files in the origin directory recursively
for /R "%origin_path%" %%f in (*) do (
    :: Store the full path of the file
    set "fullPathToFile=%%~dpf"
    :: Remove the origin path portion from the full path of the file
    set "fullPathToFileWithoutOrigin=!fullPathToFile:%origin_path%=!"
    :: If there is any remaining path after origin path removal
    if not "!fullPathToFileWithoutOrigin!"=="" (
        :: Convert backslashes to forward slashes for FTP paths and store in `remoteFolder`
        set "remoteFolder=!fullPathToFileWithoutOrigin:\=/!"
    ) else (
        :: If no remaining path, use the original path as the remote folder
        set "remoteFolder=!origin_path!"
    )
    
    :: If the current folder is not already the remote folder, create it and change to it
	if not "!currentFolder!" == "%ftp_endPath%!remoteFolder!" (
		echo mkdir "%ftp_endPath%!remoteFolder!">> %ftpCmdFile%
		echo cd "%ftp_endPath%!remoteFolder!">> %ftpCmdFile%
		:: Update currentFolder to the new remote folder
		set "currentFolder=%ftp_endPath%!remoteFolder!"
	)
    
    :: Write to the FTP command file to upload the file
    echo put "%%f">> %ftpCmdFile%
)
:: End the FTP session by writing the 'bye' command to the FTP commands file
echo bye>> %ftpCmdFile%

:: Inform the user that the FTP commands file is finished
echo FTP commands file finished

:: Execute the FTP commands using the generated ftp commands file and log the results
echo Execute FTP commands
ftp -n -s:%ftpCmdFile% > %ftpLogFile% 2>&1

:: End the `setlocal` context, cleaning up any temporary variables
endlocal
echo Process finished
:: Pause the console so the user can see the final message
pause

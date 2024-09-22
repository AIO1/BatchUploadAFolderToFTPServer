# Batch file to upload a folder (including subdirectories) to a FTP server
A solution that contains a batch file that when properly setup, it will upload all files from where it is being executed to an FTP server.

## Table of Contents
- [Introduction](#introduction)
- [1 Setup](#1-setup)
- [2 Execute and results](#2-execute-and-results)


## Introduction
Hello! My name is Alex Ibrahim Ojea.

This project started because a collegue wanted a batch that when executed, it would upload all files to a given end path in an FTP server. The script also had to transfer any files located inside of the subfolders from the main path. It also had to keep the generated FTP commands and log file for auditing purposes.

Becasue this script is actually quite useful and can be easily reusable, I've decided to upload it and make it available for everyone :)

Please note that this solution only works under FTP protocol and not with sFTP. If you want to use sFTP, Windows doesn't include a sFTP client as of today, so you will have to download and install a client that allows for sFTP and modifiy the script. A good client to achieve this is [WinSCP](https://winscp.net/).


## 1 Setup
Before executing the script, you need to adjust some variables to your needs. Open the [BatchUploadAFolderToFTPServer.bat](BatchUploadAFolderToFTPServer.bat) file with a text editor (I normally use Notepad++). Once the file is opened, you will have to modify the variables shown in this image to your needs:

![image](https://github.com/user-attachments/assets/4f0598a9-8e63-4243-a8b5-1ab105c8f112)

- **origin_path:** The root path of all the contents that needs to be copied to your FTP server.
- **ftp_server:** Your FTP server (normally an IP or DNS name).
- **ftp_user:** The user that will be used to login to the FTP server.
- **ftp_pass:** The password that will be used to authenticate with the provided user. Please note that if your password has special characters, you should put before them '^' so that they print out OK to the FTP commands.
- **ftp_endPath:** The base path in the FTP server that all files from the **origin_path** will be uploaded to.

## 2 Execute and results
After you have completed the setup, you will now be able to execute the script and it should work as expected.

Please note that it might be possible that you need elevated priviliges in your machine for the script to be executed.

During execution a "CMD" window should appear and you must wait until you see the message "Press any key to continue . . .". The final appearence of all the messages shown in the CMD window when the process finishes should look something like this:
```
Starting process...
Could not found [PATH TO FTP CMD FILE]
Could not found [PATH TO FTP LOG FILE]
Starting to write all FTP commands to [PATH TO FTP CMD FILE]
FTP commands file finished
Execute FTP commands
Process finished
Press any key to continue . . .
```


The execution time will vary depending on 3 factors:
- If the FTP server, username or password are wrong, the script will be "stuck" until a timeout is given.
- The amount of files that you are transfering (and their size).
- Your Internet connection speed.

During the exceution process you will see that 2 new files always generate containing in a part of the name the current date in UTC:
- **ftp_cmd_[CURRENT_DATE_IN_UTC].dat:** Contains all commands that will be executed by Windows integrated FTP client. A good way to troubleshoot is verify that the commands here make sense (your password is correct, your paths are ok...).
- **ftp_result_[CURRENT_DATE_IN_UTC].log:** Contains the result printed out by the Windows interated FTP client. If you want to diagnose any issues, this file will show you after a command execution, what was the response from the FTP server.

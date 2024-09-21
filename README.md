# Batch file to upload a folder (including subdirectories) to a FTP server
A solution that contains a batch file that when properly setup, it will upload all files from where it is being executed to an FTP server.

## Table of Contents
- [Introduction](#introduction)
- [1 Setup](#1-setup)
- [2 Execute and results](#2-execute-and-results)
- [3 In depth look at the code](#3-in-depth-look-at-the-code)


## Introduction
Hello! My name is Alex Ibrahim Ojea.

This project started because a collegue wanted a batch that when executed, it would upload all files to a given end path in an FTP server. The script also had to transfer any files located inside of the subfolders from the main path. It also had to keep the generated FTP commands and log file for auditing purposes.

Becasue this script is actually quite useful and can be easily reusable, I've decided to upload it and make it available for everyone :)


## 1 Setup
Before executing the script, you need to adjust some variables to your needs. Open the [BatchUploadAFolderToFTPServer.bat](BatchUploadAFolderToFTPServer.bat) file with a text editor (I normally use Notepad++). Once the file is opened, you will have to modify the variables shown in this image to your needs:

![image](https://github.com/user-attachments/assets/4f0598a9-8e63-4243-a8b5-1ab105c8f112)

- **origin_path:** The root path of all the contents that needs to be copied to your FTP server.
- **ftp_server:** Your FTP server (normally an IP or DNS name).
- **ftp_user:** The user that will be used to login to the FTP server.
- **ftp_pass:** The password that will be used to authenticate with the provided user. Please note that if your password has special characters, you should put before them '^' so that they print out OK to the FTP commands.
- **ftp_endPath:** The base path in the FTP server that all files from the **origin_path** will be uploaded to.

After you have done that, you will now be able to execute the script and it should work as expected. Please note that it might be possible that you need elevated priviliges in your machine for the script to be executed.

## 2 Execute and results

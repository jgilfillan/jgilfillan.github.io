---
layout: post
title: Using PowerShell and DPAPI to securely mask passwords in R scripts
disqus_id: 770a5f60-7040-4a86-a0a8-f342dcfdb852
comments: true
categories:
- blog
- r
- rstudio
- powershell
- dpapi
---

There are many use cases for passing a password into R without explicitly typing the password into the script.  In fact, I can't think of a real world scenario where you **would** want to store a plain text password in a script.

R does not natively provide functionality to solve this problem.  A number of solutions have been proposed, and I have used a number of them over the years, but none of them ever felt quite right.  Below I have detailed my solution which uses the Windows Data Protection API (DPAPI) and PowerShell.  It requires minimal set up and is easy to use.  It does, however, only work on Windows, but if that is your primary development environment I am sure you will like this solution.

## Features
* Windows only
* Uses the Windows Data Protection API and PowerShell
* Passwords are stored in encrypted files that can only be decrypted on the same PC and with the same Windows credentials that encrypted the password.
* Encrypted passwords are passed directly into connection strings at runtime
* Similar (but more secure) functionality to the SAS PWENCODE procedure

## Procedure
1.  Ensure you have [enabled PowerShell execution](http://stackoverflow.com/a/4038991/3827849 "Stack Overflow").
2.  Save the following text into a file called EncryptPassword.ps1:

        # Create directory user profile if it doesn't already exist.
        $passwordDir = "$($env:USERPROFILE)\DPAPI\passwords\$($env:computername)"
        New-Item -ItemType Directory -Force -Path $passwordDir
        
        # Prompt for password to encrypt
        $account = Read-Host "Please enter a label for the text to encrypt.  This will be how you refer to the password in R.  eg. MYDB_MYUSER
        $SecurePassword = Read-Host -AsSecureString  "Enter password" | convertfrom-securestring | out-file "$($passwordDir)\$($account).txt"
        
        # Check output and press any key to exit
        Write-Host "Press any key to continue..."
        $x = $host.UI.RawUI.ReadKey("NoEcho,IncludeKeyDown")
3.  Execute the script above (right click > Run with PowerShell), provide a meaningful name for the password, and type in the password.  You can now verify that the password has been encrypted by checking the file in *%USERPROFILE%/DPAPI/passwords/[PC NAME]/[PASSWORD IDENTIFIER.txt]*
4.  Now run the following code from within R (I have this function saved in an R script that I [source](https://stat.ethz.ch/R-manual/R-devel/library/base/html/source.html) at the start of each script.  The function executes a PowerShell command to decrypt the password and returns the result to R.

        getEncryptedPassword <- function(credential_label, credential_path) {
          # if path not supplied, use %USER_PROFILE%\DPAPI\passwords\computername\credential_label.txt as default
          if (missing(credential_path)) {
            credential_path <- paste(Sys.getenv("USERPROFILE"), '\\DPAPI\\passwords\\', Sys.info()["nodename"], '\\', credential_label, '.txt', sep="")
          }
          # construct command
          command <- paste('powershell -command "$PlainPassword = Get-Content ', credential_path, '; $SecurePassword = ConvertTo-SecureString $PlainPassword; $BSTR = [System.Runtime.InteropServices.Marshal]::SecureStringToBSTR($SecurePassword); $UnsecurePassword = [System.Runtime.InteropServices.Marshal]::PtrToStringAuto($BSTR); echo $UnsecurePassword"', sep='')
          # execute powershell and return command
          return(system(command, intern=TRUE))
        }
5.  Now when you need to supply a password in R, you can run the following command instead of hardcoding / prompting for the password:

        getEncryptedPassword("[PASSWORD IDENTIFIER]")

    For example, instead of running the ROracle command:

        dbConnect(driver, "MYUSER", "MY PASSWORD", dbname="MYDB")

    I can run this instead (the identifier I supplied in Step 3 is "MYUSER_MYDB":

        dbConnect(driver, "MYUSER", getEncryptedPassword("MYUSER_MYDB"), dbname="MYDB")
6.  You can repeat Step 3 for as many passwords as are required, and simply call them with the correct identifier in Step 5.


That's about it.  A somewhat hacky solution, but does the job well and saves me from saving password in scripts or entering the password every time I want to connect.

By the way if you've read through this, like the solution and are feeling generous, please upvote [this](http://stackoverflow.com/a/36218700/3827849) answer on Stack overflow.

What are your thoughts?  Would love to hear whether this has helped or what enhancements you've made to this solution.
        
    
---

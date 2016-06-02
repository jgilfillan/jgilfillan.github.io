---
layout: post
title: How to install ROracle in Windows 7
comments: true
disqus_id: eb0a2795-cee3-4ee7-97b1-8dcf5436acc0
tags:
- blog
- R
- windows7
- roracle
---

1. [Download binary from oracle](http://www.oracle.com/technetwork/database/database-technologies/r/roracle/downloads/index.html)

2. Run the following command in r, substituting the file path:

       setwd('PATH TO DOWNLOAD')   # set to path of download (remember to escape slashes ie:  c:\\users\\etc..)
       install.packages('ROracle_1.2-1.zip', repos = NULL)

3. Then load the library and use the package - you will have to change MYDB to a valid connection from your tnsnames.ora file.

       library('ROracle')
       drv <- dbDriver("Oracle")
       
       # NOTE: never store passwords in a saved script!!
       con <- dbConnect(drv, "USER GOES HERE", "PASSWORD GOES HERE", dbname='XXX')
       
       # test connection:
       dbReadTable(con, 'DUAL')

4.  If all goes to plan, the last command shoud return a dataframe with a single value of 'X'.
    
Now that the basics are working, check out my post on [how to securely pass encrypted passwords to R scripts in Windows](http://www.gilfillan.space/2016/04/21/Using-PowerShell-and-DPAPI-to-securely-mask-passwords-in-R-scripts/).

---
layout: post
title: How to Install the Oracle Instant Client on Ubuntu 16.04
comments: true
disqus_id: eb0a2795-cee3-4ee7-97b1-8dcf5436acc0
tags:
- blog
- sql
- oracle
- ubuntu
- 16.04
---

1. Download the Oracle Instant Client RPMs from the Oracle website.

2. Use the **alien** package to convert and install the RPMs.

        sudo alien -i oracle-instantclient11.2-basic-11.2.0.4.0-1.x86_64.rpm
        sudo alien -i oracle-instantclient11.2-devel-11.2.0.4.0-1.x86_64.rpm
        sudo alien -i oracle-instantclient11.2-sqlplus-11.2.0.4.0-1.x86_64.rpm

3. Create a network/admin folder inside the installation folder and copy your tnsnames.ora and sqlnet.ora to this directory.  My installation folder is `/usr/lib/oracle/11.2/client64` .

4. Set the Oracle environment variables by editing your PATH and adding `ORACLE_HOME`, `OCI_LIB` and `TNS_ADMIN` to your /etc/environment file as follows:

        PATH="/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:/usr/games:/usr/local/games:/usr/lib/oracle/11.2/client64/bin"
        ORACLE_HOME="/usr/lib/oracle/11.2/client64"
        OCI_LIB="/usr/lib/oracle/11.2/client64/lib"
        TNS_ADMIN="/usr/lib/oracle/11.2/client64/network/admin"

    The `LD_LIBRARY_PATH` variable needs special treatment as per [the Ubuntu help page](https://help.ubuntu.com/community/EnvironmentVariables):

        echo "/usr/lib/oracle/11.2/client64/lib" | sudo tee /etc/ld.so.conf.d/oracle.conf
        sudo ldconfig -v

5. Install **libaio1**

        sudo apt-get install libaio1

6. Test client
        sqlplus USER@SERVER

That's it.  In a future post I will detail how to install ROracle in Ubuntu 16.04.

---

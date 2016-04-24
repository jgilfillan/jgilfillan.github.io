---
layout: post
title: How to Install the Oracle Client on Ubuntu 16.04
comments: true
disqus_id: 
tags:
- blog
- sql
- oracle
- ubuntu
- 16.04
---

## Install Instant Client RPMs (https://help.ubuntu.com/community/Oracle%20Instant%20Client)
1. Download the Oracle Instanct Clients RPMS from the Oracle website
2. Use the **alien** package to convert convert and install the RPMs.

```
alien -i oracle-instantclient11.2-basic-11.2.0.4.0-1.x86_64.rpm
alien -i oracle-instantclient11.2-devel-11.2.0.4.0-1.x86_64.rpm
alien -i oracle-instantclient11.2-sqlplus-11.2.0.4.0-1.x86_64.rpm
```
3. Set the Oracle environment variables.


```
export ORACLE_HOME=/usr/lib/oracle/11.2/client64
export LD_LIBRARY_PATH=/usr/lib/oracle/11.2/client64/lib:$LD_LIBRARY_PATH
export PATH=$PATH:$ORACLE_HOME/bin
export OCI_LIB=/usr/lib/oracle/11.2/client64/lib:$OCI_LIB

```




3. TNS_ADMIN
4. Test client



---

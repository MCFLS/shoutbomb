#Sending data to Shoutbomb from Sierra using SQL Workbench/J and WinSCP

Both SQL Workbench /J and WINSCP offer a command line interface which makes it easy to work with both applications to send the file to Shoutbomb using a Windows batch file. I use separate SQL files for holds, renewals and overdues which allows me to send them separately at different times if necessary.

DOWNLOAD APPLICATIONS

Download SQL Workbench /J to your computer: http://www.sql-workbench.net/downloads.html

Download WINSCP FTP client: http://winscp.net/eng/download.php

SET UP PROFILES FOR APPLICATIONS

Set up a connection profile in SQL Workbench /J to connect to your Sierra SQL instance. Make sure a connection can be made to your database. My connection info is attached as separate images under the ISSUES tab (main profile connection and extended properties window).

Set up a connection profile in WINSCP to connect to Shoutbomb

Record both profile names. You will need these to alter the SQL and batch files.

Edit file 'boopsie.sql'

Replace -file parameter with the location you where you want to store the file created. I remove this file prior to creating the new one each time the batch file is run.
Edit file 'boopsie.bat'

Change profile name used by SQL Workbench /J from "-profile=CountyCat" to "-profile=[your SQL Workbench profile name]"

Change profile name used by WINSCP from "open boopsie" to "open [your WINSCP profile name]"

Save both files boopsie.bat and boopsie.sql

Run boopsie.bat to execute the query and send file to Boopsie FTP server

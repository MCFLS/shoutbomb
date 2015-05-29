#Sending data to Shoutbomb from Sierra using SQL Workbench/J and WinSCP

05/29/15: Updated sql scripts to use SQL Workbench /J build 117+

Both SQL Workbench /J and WINSCP offer a command line interface which makes it easy to work with both applications to send the file to Shoutbomb using a Windows batch file. I use separate SQL files for holds, renewals and overdues which allows me to send them separately at different times if necessary.

DOWNLOAD APPLICATIONS

Download SQL Workbench /J to your computer: http://www.sql-workbench.net/downloads.html

Download WINSCP FTP client: http://winscp.net/eng/download.php

SET UP PROFILES FOR APPLICATIONS

Set up a connection profile in SQL Workbench /J to connect to your Sierra SQL instance. Make sure a connection can be made to your database. My connection info is attached as separate images under the ISSUES tab (main profile connection and extended properties window).

Set up a connection profile in WINSCP to connect to Shoutbomb.  Make sure you use the TLS option.

Record both profile names. You will need these to alter the SQL and batch files.

EDIT .SQL FILES [holds.sql, renew.sql, overdue.sql]

For all three queries: replace -file parameter with the location you where you want to store the file created. I move each file to an archive after sending to Shoutbomb in case errors occur and I need to resend.

overdue.sql: Change the numbers used in the WHERE clause to reflect how often you want to send overdue reminders.  We use 1, 14 and 28 days after the due date.

renew.sql: Change the number 3 to indicate how many days in advance of the due date you want to notify patrons of items coming due.  We set this to three to match our courtesy notices.

EDIT FILE RUNSHOUTBOMB.BAT

Change profile name used by SQL Workbench /J from "-profile=CountyCat" to "-profile=[your SQL Workbench profile name]" and change the location of the SQL files to match your location

Change profile name used by WINSCP from "open boopsie" to "open [your WINSCP profile name]"

Alter the last three lines to indicate where you want to save your archived files.

Save all files you've edited.

Run runshoutbomb.bat to execute the query and send file to Shoutbomb FTP server

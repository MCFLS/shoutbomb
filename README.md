#Sending data to Shoutbomb from Sierra using SQL Workbench/J and WinSCP

Both SQL Workbench /J and WINSCP offer a command line interface (CLI) which makes it easy to work with both applications to send the file to Shoutbomb using a Windows batch file. Separate SQL files are used for holds, renewals, and overdues to allow sending them separately at different times if necessary.

REQUIREMENTS:
SQL Workbench /J: http://www.sql-workbench.net/downloads.html
WINSCP FTP client: http://winscp.net/eng/download.php

A. SET UP PROFILES FOR APPLICATIONS
1. Set up a connection profile in SQL Workbench /J to connect to your Sierra SQL instance. Test a successful connection can be made to your database before proceeding.
2. Set up a connection profile in WINSCP to connect to Shoutbomb. Use the TLS option.
3. Record both profile names. You will need to include these in the SQL and batch files.

B. EDIT QUERIES [holds.sql, renew.sql, overdue.sql, patrons.sql]
1. In all SQL queries, replace the `-file` parameter with the location to store the results of the query. This file is then moved to an `Archive` folder (saved for 30 days) after sending to Shoutbomb in case errors occur and the data needs to be resent.
2. overdue.sql: Update the numbers used in the `WHERE` clause to reflect how often overdue reminders should be sent. The existing query uses a range between 1 and 30 days overdue.
3. renew.sql: Update the numbers used in the `WHERE` clause to indicate how many days in advance of the due date patrons should be notified of items coming due. The existing query is set to three to match courtesy notices.
4. patrons.sql: Update the `WHERE` clause to indicate which patrons to be sent to Shoutbomb. The existing query is set to find nonexpired patrons with a text message number (saved in Sierra's var field with code 'p').

C. EDIT BATCH FILES [runshoutbomb.bat, runshoutbombholds.bat, runshoutbombpatrons.bat]
1. Change the profile name used by SQL Workbench /J from "-profile=CountyCat" to "-profile=[your SQL Workbench profile name]" and change the location of the SQL files to match the file locations set in step B1.
2. Change the profile name used by WINSCP from "open boopsie" to "open [your WINSCP profile name]"
3. Alter lines beginning with `MOVE` to indicate where to save archived query results.
4. Run batch files manually or set up a scheduled job to execute the queries and send the results to the Shoutbomb FTP server.

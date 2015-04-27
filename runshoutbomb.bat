REM Run the Sql Workbench/J scripts for holds, renewals and overdues. Scripts also save files.
java -jar C:\SQLWorkbench\sqlworkbench.jar -script='c:/shoutbomb/scripts/holds.sql','c:/shoutbomb/scripts/renew.sql','c:/shoutbomb/scripts/overdue.sql' -profile=CountyCat
REM Run winscp to ftp the files over to Shoutbomb
winscp.com /command "option batch abort" "option confirm off" "open shoutbomb" "put C:\Shoutbomb\Holds\*.* /Holds/" "put C:\Shoutbomb\Renewals\*.* /Renew/" "put C:\Shoutbomb\Overdue\*.* /Overdue/" "exit"
REM move the ftp'd files over to archive folder
CD C:\
MOVE C:\Shoutbomb\Holds\*.* C:\Shoutbomb\Archive\Holds
MOVE C:\Shoutbomb\Renewals\*.* C:\Shoutbomb\Archive\Renewals
MOVE C:\Shoutbomb\Overdue\*.* C:\Shoutbomb\Archive\Overdue

REM Run the Sql Workbench/J scripts for holds, renewals and overdues. Scripts also save files.
java -jar C:\SQLWorkbench\sqlworkbench.jar -script='c:/shoutbomb/scripts/holds.sql','c:/shoutbomb/scripts/renew.sql','c:/shoutbomb/scripts/overdue.sql' -profile=CountyCat -logfile='c:/shoutbomb/logs/shoutbomblog.txt'
REM Run winscp to ftp the files over to Shoutbomb
winscp.com /command "option batch abort" "option confirm off" "open shoutbomb -certificate=*" "put c:\shoutbomb\Holds\*.* /Holds/" "put c:\shoutbomb\Renewals\*.* /Renew/" "put c:\shoutbomb\Overdue\*.* /Overdue/" "exit"
REM move the ftp'd files over to archive folder
CD C:\
MOVE C:\Shoutbomb\Holds\*.* C:\Shoutbomb\Archive\Holds
MOVE C:\Shoutbomb\Renewals\*.* C:\Shoutbomb\Archive\Renewals
MOVE C:\Shoutbomb\Overdue\*.* C:\Shoutbomb\Archive\Overdue
REM Delete archive files older than 30 days
forfiles -p "C:\shoutbomb\Archive\Holds" -s -m *.* /D -30 /C "cmd /c del @path"
forfiles -p "C:\shoutbomb\Archive\Overdue" -s -m *.* /D -30 /C "cmd /c del @path"
forfiles -p "C:\shoutbomb\Archive\Renewals" -s -m *.* /D -30 /C "cmd /c del @path"

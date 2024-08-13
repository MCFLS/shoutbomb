REM Run the sqlworkbench scripts for holds only. Scripts also save files.
java -jar C:\SQLWorkbench\sqlworkbench.jar -script='c:/shoutbomb/scripts/holds.sql' -profile=CountyCat
REM Run winscp to ftp the files over to Shoutbomb
winscp.com /command "option batch abort" "option confirm off" "open shoutbomb -certificate=*" "put C:\Shoutbomb\Holds\*.* /Holds/" "exit"
REM move the ftp'd files over to ftpsent folder
CD C:\
MOVE C:\Shoutbomb\Holds\*.* C:\Shoutbomb\Archive\Holds

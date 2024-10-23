REM Run the sqlworkbench scripts for text patrons. Scripts also save files.
java -jar C:\SQLWorkbench\sqlworkbench.jar -script='c:/shoutbomb/scripts/patrons.sql' -profile=CountyCat
REM Run winscp to ftp the files over to Shoutbomb
winscp.com /command "option batch abort" "option confirm off" "open shoutbomb -certificate=*" "put C:\shoutbomb\Text\*.* /text_patrons/" "exit"
REM move the ftp'd files over to ftpsent folder
CD C:\
MOVE C:\Shoutbomb\Text\*.* C:\Shoutbomb\Archive\Text
REM Delete archive files older than 30 days
forfiles -p "C:\shoutbomb\Archive\Text" -s -m *.* /D -30 /C "cmd /c del @path"

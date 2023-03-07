# Define the path where the folders will be created
$TARGETFOLDERPATH = "C:\Temp\Folders"

# Define the number of folders to create
$NUMBEROFFOLDERSTOCREATE = 5

# Define the number of files to create
$NUMBEROFFILESTOCREATE = 10

# Create the folders
for ($FOLDERINDEX = 1; $FOLDERINDEX -le $NUMBEROFFOLDERSTOCREATE; $FOLDERINDEX++)
{
    $FOLDERNAME = "Folder$FOLDERINDEX"
    $FULLFOLDERPATH = Join-Path -Path $TARGETFOLDERPATH -ChildPath $FOLDERNAME
    New-Item -ItemType Directory -Path $FULLFOLDERPATH #> $null
}

# Create the files and place them in the folders
for ($FILEINDEX = 1; $FILEINDEX -le $NUMBEROFFILESTOCREATE; $FILEINDEX++)
{
    $FILENAME = "File$FILEINDEX.txt"
    $RANDOMFOLDERINDEX = Get-Random -Minimum 1 -Maximum $NUMBEROFFOLDERSTOCREATE
    $RANDOMFOLDERNAME = "Folder$RANDOMFOLDERINDEX"
    $RANDOMFOLDERFULLPATH = Join-Path -Path $TARGETFOLDERPATH -ChildPath $RANDOMFOLDERNAME
    $NEWFILEPATH = Join-Path -Path $RANDOMFOLDERFULLPATH -ChildPath $FILENAME
    New-Item -ItemType File -Path $NEWFILEPATH #> $null
}

# Alert that the script is done
Write-Host "The script has finished creating $NUMBEROFFOLDERSTOCREATE folders and $NUMBEROFFILESTOCREATE files in the target folder located at $TARGETFOLDERPATH."

# Uncomment these lines to remove the display to the console
#
# > $null


# Prompt the user for the number of folders to create
$NUMBER_OF_FOLDERS = Read-Host "Enter the number of folders to create"

Write-Host "Start:  $(Get-Date -Format 'yyyyMMdd-HHmmssfffffff')"

# Prompt the user for the root folder where the folders will be created
# $ROOT_FOLDER = Read-Host "Enter the root folder where the folders will be created"
$ROOT_FOLDER = "C:\Temp"

# Loop through the specified number of folders to create
for ($i = 1; $i -le $NUMBER_OF_FOLDERS; $i++)
{
    # Generate a unique GUID for the folder name
    # $FOLDER_NAME = "Folder_$(Get-Date -Format 'yyyyMMdd-HHmmssfffffff')_$(New-Guid)"
    $FOLDER_NAME = "Folder_$i"

    # Create the folder
    $FOLDER_PATH = Join-Path $ROOT_FOLDER $FOLDER_NAME
    New-Item -ItemType Directory -Path $FOLDER_PATH | Out-Null

    # Generate a random number of files between 1 and 100
    $NUMBER_OF_FILES = Get-Random -Minimum 1 -Maximum 100

    # Loop through the specified number of files to create
    for ($j = 1; $j -le $NUMBER_OF_FILES; $j++)
    {
        # Generate a unique GUID for the file name
        # $FILE_NAME = "$(New-Guid).txt"
        $FILE_NAME = "File_$j.txt"

        # Create the file
        $FILE_PATH = Join-Path $FOLDER_PATH $FILE_NAME
        New-Item -ItemType File -Path $FILE_PATH | Out-Null
    }
}

Write-Host "The script has finished creating $NUMBER_OF_FOLDERS folders with random number of files."
Write-Host "End:  $(Get-Date -Format 'yyyyMMdd-HHmmssfffffff')"

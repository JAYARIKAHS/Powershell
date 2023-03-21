Write-Host "Start:  $(Get-Date -Format 'yyyyMMdd-HHmmssfffffff')"

function CREATE-FILES()
{
    param(
        [string]$FOLDER_NAME
    )

    $MAX_FILES = Get-Random -Minimum 1 -Maximum 20
    # Loop through each file
    for ($m = 1; $m -le $MAX_FILES; $m++)
    {
        $FILE_NAME = "File_$m.txt"
        $FILE_PATH = Join-Path $FOLDER_NAME $FILE_NAME
                    
        # Get a random file size between 1 and 20 KB
        $FILE_SIZE = Get-Random -Minimum 1 -Maximum 20
        $FILE_CONTENT = New-Object byte[] ($FILE_SIZE * 1024)
        [System.IO.File]::WriteAllBytes($FILE_PATH, $FILE_CONTENT)
    }
}

# Location to create the parent folders
$ROOT_LOCATION = "C:\Temp"

# Number of parent folders to create
$NUM_PARENT_FOLDERS = Get-Random -Minimum 1 -Maximum 5

# Loop through each parent folder
for ($i = 1; $i -le $NUM_PARENT_FOLDERS; $i++)
{
    $PARENT_FOLDER_NAME = "P$i"
    $PARENT_PATH = Join-Path $ROOT_LOCATION $PARENT_FOLDER_NAME
    New-Item -ItemType Directory -Path $PARENT_PATH | Out-Null

    CREATE-FILES -FOLDER_NAME $PARENT_PATH
        
    # Get a random depth for this parent folder
    $LEVEL_ONE = Get-Random -Minimum 1 -Maximum 5
    
    # Loop through each depth level
    for ($j = 1; $j -le $LEVEL_ONE; $j++)
    {
        $DEPTH_NAME = "$PARENT_FOLDER_NAME" + "_1L$j"
        $DEPTH_PATH = Join-Path $PARENT_PATH $DEPTH_NAME
        New-Item -ItemType Directory -Path $DEPTH_PATH | Out-Null
        
        CREATE-FILES -FOLDER_NAME $DEPTH_PATH

        # Get a random number of subfolders for this depth level
        $LEVEL_TWO = Get-Random -Minimum 1 -Maximum 5
        
        # Loop through each subfolder
        for ($k = 1; $k -le $LEVEL_TWO; $k++)
	    {
            $LEVEL_THREE = Get-Random -Minimum 1 -Maximum 5
            $SUBFOLDER_NAME = "$DEPTH_NAME" + "_2L$k"
            $SUBFOLDER_PATH = Join-Path $DEPTH_PATH $SUBFOLDER_NAME
            New-Item -ItemType Directory -Path $SUBFOLDER_PATH | Out-Null
            
            CREATE-FILES -FOLDER_NAME $SUBFOLDER_PATH

            # Loop through each depth level of subfolder
            for ($l = 1; $l -lt $LEVEL_THREE; $l++)
	        {
                $SUB_DEPTH_NAME = "$SUBFOLDER_NAME" + "_3L$l"
                $SUB_DEPTH_PATH = Join-Path $SUBFOLDER_PATH $SUB_DEPTH_NAME
                New-Item -ItemType Directory -Path $SUB_DEPTH_PATH | Out-Null
                
                CREATE-FILES -FOLDER_NAME $SUB_DEPTH_PATH
            }
        }
    }
}

function EXPORT-FOLDERS($ROOT_LOCATION)
{
    # Get all folders recursively starting from the root location
    $FOLDERS = Get-ChildItem -Path $ROOT_LOCATION -Recurse -Directory

    # Create an empty array to hold the file information
    $CSV = @()

    # Loop through each folder
    foreach ($FOLDER in $FOLDERS)
    {
        # Get all files in the folder
        $FILES = Get-ChildItem -Path $FOLDER.FullName -File

        # Loop through each file
        foreach ($FILE in $FILES)
        {
            # Create an object with the file's full path
            $ITEM = [PSCustomObject]@{
                Path = $FILE.FullName
            }

            # Add the object to the array
            $CSV += $ITEM
        }
    }

    $CSV_NAME = "paths.csv"
    $EXPORT_PATH = Join-Path $ROOT_LOCATION $CSV_NAME

    # Export the array to a CSV file
    $CSV | Export-Csv -Path $EXPORT_PATH -NoTypeInformation
}

# This function will write the FOLDER PATHS as well as the FILES.
#function EXPORT-FOLDERS($ROOT_LOCATION)
#{
#    # Get all folders recursively starting from the root location
#    $FOLDERS = Get-ChildItem -Path $ROOT_LOCATION -Recurse -Directory
#
#    # Create an empty array to hold the folder and file information
#    $CSV = @()
#
#    # Loop through each folder
#    foreach ($FOLDER in $FOLDERS)
#    {
#        # Create an object with the folder's full path
#        $FOLDER_ITEM = [PSCustomObject]@{
#            Path = $FOLDER.FullName
#        }
#
#        # Add the folder object to the array
#        $CSV += $FOLDER_ITEM
#
#        # Get all files in the folder
#        $FILES = Get-ChildItem -Path $FOLDER.FullName -File
#
#        # Loop through each file
#        foreach ($FILE in $FILES)
#        {
#            # Create an object with the file's full path
#            $FILE_ITEM = [PSCustomObject]@{
#                Path = $FILE.FullName
#            }
#
#            # Add the file object to the array
#            $CSV += $FILE_ITEM
#        }
#    }
#
#    $CSV_NAME = "paths.csv"
#    $EXPORT_PATH = Join-Path $ROOT_LOCATION $CSV_NAME
#
#    # Export the array to a CSV file
#    $CSV | Export-Csv -Path $EXPORT_PATH -NoTypeInformation
#}

EXPORT-FOLDERS $ROOT_LOCATION

Write-Host "Done."
Write-Host "End:  $(Get-Date -Format 'yyyyMMdd-HHmmssfffffff')"



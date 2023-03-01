$UNCPaths = @("\\server1\share1", "\\server2\share2", "\\server3\share3")

$Excel = New-Object -ComObject Excel.Application
$Workbook = $Excel.Workbooks.Add()
$Sheet = $Workbook.Worksheets.Item(1)
$Sheet.Cells.Item(1, 1) = "Folder Name"
$Sheet.Cells.Item(1, 2) = "Size (MB)"
$Sheet.Cells.Item(1, 3) = "Total Files"
$Sheet.Cells.Item(1, 4) = "Total Sub Folders"

$Row = 2
foreach ($UNCPath in $UNCPaths)
{
	Write-Host "Processing $UNCPath"
	$Folder = Get-ChildItem $UNCPath -Force -Recurse -ErrorAction SilentlyContinue

	if ($Folder)
	{
		$Size = ($Folder | Measure-Object -Property Length -Sum).Sum / 1MB
		$FileCount = ($Folder | Where-Object { !$_.PSIsContainer } | Measure-Object).Count
		$SubfolderCount = ($Folder | Where-Object { $_.PSIsContainer } | Measure-Object).Count
		$Sheet.Cells.Item($Row, 1) = $UNCPath
		$Sheet.Cells.Item($Row, 2) = $Size
		$Sheet.Cells.Item($Row, 3) = $FileCount
		$Sheet.Cells.Item($Row, 4) = $SubfolderCount
		$Row++
	}
	else
	{
		Write-Host "$UNCPath does not exist or is not accessible."
		$Sheet.Cells.Item($Row, 1) = $UNCPath
		$Sheet.Cells.Item($Row, 2) = "N/A"
		$Sheet.Cells.Item($Row, 3) = "N/A"
		$Sheet.Cells.Item($Row, 4) = "N/A"
		$Row++
	}
}

$Excel.Visible = $False
$Workbook.SaveAs("C:\Temp\FolderSizes.xlsx")
$Excel.Quit()
Write-Host "Done"

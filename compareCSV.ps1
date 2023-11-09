# Get the current directory
$currentDirectory = Get-Location

# Prompt the user for the CSV file names
$csv1FileName = Read-Host "Please enter the name of the first CSV file"
$csv2FileName = Read-Host "Please enter the name of the second CSV file"
$outputFileName = "changes.csv"

# Combine the directory path with the filenames to create full paths
$csv1Path = Join-Path -Path $currentDirectory -ChildPath $csv1FileName
$csv2Path = Join-Path -Path $currentDirectory -ChildPath $csv2FileName
$outputPath = Join-Path -Path $currentDirectory -ChildPath $outputFileName

# Import the CSV files
$csv1 = Import-Csv -Path $csv1Path
$csv2 = Import-Csv -Path $csv2Path

# Compare the objects
$changes = Compare-Object -ReferenceObject $csv1 -DifferenceObject $csv2 -IncludeEqual

# Filter out the objects that are equal
$changes = $changes | Where-Object { $_.SideIndicator -ne "==" }

# Export the changes to a new CSV file
$changes | Export-Csv -Path $outputPath -NoTypeInformation

Write-Host "The comparison is complete. Changes have been output to $outputPath"

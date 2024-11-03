$corenlpPath = "C:\Users\PaoloJr\Downloads\stanford-corenlp-4.5.7"
$outputFile = "C:\Users\PaoloJr\Documents\GitHub\ConcordiaCS\stanfordJARs.txt";
$outputFolder = "C:\Users\PaoloJr\Documents\GitHub\ConcordiaCS\lib";

# Create the output folder if it does not exist
if (-not (Test-Path -Path $outputFolder)) {
    New-Item -ItemType Directory -Path $outputFolder
}

# Find all .jar files in the directory and its subdirectories
Get-ChildItem -Path $corenlpPath -Filter "*.jar" -Recurse | ForEach-Object {
    # Output the full path of each .jar file
    # Write-Output $_.FullName
    # Write-Output $_.Name
    Copy-Item $_.FullName -Destination $outputFolder
} | Out-File -FilePath $outputFile -Encoding UTF8

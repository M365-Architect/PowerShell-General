$GroupField = "Company"
$Delimiter = ";"
$csv = "S:\CSV-Files\MyBigCSVWithTonsOfData.csv"
$outfolder = "S:\CSV-Files\"

$all = Import-Csv $csv -Delimiter $Delimiter
$groupedCollection = $all | Group-Object $GroupField

foreach($group in $groupedCollection)
{
   Write-Host ("Group '" + $group.Name + "' // " + $group.Count.ToString() + " Members")
   $group.Group | ConvertTo-Csv -NoTypeInformation -Delimiter "," | Out-File ($outfolder + $group.Name + ".csv")
}
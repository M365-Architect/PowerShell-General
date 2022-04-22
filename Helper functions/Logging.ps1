#========================================================================
<#
	.SYNOPSIS
		Gets the currents timestamp in Format "dd:MM:yyyy hh:mm"

	.DESCRIPTION
		Gets the currents timestamp in Format "dd:MM:yyyy hh:mm"
	
	.OUTPUTS
		System.String

#>
function Get-Timestamp
{
	#returns a padded timestamp string like 10.02.2014 17:02 
	$now = Get-Date
	$year = $now.Year.ToString()
	$month = $now.Month.ToString()
	$day = $now.Day.ToString()
	$hour = $now.Hour.ToString()
	$minute = $now.Minute.ToString()
	$second = $now.Second.ToString()
	
	#region make sure all numbers have 2 digits	
	if ($month.length -lt 2) { $month = "0" + $month }
	if ($day.length -lt 2) { $day = "0" + $day }
	if ($hour.length -lt 2) { $hour = "0" + $hour }
	if ($minute.length -lt 2) { $minute = "0" + $minute }
	if ($second.lenth -lt 2) { $second = "0" + $second }
	#endregion
	
	Write-Output ($day + "." + $month + "." + $year + " " + $hour + ":" + $minute + ":" + $second)
}

#========================================================================
<#
	.SYNOPSIS
		Gets the currents timestamp in Format "yyyyMMddhhmm"

	.DESCRIPTION
		Gets the currents timestamp in Format "yyyyMMddhhmm"
	
	.OUTPUTS
		System.String

#>
function Get-TimestampyyyyMMdd
{
	#returns a padded timestamp string like 10.02.2014 17:02 
	$now = Get-Date
	$year = $now.Year.ToString()
	$month = $now.Month.ToString()
	$day = $now.Day.ToString()
	$hour = $now.Hour.ToString()
	$minute = $now.Minute.ToString()
	$second = $now.Second.ToString()
	
	#region make sure all numbers have 2 digits	
	if ($month.length -lt 2) { $month = "0" + $month }
	if ($day.length -lt 2) { $day = "0" + $day }
	if ($hour.length -lt 2) { $hour = "0" + $hour }
	if ($minute.length -lt 2) { $minute = "0" + $minute }
	if ($second.length -lt 2) { $second = "0" + $second }
	#endregion
	
	Write-Output ($year + $month + $day) #+ $hour + $minute)
}

#========================================================================
<#
	.SYNOPSIS
		Gets the currents timestamp in Format "yyyyMMddhhmmss"

	.DESCRIPTION
		Gets the currents timestamp in Format "yyyyMMddhhmmss"
	
	.OUTPUTS
		System.String

#>
function Get-TimestampyyyyMMddhhmmss
{
	#returns a padded timestamp string like 10.02.2014 17:02 
	$now = Get-Date
	$year = $now.Year.ToString()
	$month = $now.Month.ToString()
	$day = $now.Day.ToString()
	$hour = $now.Hour.ToString()
	$minute = $now.Minute.ToString()
	$second = $now.Second.ToString()
	
	#region make sure all numbers have 2 digits	
	if ($month.length -lt 2) { $month = "0" + $month }
	if ($day.length -lt 2) { $day = "0" + $day }
	if ($hour.length -lt 2) { $hour = "0" + $hour }
	if ($minute.length -lt 2) { $minute = "0" + $minute }
	if ($second.lenth -lt 2) { $second = "0" + $second }
	#endregion
	
	Write-Output ($year + $month + $day + $hour + $minute + $second)
}

#========================================================================
<#
	.SYNOPSIS
		Writes the specified text to the specified Logfile

	.DESCRIPTION
		The text is appended to the logfile. If the file does not exist, it will be created

	.PARAMETER  filename
		The file the text should be written to.

	.PARAMETER  text
		The text to append to the file.

	.PARAMETER  timestamp
		Writes the current timestamp at the beginning of the line.

	.EXAMPLE
		Write-LogFile -filename "C:\log.txt" -text "Hallo Welt"

	.INPUTS
		System.String
#>
function Write-LogFile
{
	param (
		[Parameter(Mandatory = $true)]
		[string]$filename,
		[Parameter(Mandatory = $true)]
		[string]$text,
		[Parameter(Mandatory = $false)]
		[boolean]$timestamp
	)
	if (-not $timestamp)
	{
		$text = ";" + $text
		Out-File $filename -Append -NoClobber -InputObject $text
	}
	else
	{
		$stamp = Get-Timestamp
		$text = $stamp + ";" + $text
		Out-File $filename -Append -NoClobber -InputObject $text
	}
}

#========================================================================
<#
    .SYNOPSIS
        Writes a Text to Console and Logfile

    .PARAMETER text
        The text to write

    .PARAMETER $textcolour
        The color the text should be written to console

#>
function Tee-ToLogAndConsole
{
	param
	(
		[Parameter(Mandatory = $true)]
		[string]$text,
		[Parameter(Mandatory = $false)]
		[System.ConsoleColor]$textcolour
	)
	if ($textcolour) { Write-Host $text -ForegroundColor $textcolour }
	else { Write-Host $text }
	
	
	Write-LogFile -text $text -filename $logfile -timestamp $true
}
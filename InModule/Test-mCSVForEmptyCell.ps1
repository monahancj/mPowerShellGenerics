function Test-mCSVForEmptyCell {

	<#
	.SYNOPSIS
		Checks a CSV file for any empty cells.

    .DESCRIPTION
		Reads a CSV file and checks every cell to see if it is empty. It will output information about which row and column have empty cells, and return a boolean indicating if any empty cells were found.

    .PARAMETER CSVFile
		The CSV file to be tested.

    .EXAMPLE
		PS> Test-mCSVForEmptyCell -CSVFile ".\data.csv"
		True

    .INPUTS
		System.IO.FileInfo
		A file object representing the CSV file.

    .OUTPUTS
		System.Boolean
		Returns $true if empty cells exist, otherwise $false.

    .NOTES
		Created by:   	Christopher Monahan
		Organization: 	companyname

	.LINK
		https://github.com/companyname-Platform-Services/mPowerShellGenerics/blob/main/InModule/Test-mCSVForEmptyCell.ps1
#>

	<# Comment History
	2026-02-25 cmonahan - Updated to match the standard function template using Google Antigravity editor and Gemini 3 Pro Low.
#>

	[OutputType([System.Boolean])]
	[cmdletbinding(SupportsShouldProcess = $false, PositionalBinding = $true, SupportsPaging = $false, SupportsTransactions = $false, RemotingCapability = 'None')]
	param (
		[Parameter(Position = 0, Mandatory = $true, ValueFromPipeline = $true)]
		[System.IO.FileInfo]$CSVFile
	)

	begin {
		# Code to be executed once BEFORE the pipeline is processed goes here.

		Write-Verbose -Message "$(Get-mNow)- $($MyInvocation.InvocationName) - Line $(Get-mCurrentLine) - Function started."

		Write-Verbose -Message "$(Get-mNow)- $($MyInvocation.InvocationName) - Line $(Get-mCurrentLine) - Begin block start"
		$EAPsaved = $ErrorActionPreference

		# The functions Get-mNow and Get-mCurrentLine are used in every script and function.
		if (Test-Path -Path function:\Get-mNow) { Write-Verbose -Message "$(Get-mNow)- $($MyInvocation.InvocationName) - Line $(Get-mCurrentLine) - Function Get-mNow is loaded in the session." }
		else { throw "$(Get-mNow)- $($MyInvocation.InvocationName) - The function Get-mNow is not loaded in the session." }

		if (Test-Path -Path function:\Get-mCurrentLine) { Write-Verbose -Message "$(Get-mNow)- $($MyInvocation.InvocationName) - Line $(Get-mCurrentLine) - Function Get-mCurrentLine is loaded in the session." }
		else { throw "$(Get-mNow)- $($MyInvocation.InvocationName) - The function Get-mCurrentLine is not loaded in the session." }

		Write-Verbose -Message "$(Get-mNow)- $($MyInvocation.InvocationName) - Line $(Get-mCurrentLine) - Function started."

		# Test for required functions that aren't in required modules.  Remove this section if it's not needed.
		$FunctionList = "Test-mIsModuleLoaded", "Get-mCurrentLine", "Get-mNow"
		$FunctionList | ForEach-Object {
			if (Test-Path -Path function:\"$($_)") { Write-Verbose -Message "$(Get-mNow)- $($MyInvocation.InvocationName) - Line $(Get-mCurrentLine) - Function $($_) is loaded in the session." }
			else { throw "$(Get-mNow)- $($MyInvocation.InvocationName) - Line $(Get-mCurrentLine) - Function $($_) is not loaded in the session." }
		}

		# Test for required modules.  Internal support modules and vendor specific technology modules in addition to the builtin Microsoft PowerShell modules.  Remove this section if it's not needed.
		$ModuleList = "mPowerShellGenerics", "Microsoft.PowerShell.Security"
		$ModuleList | ForEach-Object {
			if (Test-mIsModuleLoaded -Name $_) { Write-Verbose -Message "$(Get-mNow)- $($MyInvocation.InvocationName) - Line $(Get-mCurrentLine) - Module $($_) is loaded in the session." }
			else { throw "$(Get-mNow)- $($MyInvocation.InvocationName) - Line $(Get-mCurrentLine) - Module $($_) is not loaded in the session." }
		}

		Write-Verbose -Message "$(Get-mNow)- $($MyInvocation.InvocationName) - Line $(Get-mCurrentLine) - Begin block end"

	} # end of the begin block

	process {
		# Code to be executed against every object in the pipeline goes here.

		Write-Verbose -Message "$(Get-mNow)- $($MyInvocation.InvocationName) - Line $(Get-mCurrentLine) - Process block start - CSVFile $($CSVFile)"

		# Validate the parameters as needed.
		if (Test-Path $CSVFile) { Write-Verbose -Message "$(Get-mNow)- $($MyInvocation.InvocationName) - Line $(Get-mCurrentLine) - CSVFile $($CSVFile) exists." }
		else {
			Write-Error -Message "$(Get-mNow)- $($MyInvocation.InvocationName) - Line $(Get-mCurrentLine) - CSVFile $($CSVFile) does not exist.  Exiting."
			break
		}

		# Do the work
		$EmptyCellsExists = $false
		$CSVData = Import-Csv $CSVFile
		$ColumnNames = $CSVData | Get-Member | Where-Object { $_.MemberType -eq 'NoteProperty' } | Select-Object -ExpandProperty Name
		$NumRows = ($CSVData | Measure-Object).Count

		Write-Information -MessageData "$(Get-mNow)- $($MyInvocation.InvocationName) - Line $(Get-mCurrentLine) - Rows in the CSV file with empty cells."
		$i = 0 # Index to loop through the rows in $CSVData
		while ($i -lt $NumRows) {
			foreach ($cn in $ColumnNames) {
				if (-not ($CSVData[$i].$cn)) {
					Write-Output "Row: $($i)`tColumn: $($cn)"
					$EmptyCellsExists = $true
				}
			}
			++$i
		}

		if (-not $EmptyCellsExists) { Write-Information -MessageData "$(Get-mNow)- $($MyInvocation.InvocationName) - Line $(Get-mCurrentLine) - There were no empty cells in the CSV file." }

		$EmptyCellsExists

		Write-Verbose -Message "$(Get-mNow)- $($MyInvocation.InvocationName) - Line $(Get-mCurrentLine) - Process block end"

	} #end of the process block

	end {
		# Code to be executed once AFTER the pipeline is processed goes here.  Disconnect server connections, remove variables, reset the transcript file if necessary, and any other cleanup.

		Write-Verbose -Message "$(Get-mNow)- $($MyInvocation.InvocationName) - Line $(Get-mCurrentLine) - End block start"

		Remove-Variable -Name ModuleList, FunctionList, CSVFile, CSVData, ColumnNames, Numrows, i, cn, EmptyCellsExists -ErrorAction SilentlyContinue -WhatIf:$false # Using -WhatIf:$false to suppress unnecessary messages when a calling function has -Whatif:$true enabled.

		[System.GC]::Collect() # Memory cleanup
		$ErrorActionPreference = $EAPsaved

		Write-Verbose -Message "$(Get-mNow)- $($MyInvocation.InvocationName) - Line $(Get-mCurrentLine) - End block end"
		Write-Verbose -Message "$(Get-mNow)- $($MyInvocation.InvocationName) - Line $(Get-mCurrentLine) - Function ended - $($MyInvocation.InvocationName)"
	} #end of the end block

} # end of the function Test-mCSVForEmptyCell

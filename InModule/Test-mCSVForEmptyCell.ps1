function Test-mCSVForEmptyCell {
	
<#
	.SYNOPSIS
		A brief description of the function or script. This keyword can be used only once in each topic.

    .DESCRIPTION
		A detailed description of the function or script. This keyword can be used only once in each topic.

    .PARAMETER <Parameter-Name>
		The description of a parameter. Add a .PARAMETER keyword for each parameter in the function or script syntax.

    .EXAMPLE
		A sample command that uses the function or script, optionally followed by sample output and a description. Repeat this keyword for each example.

    .INPUTS
		The Microsoft .NET Framework types of objects that can be piped to the function or script. You can also include a description of the input objects.

    .OUTPUTS
		The .NET Framework type of the objects that the cmdlet returns. You can also include a description of the returned objects.

    .NOTES
		Additional information about the function or script.

		Original Author: YOUR NAME HERE, Monster Worldwide GTIS
		Contributors:	 name,org

	.LINK
		https://linktogithublocation

#>
	#TODO: Fill out the comment based help.
	
<# Comment History
	YYYY-MM-DD username- Initial add
#>
	
	[OutputType([System.Boolean])]
	[cmdletbinding(SupportsShouldProcess = $false, PositionalBinding = $true, SupportsPaging = $false, SupportsTransactions = $false, RemotingCapability = 'None')]

	param (
		[Parameter(Position = 0, Mandatory = $true, ValueFromPipeline = $true)]
		[System.IO.FileInfo]$CSVFile
	)
	
	begin {
		Write-Verbose "$(Get-mNow)- $($MyInvocation.InvocationName) - Line $(Get-mCurrentLine) - Function started."
		# Code to be executed once BEFORE the pipeline is processed goes here.
		Write-Verbose "$(Get-mNow)- $($MyInvocation.InvocationName) - Line $(Get-mCurrentLine) - Begin block start"
		$EAPsaved = $ErrorActionPreference
		#TODO: Maybe protect other preferences?
		
		# The function Get-mCurrentLine is used in every script and function.
		if (Test-Path -Path function:\Get-mCurrentLine) { Write-Verbose "$(Get-mNow)- $($MyInvocation.InvocationName) - Line $(Get-mCurrentLine) - Function Get-mCurrentLine is loaded in the session." }
		else { throw "$(Get-mNow)- $($MyInvocation.InvocationName) - The function Get-mCurrentLine is not loaded in the session." }
		
		Write-Verbose "$(Get-mNow)- $($MyInvocation.InvocationName) - Line $(Get-mCurrentLine) - Function started."
		
		# Test for required functions that aren't in required modules.  Remove this section if it's not needed.
		$FunctionList = "Test-mIsModuleLoaded", "Get-mCurrentLine"
		$FunctionList | ForEach-Object {
			if (Test-Path -Path function:\"$($_)") { Write-Verbose -Message "$(Get-mNow)- $($MyInvocation.InvocationName) - Line $(Get-mCurrentLine) - Function $($_) is loaded in the session." }
			else { throw "$(Get-mNow)- $($MyInvocation.InvocationName) - Line $(Get-mCurrentLine) - Function $($_) is not loaded in the session." }
		}
		
		# Test for required modules.  Internal support modules and vendor specific technology modules in addition to the builtin Microsoft PowerShell modules.  Remove this section if it's not needed.
		$ModuleList = "mPowerShellGenerics", "Microsoft.PowerShell.Security"
		$ModuleList | ForEach-Object {
			if (Test-mIsModuleLoaded -Name $_) { Write-Verbose "$(Get-mNow)- $($MyInvocation.InvocationName) - Line $(Get-mCurrentLine) - Module $($_) is loaded in the session." }
			else { throw "$(Get-mNow)- $($MyInvocation.InvocationName) - Line $(Get-mCurrentLine) - Module $($_) is not loaded in the session." }
		}
		
		Write-Verbose "$(Get-mNow)- $($MyInvocation.InvocationName) - Line $(Get-mCurrentLine) - Begin block end"
		
	} # end of the begin block
	
	process {
		# Code to be executed against every object in the pipeline goes here.
		Write-Verbose "$(Get-mNow)- $($MyInvocation.InvocationName) - Line $(Get-mCurrentLine) - Process block start - CSVFile $($CSVFile)"
		
		# Validate the parameters as needed.
		if (Test-Path $CSVFile) { Write-Verbose -Message "$(get-mNow)- $($MyInvocation.InvocationName) - Line $(Get-mCurrentLine) - CSVFile $($CSVFile) exists." }
		else {
			Write-Error -Message "$(get-mNow)- $($MyInvocation.InvocationName) - Line $(Get-mCurrentLine) - CSVFile $($CSVFile) does not exist.  Exiting."
			break
		}
		
		# Do the work
		$EmptyCellsExists = $false
		$CSVData = Import-Csv $CSVFile
		$ColumnNames = $CSVData | Get-Member | Where-Object { $_.MemberType -eq 'NoteProperty' } | Select-Object -ExpandProperty Name
		$NumRows = ($CSVData | Measure-Object).Count
		
		Write-Information -MessageData "$(get-mNow)- $($MyInvocation.InvocationName) - Line $(Get-mCurrentLine) - Rows in the CSV file with empty cells."
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
		
		if (-not $EmptyCellsExists) { Write-Information -MessageData "$(get-mNow)- $($MyInvocation.InvocationName) - Line $(Get-mCurrentLine) - There were no empty cells in the CSV file." }
		
		Write-Verbose "$(Get-mNow)- $($MyInvocation.InvocationName) - Line $(Get-mCurrentLine) - Process block end"

		return $EmptyCellsExists
		
	} #end of the process block
	
	end {
		# Code to be executed once AFTER the pipeline is processed goes here.  Disconnect server connections, remove variables, reset the transcript file if necessary, and any other cleanup.
		Write-Verbose "$(Get-mNow)- $($MyInvocation.InvocationName) - Line $(Get-mCurrentLine) - End block start"
		# When testing comment out "-ErrorAction SilentlyContinue".  This will help find typos, unused variables, and other problems.
		Remove-Variable -Name ModuleList, FunctionList, CSVFile,CSVData, ColumnNames, Numrows, i, cn -WhatIf:$false #TODO: When function is production ready uncomment the -ErrorAcction parameter # -ErrorAction SilentlyContinue # Using -WhatIf:$false to suppress unnecessary messages when a calling function has -Whatif:$true enabled.
		
		[System.GC]::Collect() # Memory cleanup
		$ErrorActionPreference = $EAPsaved
		
		Write-Verbose "$(Get-mNow)- $($MyInvocation.InvocationName) - Line $(Get-mCurrentLine) - End block end"
		Write-Verbose "$(Get-mNow)- $($MyInvocation.InvocationName) - Line $(Get-mCurrentLine) - Function ended."
	} #end of the end block
	
} # end of the function Test-mCSVForEmptyCell (Useful for when you are looking at a function in a PSM1 file.  Can easily see when a function ends.  Can also be used with select string to find the start and end of a function.  I don't have a use case for that last one, but who know?)

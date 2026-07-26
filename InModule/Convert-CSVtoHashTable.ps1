function Convert-CSVtoHashTable {

	<#
    .SYNOPSIS
        A brief description of the function or script. This keyword can be used
        only once in each topic.

    .DESCRIPTION
        A detailed description of the function or script. This keyword can be
        used only once in each topic.

    .PARAMETER InputCSVFile
        The description of a parameter. Add a .PARAMETER keyword for
        each parameter in the function or script syntax.

    .PARAMETER LookupColumnNumber
        The description of a parameter. Add a .PARAMETER keyword for
        each parameter in the function or script syntax.

    .EXAMPLE
        A sample command that uses the function or script, optionally followed
        by sample output and a description. Repeat this keyword for each example.

    .INPUTS
        The Microsoft .NET Framework types of objects that can be piped to the
        function or script. You can also include a description of the input
        objects.

    .OUTPUTS
        The .NET Framework type of the objects that the cmdlet returns. You can
        also include a description of the returned objects.

    .NOTES
        Additional information about the function or script.

		Created by:   	cmonahan
		Organization: 	companyname

		Recent Comment History
		----------------------
		YYYMMDD username- 1st comment.
		YYYMMDD username- 2nd comment.
		YYYMMDD username- 3rd comment.

		ToDo
		----------------------
		-Make move to decom folder work when connected to multiple vCenters.

	.LINK
		https://github.com/companyname-Platform-Services/mPowerShellGenerics/blob/main/InModule/Convert-CSVtoHashTable.ps1

		Below is the link where I got the two lines of code that do the real work.
        http://powershell.com/cs/blogs/tips/archive/2013/06/12/turning-csv-files-into-quot-databases-quot.aspx
	#>

	#ToDo: Fill out comment based help
	<# Comment History
		2026-02-25 cmonahan - Updated to match the standard function template using Google Antigravity editor and Gemini 3 Pro Low.
		2017-06-08 cmonahan - Finally put it into a file and module.
	#>

	[cmdletbinding(SupportsShouldProcess = $true)]
	param (
		[Parameter(Position = 0, Mandatory = $true, ValueFromPipeline = $true)]
		[System.IO.FileInfo]$InputCSVFile,
		[Parameter(Position = 1, Mandatory = $false, ValueFromPipeline = $true)]
		[Int]$LookupColumnNumber = 0 # defaults to first column
		#		[Parameter(Position = 2, Mandatory = $false, ValueFromPipeline = $true)]
		#		[String]$OutputVariableName
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

		Write-Verbose -Message "$(Get-mNow)- $($MyInvocation.InvocationName) - Line $(Get-mCurrentLine) - Begin block end"

	} # end of the begin block

	process {
		# Code to be executed against every object in the pipeline goes here.

		Write-Verbose -Message "$(Get-mNow)- $($MyInvocation.InvocationName) - Line $(Get-mCurrentLine) - Process block start - InputCSVFile $($InputCSVFile) - LookupColumnNumber $($LookupColumnNumber)"

		Write-Verbose "InputCSVFile: $($InputCSVFile)`nInputCSVFile Basename: $($InputCSVFile.Basename)`nLookupColumnNumber: $($LookupColumnNumber)`nOutputVariableName: $($OutputVariableName)"
		if (!$OutputVariableName) {
			# If no output variable name is passed use the CSV file base name as the output variable name.
			$OutputVariableName = $InputCSVFile.Basename
		}
		Write-Verbose "InputCSVFile: $($InputCSVFile)`nInputCSVFile Basename: $($InputCSVFile.Basename)`nLookupColumnNumber: $($LookupColumnNumber)`nOutputVariableName: $($OutputVariableName)"
		$LookupColumnName = ((Get-Content $InputCSVFile | Select-Object -First 1) -split (','))[0]
		Write-Verbose "InputCSVFile: $($InputCSVFile)`nInputCSVFile Basename: $($InputCSVFile.Basename)`nLookupColumnNumber: $($LookupColumnNumber)`nOutputVariableName: $($OutputVariableName)"

		# The two lines of code I copied that do the real work.
		$content = Import-CSV $InputCSVFile -Encoding UTF8
		$lookup = $content | Group-Object -AsHashTable -AsString -Property $LookupColumnName
		#	$content | select -First 3 | ft -AutoSize;  $lookup['FOX1404GA7N']
		#	Set-Variable -Name "$($OutputVariableName)_csvdb" -Value $lookup -Scope Global -Verbose
		#	Get-Variable "$($OutputVariableName)_csvdb"
		$lookup

		Write-Verbose -Message "$(Get-mNow)- $($MyInvocation.InvocationName) - Line $(Get-mCurrentLine) - Process block end"

	} #end of the process block

	end {
		# Code to be executed once AFTER the pipeline is processed goes here.  Disconnect server connections, remove variables, reset the transcript file if necessary, and any other cleanup.

		Write-Verbose -Message "$(Get-mNow)- $($MyInvocation.InvocationName) - Line $(Get-mCurrentLine) - End block start"

		Remove-Variable -Name InputCSVfile, LookupColumnNumber, OutputVariableName, LookupColumnName, content, lookup -ErrorAction SilentlyContinue -WhatIf:$false # Using -WhatIf:$false to suppress unnecessary messages when a calling function has -Whatif:$true enabled.

		[System.GC]::Collect() # Memory cleanup
		$ErrorActionPreference = $EAPsaved

		Write-Verbose -Message "$(Get-mNow)- $($MyInvocation.InvocationName) - Line $(Get-mCurrentLine) - End block end"
		Write-Verbose -Message "$(Get-mNow)- $($MyInvocation.InvocationName) - Line $(Get-mCurrentLine) - Function ended - $($MyInvocation.InvocationName)"

	} #end of the end block

} # end of the function Convert-CSVtoHashTable

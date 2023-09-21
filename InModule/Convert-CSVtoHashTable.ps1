function Convert-CSVtoHashTable {

	<#
    .SYNOPSIS
        A brief description of the function or script. This keyword can be used
        only once in each topic.

    .DESCRIPTION
        A detailed description of the function or script. This keyword can be
        used only once in each topic.

    .PARAMETER  <Parameter-Name>
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
		Organization: 	Monster Worldwide, GTI

		Recent Comment History
		----------------------
		YYYMMDD username- 1st comment.
		YYYMMDD username- 2nd comment.
		YYYMMDD username- 3rd comment.

		ToDo
		----------------------
		-Make move to decom folder work when connected to multiple vCenters.

	.LINK
		Below is the link where I got the two lines of code that do the real work.
        http://powershell.com/cs/blogs/tips/archive/2013/06/12/turning-csv-files-into-quot-databases-quot.aspx

#>

	#ToDo: Fill out comment based help

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

		# code to be executed once BEFORE the pipeline is processed goes here

	} # end begin block

	process {
		Write-Verbose "InputCSVFile: $($InputCSVFile)`nInputCSVFile Basename: $($InputCSVFile.Basename)`nLookupColumnNumber: $($LookupColumnNumber)`nOutputVariableName: $($OutputVariableName)"
		# code to be executed against every object in the pipeline goes here
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
	} #end of the process block

	end {
		
		Remove-Variable InputCSVfile, LookupColumnNumber, OutputVariableName-ErrorAction SilentlyContinue -WhatIf:$false # Using -WhatIf:$false to suppress unnecessary messages when a calling function has -Whatif:$true enabled.
		[System.GC]::Collect() # Memory cleanup

	} #end of the end block

} # end function


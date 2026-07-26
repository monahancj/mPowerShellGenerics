function Get-mRecordFromArray {

	<#
    .SYNOPSIS
        A brief description of the function or script. This keyword can be used
        only once in each topic.

    .DESCRIPTION
        A detailed description of the function or script. This keyword can be
        used only once in each topic.

    .PARAMETER SearchData
        The description of a parameter. Add a .PARAMETER keyword for
        each parameter in the function or script syntax.

    .PARAMETER SearchColumn
        The description of a parameter. Add a .PARAMETER keyword for
        each parameter in the function or script syntax.

    .PARAMETER SearchItem
        The description of a parameter. Add a .PARAMETER keyword for
        each parameter in the function or script syntax.

    .PARAMETER ResultsColumn
        The description of a parameter. Add a .PARAMETER keyword for
        each parameter in the function or script syntax.

    .EXAMPLE
        Get-mRecordFromArray -SearchData $pinv -SearchColumn "Serial Number" -SearchItem $data -ResultsColumn "Serial Number"

    .INPUTS
        The Microsoft .NET Framework types of objects that can be piped to the
        function or script. You can also include a description of the input
        objects.

    .OUTPUTS
        The .NET Framework type of the objects that the cmdlet returns. You can
        also include a description of the returned objects.

    .NOTES
        Additional information about the function or script.

		Original Author: cmonahan, companyname

	.LINK
		https://github.com/companyname-Platform-Services/mPowerShellGenerics/blob/main/InModule/Get-mRecordFromArray.ps1

#>

	<# Comment History
	2026-02-25 cmonahan - Updated to match the standard function template using Google Antigravity editor and Gemini 3 Pro Low.
	2016-12-05 cmonahan - Initial release.
#>

	[cmdletbinding(SupportsShouldProcess = $true)]
	param (
		[Parameter(Position = 0, Mandatory = $true, ValueFromPipeline = $false)]
		$SearchData,
		[Parameter(Position = 1, Mandatory = $true, ValueFromPipeline = $false)]
		$SearchColumn,
		[Parameter(Position = 2, Mandatory = $true, ValueFromPipeline = $false)]
		$SearchItem,
		[Parameter(Position = 3, Mandatory = $true, ValueFromPipeline = $false)]
		$ResultsColumn
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
		$ModuleList = "mPowerShellGenerics"
		$ModuleList | ForEach-Object {
			if (Test-mIsModuleLoaded -Name $_) { Write-Verbose -Message "$(Get-mNow)- $($MyInvocation.InvocationName) - Line $(Get-mCurrentLine) - Module $($_) is loaded in the session." }
			else { throw "$(Get-mNow)- $($MyInvocation.InvocationName) - Line $(Get-mCurrentLine) - Module $($_) is not loaded in the session." }
		}

		Write-Verbose -Message "$(Get-mNow)- $($MyInvocation.InvocationName) - Line $(Get-mCurrentLine) - Begin block end"

	} # end of the begin block

	process {
		# Code to be executed against every object in the pipeline goes here.

		Write-Verbose -Message "$(Get-mNow)- $($MyInvocation.InvocationName) - Line $(Get-mCurrentLine) - Process block start"

		#foreach ($Record in ($SearchItem)) { if ($SearchData.$SearchColumn.Contains($Record)) { $SearchData | Where-Object { $_.$SearchColumn -eq $Record } } }
		if ($SearchData.$SearchColumn.Contains($SearchItem)) { ($SearchData | Where-Object { $_.$SearchColumn -eq $SearchItem }).$ResultsColumn }

		Write-Verbose -Message "$(Get-mNow)- $($MyInvocation.InvocationName) - Line $(Get-mCurrentLine) - Process block end"

	} #end of the process block

	end {
		# Code to be executed once AFTER the pipeline is processed goes here.  Disconnect server connections, remove variables, reset the transcript file if necessary, and any other cleanup.

		Write-Verbose -Message "$(Get-mNow)- $($MyInvocation.InvocationName) - Line $(Get-mCurrentLine) - End block start"

		Remove-Variable -Name SearchData, SearchColumn, SearchItem, ResultsColumn, ModuleList, FunctionList -ErrorAction SilentlyContinue -WhatIf:$false # Using -WhatIf:$false to suppress unnecessary messages when a calling function has -Whatif:$true enabled.

		[System.GC]::Collect() # Memory cleanup
		$ErrorActionPreference = $EAPsaved

		Write-Verbose -Message "$(Get-mNow)- $($MyInvocation.InvocationName) - Line $(Get-mCurrentLine) - End block end"
		Write-Verbose -Message "$(Get-mNow)- $($MyInvocation.InvocationName) - Line $(Get-mCurrentLine) - Function ended - $($MyInvocation.InvocationName)"

	} #end of the end block

} # end of the function Get-mRecordFromArray

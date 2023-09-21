function Get-mDateForLogEntry {

<#
	.SYNOPSIS
		A brief description of the function or script. This keyword can be used only once in each topic.

    .DESCRIPTION
		A detailed description of the function or script. This keyword can be used only once in each topic.

    .PARAMETER  <Parameter-Name>
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
		https:\\linktogithublocation

#>
	#TODO: Fill out the comment based help.
	
<# Comment History
	YYYY-MM-DD username- Initial add
#>
	
	[OutputType([System.String])]
	[cmdletbinding(SupportsShouldProcess = $false, ConfirmImpact = 'None', PositionalBinding = $true, SupportsPaging = $false, SupportsTransactions = $false, RemotingCapability = 'None')]

	param ()

	begin {
		# Code to be executed once BEFORE the pipeline is processed goes here.
		Write-Verbose "$(Get-mNow)- $($MyInvocation.InvocationName) - Line $(Get-mCurrentLine) - Begin block start"
		# The function Get-mCurrentLine is used in every script and function.
		if (Test-Path -Path function:\Get-mCurrentLine) { Write-Verbose "$(Get-mNow)- $($MyInvocation.InvocationName) - Line $(Get-mCurrentLine) - Function Get-mCurrentLine is loaded in the session." }
		else { throw "$(Get-mNow)- $($MyInvocation.InvocationName) - Line 52 or so - Function Get-mCurrentLine is not loaded in the session." }

		Write-Verbose "$(Get-mNow)- $($MyInvocation.InvocationName) - Line $(Get-mCurrentLine) - Function started."

		# Test for required modules.  Internal support modules and vendor specific technology modules in addition to the builtin Microsoft PowerShell modules.  Remove this section if it's not needed.
		$ModuleList = "mPowerShellGenerics"
		$ModuleList | ForEach-Object {
			if (Test-mIsModuleLoaded -Name $_) { Write-Verbose "$(Get-mNow)- $($MyInvocation.InvocationName) - Line $(Get-mCurrentLine) - Module $($_) is loaded in the session." }
			else { throw "$(Get-mNow)- $($MyInvocation.InvocationName) - Line $(Get-mCurrentLine) - Module $($_) is not loaded in the session." }
		}

		# Test for required functions that aren't in required modules.  Remove this section if it's not needed.
		$FunctionList = $null
		$FunctionList | ForEach-Object {
			if (Test-Path -Path function:\"$($_)") { Write-Verbose -Message "$(Get-mNow)- $($MyInvocation.InvocationName) - Line $(Get-mCurrentLine) - Function $($_) is loaded in the session." }
			else { throw "$(Get-mNow)- $($MyInvocation.InvocationName) - Line $(Get-mCurrentLine) - Function $($_) is not loaded in the session." }
		}

		Write-Verbose "$(Get-mNow)- $($MyInvocation.InvocationName) - Line $(Get-mCurrentLine) - Begin block end"

	} # end of the begin block

	process {
		# Code to be executed against every object in the pipeline goes here.
		Write-Verbose "$(Get-mNow)- $($MyInvocation.InvocationName) - Line $(Get-mCurrentLine) - Process block start - no parameters"

		# Do the work
		return (Get-Date -UFormat "%Y-%m-%d %H:%M:%S")

		Write-Verbose "$(Get-mNow)- $($MyInvocation.InvocationName) - Line $(Get-mCurrentLine) - Process block end"
		
	} #end of the process block

	end {
		# Code to be executed once AFTER the pipeline is processed goes here.  Disconnect server connections, remove variables, reset the transcript file if necessary, and any other cleanup.
		Write-Verbose "$(Get-mNow)- $($MyInvocation.InvocationName) - Line $(Get-mCurrentLine) - End block start"
		# When testing comment out "-ErrorAction SilentlyContinue".  This will help find typos, unused variables, and other problems.
		Remove-Variable ModuleList, FunctionList -WhatIf:$false # -ErrorAction SilentlyContinue # Using -WhatIf:$false to suppress unnecessary messages when a calling function has -Whatif:$true enabled.

		[System.GC]::Collect() # Memory cleanup

		Write-Verbose "$(Get-mNow)- $($MyInvocation.InvocationName) - Line $(Get-mCurrentLine) - End block end"
		Write-Verbose "$(Get-mNow)- $($MyInvocation.InvocationName) - Line $(Get-mCurrentLine) - Function ended."

	} #end of the end block

} # end of the function Get-mDateForLogEntry

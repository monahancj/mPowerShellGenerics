class cmdletNoun_Properties {
	# Class to define a custom output type.  Remove if not needed.  Name the class using the function's noun with "cmdletNoun_Properties" appended.  The function "Get-Stuff" would have the class name "Stuff_Properties".  This is also used for the PSCustomObject name.
	[string]$OutputProperty1
	[int]$OutputProperty2
}

function ConvertTo-mStandardDateFormat.ps1 {
	
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

		Original Author: YOUR NAME HERE, companyname
		Contributors:	 name,org
	
	.LINK
		https:\\linktogithublocation
	
#>
	#TODO: Fill out the comment based help.
	
	#TODO: Evaluate which cmdletbinding options are appropriate for the script.
	[OutputType([InserTheOutputTypeOrRemoveTheLine])][cmdletbinding(SupportsShouldProcess = $false, ConfirmImpact = $false, PositionalBinding = $true, DefaultParameterSetName = "changeme", SupportsPaging = $false, SupportsTransactions = $false, RemotingCapability = $false, HelpUri = "changeme")]
	
	param (
		[Parameter(Position = 0, Mandatory = $true, ValueFromPipeline = $false)]$Date,
		[Parameter(Position = 1, Mandatory = $false, ValueFromPipeline = $false)]$LogStandard,
		[Parameter(Position = 2, Mandatory = $false, ValueFromPipeline = $false)]$DateTime
	)
	#TODO: Write the function.  Replaces Get-Now.
	# LogStandard = YYYYMMDD   get-date -uformat %Y%m%d
	# DateTime = YYYYMMDD_HHMMSS  (get-date -uformat %Y%m%d) + "_" + (get-date -uformat %H%M%S)
	
	begin {
		# Code to be executed once BEFORE the pipeline is processed goes here.
		
		# The function Get-mCurrentLine is used in ever script and function.
		if (Test-Path -Path function:\Get-mCurrentLine) { Write-Verbose "$(Get-Now)- $($MyInvocation.InvocationName) - Line $(Get-mCurrentLine) - Function Get-mCurrentLine is loaded in the session." }
		else { throw "$(Get-Now)- $($MyInvocation.InvocationName) - Line 52 or so - Function Get-mCurrentLine is not loaded in the session." }
		
		Write-Verbose "$(Get-Now)- $($MyInvocation.InvocationName) - Line $(Get-mCurrentLine) - Function started."
		
		# Test for required modules.  Internal support modules and vendor specific technology modules in addition to the builtin Microsoft PowerShell modules.  Remove this section if it's not needed.
		$ModuleList = "mPowerShellGenerics", "InsertAnotherModuleNameHere"
		$ModuleList | ForEach-Object {
			if (Test-mIsModuleLoaded -Name $_) { Write-Verbose "$(Get-Now)- $($MyInvocation.InvocationName) - Line $(Get-mCurrentLine) - Module $($_) is loaded in the session." }
			else { throw "$(Get-Now)- $($MyInvocation.InvocationName) - Line $(Get-mCurrentLine) - Module $($_) is not loaded in the session." }
		}
		
		# Test for required functions that aren't in required modules.  Remove this section if it's not needed.
		$FunctionList = "InsertAFunctionNameHere", "InsertAnotherFunctionNameHere"
		$FunctionList | ForEach-Object {
			if (Test-Path -Path function:\"$($_)") { Write-Verbose -Message "$(Get-Now)- $($MyInvocation.InvocationName) - Line $(Get-mCurrentLine) - Function $($_) is loaded in the session." }
			else { throw "$(Get-Now)- $($MyInvocation.InvocationName) - Line $(Get-mCurrentLine) - Function $($_) is not loaded in the session." }
		}
		
		# Only needed for VMware functions.  Otherwise remove it.
		if (-not (Test-mVCenterConnection)) { throw "$(Get-Now)- $($MyInvocation.InvocationName) - Line $(Get-mCurrentLine) - Not connected to a vCenter server." }
		
	} # end of the begin block
	
	process {
		# Code to be executed against every object in the pipeline goes here.
		Write-Verbose "$(Get-Now)- $($MyInvocation.InvocationName) - Line $(Get-mCurrentLine) - Process block start - param1 $($param1) - param2 $($param2) - param3 $($param3)"
		
		#TODO: Validate the parameters as needed.
		
		# Do the work
		
	} #end of the process block
	
	end {
		# Code to be executed once AFTER the pipeline is processed goes here.  Disconnect server connections, remove variables, reset the transcript file if necessary, and any other cleanup.
		
		# When testing comment out "-ErrorAction SilentlyContinue".  This will help find typos, unused variables, and other problems.
		Remove-Variable ModuleList, FunctionList, Param1, Param2, Param3 # -ErrorAction SilentlyContinue -WhatIf:$false # Using -WhatIf:$false to suppress unnecessary messages when a calling function has -Whatif:$true enabled.
		
		[System.GC]::Collect() # Memory cleanup
		
		Write-Verbose "$(Get-Now)- $($MyInvocation.InvocationName) - Line $(Get-mCurrentLine) - Function ended."
		
	} #end of the end block
	
} # end of the function

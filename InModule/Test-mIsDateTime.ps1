function Test-mIsDateTime {

	<#
    .SYNOPSIS
        Tests if the data passed is in a valid datetime format and returns true/false.

    .DESCRIPTION
        Uses Get-Date to test the format and try/catch to prevent a bad format from generating an exception in the console.

    .PARAMETER Date
        The date to be tested.

    .EXAMPLE
		PS> Test-mIsDateTime -Date "2020-3-4"
		True

	.EXAMPLE
		Visually looks OK but fails with Get-Date.

		PS> Test-mIsDateTime -Date "20200304"
		False

	.EXAMPLE
		This is legal with Get-Date but fails as a normal human date format.  The "0" (zero) is interpreted as the number of ticks after the start with system time.  On my current computer this is "Monday, January 1, 0001 12:00:00 AM".

		PS> Test-mIsDateTime -Date 0
		False

    .INPUTS
        System.String
		The date string to test.

    .OUTPUTS
        System.Boolean
		Returns $true if it is a valid datetime format, $false otherwise.

    .NOTES
		The $Date paramater data type is cast to a string so that Get-Date won't interpret an integer as legal format specifying the number of ticks past the earliest system time.
		Written to support the Move-mVMToDecomFolderAndUpdateNote function.

		Created by:   	Christopher Monahan
		Organization: 	companyname

	.LINK
		https://github.com/companyname-Platform-Services/mPowerShellGenerics/blob/main/InModule/Test-mIsDateTime.ps1

#>

	<# Comment History
	2026-02-25 cmonahan - Updated to match the standard function template using Google Antigravity editor and Gemini 3 Pro Low.
	#>

	[OutputType([System.Boolean])]
	[cmdletbinding(SupportsShouldProcess = $false)]
	param (
		[Parameter(Position = 0, Mandatory = $true, ValueFromPipeline = $false)]
		[System.String]$Date
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

		# Test for required modules.  Internal support modules and vendor specific technology modules in addition to the builtin Microsoft PowerShell modules.
		$ModuleList = "mPowerShellGenerics"
		$ModuleList | ForEach-Object {
			if (Test-mIsModuleLoaded -Name $_) { Write-Verbose -Message "$(Get-mNow)- $($MyInvocation.InvocationName) - Line $(Get-mCurrentLine) - Module $($_) is loaded in the session." }
			else { throw "$(Get-mNow)- $($MyInvocation.InvocationName) - Line $(Get-mCurrentLine) - Module $($_) is not loaded in the session." }
		}

		$EarliestSystemTime = Get-Date -Date 0   # This is a valid statement and returns the earliest system time. While not a valid date for most purposes it doesn't generate an exception and needs to be tested for separately.

		Write-Verbose -Message "$(Get-mNow)- $($MyInvocation.InvocationName) - Line $(Get-mCurrentLine) - Begin block end"

	} # end of the begin block

	process {
		# Code to be executed against every object in the pipeline goes here.

		Write-Verbose -Message "$(Get-mNow)- $($MyInvocation.InvocationName) - Line $(Get-mCurrentLine) - Process block start"

		$ReturnValue = $true # Setting the return value to true now and it will be changed to false if a test below fails.

		try {
			Write-Verbose -Message "$(Get-mNow)- $($MyInvocation.InvocationName) - Line $(Get-mCurrentLine) - try block"
			$d = Get-Date -Date $Date
		}
		catch [System.Management.Automation.ParameterBindingException] {
			Write-Verbose -Message "$(Get-mNow)- $($MyInvocation.InvocationName) - Line $(Get-mCurrentLine) - catch block for specific parameter binding exception"
			$ReturnValue = $false
		}
		catch {
			Write-Verbose -Message "$(Get-mNow)- $($MyInvocation.InvocationName) - Line $(Get-mCurrentLine) - catch block for non-specific exceptions"
			$ReturnValue = $false
			Write-Verbose -Message "$(Get-mNow)- $($MyInvocation.InvocationName) - Line $(Get-mCurrentLine) - An error occurred that could not be resolved: $($Error[0])"
		}

		# Write output to the pipeline
		$ReturnValue

		Write-Verbose -Message "$(Get-mNow)- $($MyInvocation.InvocationName) - Line $(Get-mCurrentLine) - Process block end"

	} #end of the process block

	end {
		# Code to be executed once AFTER the pipeline is processed goes here.  Disconnect server connections, remove variables, reset the transcript file if necessary, and any other cleanup.

		Write-Verbose -Message "$(Get-mNow)- $($MyInvocation.InvocationName) - Line $(Get-mCurrentLine) - End block start"

		# While testing, in the line below comment out "-ErrorAction SilentlyContinue"
		Remove-Variable -Name Date, EarliestSystemTime, d, ReturnValue, FunctionList, ModuleList -ErrorAction SilentlyContinue -WhatIf:$false # Using -WhatIf:$false to suppress unnecessary messages when a calling function has -Whatif:$true enabled.

		[System.GC]::Collect() # Memory cleanup
		$ErrorActionPreference = $EAPsaved

		Write-Verbose -Message "$(Get-mNow)- $($MyInvocation.InvocationName) - Line $(Get-mCurrentLine) - End block end"
		Write-Verbose -Message "$(Get-mNow)- $($MyInvocation.InvocationName) - Line $(Get-mCurrentLine) - Function ended - $($MyInvocation.InvocationName)"

	} #end of the end block

} # end of the function Test-mIsDateTime

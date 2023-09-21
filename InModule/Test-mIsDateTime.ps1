function Test-mIsDateTime {
	
<#
    .SYNOPSIS
        Tests if the data passed is in a valid datetime format and returns true/false.

    .DESCRIPTION
        Uses Get-Date to test the format and try/catch to prevent a bad format from generating an exception in the console.

    .PARAMETER  Date
        The date to be tested.

    .EXAMPLE
		A standard date format.
	
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

    .OUTPUTS
        Boolean

    .NOTES
        The $Date paramater data type is cast to a string so that Get-Date won't interpret an integer as legal format specifying the number of ticks past the earliest system time.
	
		Written to support the Move-mVMToDecomFolderAndUpdateNote 

		Original Author: Christopher Monahan, Monster Worldwide GTIS
		Contributors:	 name,org
	
	.LINK
		https://github.monster.com/OPS/mPowerShellGenerics/blob/master/Test-mIsDateTime.ps1
#>
	
	[OutputType([boolean])]
	
	[cmdletbinding(SupportsShouldProcess = $false)]
	param (
		[Parameter(Position = 0, Mandatory = $true, ValueFromPipeline = $false)][System.String]$Date
	)

	begin {
		# Code to be executed once BEFORE the pipeline is processed goes here.
		if (Test-Path -Path function:\Get-mCurrentLine) { Write-Verbose -Message "$(Get-Date)- $($MyInvocation.InvocationName) - Line $(Get-mCurrentLine) - Function Get-mCurrentLine is loaded in the session." }
		else { throw "$(Get-Date)- $($MyInvocation.InvocationName) - Line 44 or so - Function $($_) is not loaded in the session." }

		Write-Verbose -Message "$(Get-Date)- $($MyInvocation.InvocationName) - Line $(Get-mCurrentLine) - Function started."

		$EarliestSystemTime = Get-Date -Date 0   # This is a valid statement and returns the earliest system time.  While not a valid date for most purposes it doesn't generate an exception and needs to be tested for separately.

	} # end begin block

	process {
		# Code to be executed against every object in the pipeline goes here.
		
		$ReturnValue = $true # Setting the return value to true now and it will be changed to false if a test below fails.

		try {
			Write-Verbose -Message "$(Get-Date)- $($MyInvocation.InvocationName) - Line $(Get-mCurrentLine) - try block"
			$d = Get-Date -Date $Date
		}
		catch [System.Management.Automation.ParameterBindingException] {
			Write-Verbose -Message "$(Get-Date)- $($MyInvocation.InvocationName) - Line $(Get-mCurrentLine) - catch block for specific parameter binding exception"
			$ReturnValue = $false
		}
		catch {
			Write-Verbose -Message "$(Get-Date)- $($MyInvocation.InvocationName) - Line $(Get-mCurrentLine) - catch block for non-specific exceptions"
			$ReturnValue = $false
			Write-Verbose -Message "$(Get-Date)- $($MyInvocation.InvocationName) - Line $(Get-mCurrentLine) - An error occurred that could not be resolved: $($Error[0])"
		}
		
		return $ReturnValue

	} #end of the process block

	end {
		# Code to be executed once AFTER the pipeline is processed goes here.

		# While testing, in the line below comment out "-ErrorAction SilentlyContinue"
		Remove-Variable Date, EarliestSystemTime, d, ReturnValue -ErrorAction SilentlyContinue -WhatIf:$false # Using -WhatIf:$false to suppress unnecessary messages when a calling function has -Whatif:$true enabled.

		[System.GC]::Collect() # Memory cleanup

		Write-Verbose -Message "$(Get-Date)- $($MyInvocation.InvocationName) - Line $(Get-mCurrentLine) - Function ended."

	} #end of the end block

} # end of the function

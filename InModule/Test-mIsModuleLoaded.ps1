function Test-mIsModuleLoaded {
	
<#

.SYNOPSIS
    Tests the presence of a module to the current PowerShell session.
	
.DESCRIPTION
	Returns a boolean.

.PARAMETER Name
	The name of the module to test.
	
.EXAMPLE
    PS> Test-mIsModuleLoaded -Name mVMwarePowerCLI
	True

.OUTPUTS
    [boolean]

.NOTES
    Designed to be used with the conditional statements and cmdlets.  It does a 'return $true', so using it elsewhere will print '$true' to the console.

.LINK
    https://github.com/monster-next/mPowerShellGenerics/blob/main/Test-mIsModuleLoaded.ps1
	
#>
	
	[OutputType([boolean])]
		
	[cmdletbinding(SupportsShouldProcess = $false)]
	param (
		[Parameter(Position = 0, Mandatory = $true, ValueFromPipeline = $true)]$Name
	)
	
	begin {
		# Code to be executed once BEFORE the pipeline is processed goes here.
		
		# The function Get-mCurrentLine is used in ever script and function.
		if (Test-Path -Path function:\Get-mCurrentLine) { Write-Verbose "$(Get-mNow)- $($MyInvocation.InvocationName) - Line $(Get-mCurrentLine) - Function Get-mCurrentLine is loaded in the session." }
		else { throw "$(Get-mNow)- $($MyInvocation.InvocationName) - Line 60 or so - Function Get-mCurrentLine is not loaded in the session." }
		
		Write-Verbose "$(Get-mNow)- $($MyInvocation.InvocationName) - Line $(Get-mCurrentLine) - Function started."
		
		Write-Verbose "$(Get-mNow)- $($MyInvocation.InvocationName) Line $(Get-mCurrentLine) *** End of the Begin block"
	} # end begin block
	
	process {
		# start of the process block
		
		Write-Verbose "$(Get-mNow)- $($MyInvocation.InvocationName) Line $(Get-mCurrentLine) *** Start of the Process block"
		
		if (Get-Module -Name $Name) {
			#The module is loaded in the current session.
			Write-Verbose "$(Get-mNow)- $($MyInvocation.InvocationName) Line $(Get-mCurrentLine) *** Module $($Name) is loaded in this session."
			return $true
		} # end if module is loaded in the current session.
		else { # the module is NOT already loaded in the session		
			Write-Error "$(Get-mNow)- $($MyInvocation.InvocationName) Line $(Get-mCurrentLine) *** Module $($Name) is not loaded in this session."
				return $false
		} # end if the module was NOT already installed
		
		Write-Verbose "$(Get-mNow)- $($MyInvocation.InvocationName) Line $(Get-mCurrentLine) *** End of the Process block"
	} # end of the process block
	
	end {
		# start of the end block
		
		Write-Verbose "$(Get-mNow)- $($MyInvocation.InvocationName) Line $(Get-mCurrentLine) *** Start of the end block"
		
		Remove-Variable -Name Name -ErrorAction SilentlyContinue -WhatIf:$false # Using -WhatIf:$false to suppress unnecessary messages when a calling function has -Whatif:$true enabled.
		[System.GC]::Collect() # Memory cleanup
		
		Write-Verbose "$(Get-mNow)- $($MyInvocation.InvocationName) Line $(Get-mCurrentLine) *** End of the End block"
	} # end of the end block
	
} # end function

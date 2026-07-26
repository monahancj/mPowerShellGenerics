function Test-mModuleStatus {
	
	<#

.SYNOPSIS
    Tests if a module is installed and/or imported in the current PowerShell session.

.DESCRIPTION
	Returns a custom object with two properties, "Installed" and "Imported".  Each property will be set to $true or $false.

.PARAMETER Name
	The name of the module to test.
	
.EXAMPLE
    #TODO: A sample command that uses the function or script, optionally followed by sample output and a description. Repeat this keyword for each example.

.OUTPUTS
    [boolean]

.NOTES
    Additional information about the function or script.

.LINK
    https://github.com/monahancj/mPowerShellGenerics/tree/main/InDevelopment/Test-mModuleLoaded.ps1

#>
	
	#TODO: Somedaymaybe be able to specify a module version to load.
	
	[cmdletbinding(SupportsShouldProcess = $false)]
	param (
		[Parameter(Position = 0, Mandatory = $true, ValueFromPipeline = $true)]
		$Name
	)
	
	begin {
		# start of the begin block
		if (Get-Command -Name Get-mCurrentLine -ErrorAction SilentlyContinue) {
			Write-Verbose "$(Get-Date)- $($MyInvocation.InvocationName) Line $(Get-mCurrentLine) *** function Get-mCurrentLine is already loaded into the session."
		}
		else {
			# function Get-mCurrentLine is not already loaded into the session
			function Get-mCurrentLine {
				# Comment based help removed.  Not needed when the function's scope is completely within this function.
				$Myinvocation.ScriptlineNumber # Returns the code line number the function is called on .
			} # end function Get-mCurrentLine
		} # end ensure function 'Get-mCurrentLine' is available.
		
		Write-Verbose "$(Get-Date)- $($MyInvocation.InvocationName) Line $(Get-mCurrentLine) *** Start of the Begin block"
		
		$ModuleStatus = [pscustomobject]@{
			Installed = $null
			Imported  = $null
		}
		
		Write-Verbose "$(Get-Date)- $($MyInvocation.InvocationName) Line $(Get-mCurrentLine) *** End of the Begin block"
	} # end begin block
	
	process {
		# start of the process block
		
		Write-Verbose "$(Get-Date)- $($MyInvocation.InvocationName) Line $(Get-mCurrentLine) *** Start of the Process block"
		
		if (Get-Module -Name $Name) {
			Write-Verbose "$(Get-Date)- $($MyInvocation.InvocationName) Line $(Get-mCurrentLine) *** Module $($Name) is imported."
			$ModuleStatus.Installed = $true
			$ModuleStatus.Imported = $true
			return $ModuleStatus
		}
		elseif (Get-Module -Name $Name -ListAvailable) {
			Write-Verbose "$(Get-Date)- $($MyInvocation.InvocationName) Line $(Get-mCurrentLine) *** Module $($Name) is installed but not imported."
			$ModuleStatus.Installed = $true
			$ModuleStatus.Imported = $false
			return $ModuleStatus
		}
		else {
			Write-Verbose "$(Get-Date)- $($MyInvocation.InvocationName) Line $(Get-mCurrentLine) *** Module $($Name) is not installed."
			$ModuleStatus.Installed = $false
			$ModuleStatus.Imported = $false
			return $ModuleStatus
		}
		
		Write-Verbose "$(Get-Date)- $($MyInvocation.InvocationName) Line $(Get-mCurrentLine) *** End of the Process block"
	} # end of the process block
	
	end {
		# start of the end block
		
		Write-Verbose "$(Get-Date)- $($MyInvocation.InvocationName) Line $(Get-mCurrentLine) *** Start of the end block"
		
		Remove-Variable -Name Name -ErrorAction SilentlyContinue -WhatIf:$false # Using -WhatIf:$false to suppress unnecessary messages when a calling function has -Whatif:$true enabled.
		[System.GC]::Collect() # Memory cleanup
		
		Write-Verbose "$(Get-Date)- $($MyInvocation.InvocationName) Line $(Get-mCurrentLine) *** End of the End block"
	} # end of the end block
	
} # end function

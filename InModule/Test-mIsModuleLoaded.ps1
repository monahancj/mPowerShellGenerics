function Test-mIsModuleLoaded {

	<#
	.SYNOPSIS
		Tests the presence of a module in the current PowerShell session.

	.DESCRIPTION
		Returns a boolean indicating if a module is currently loaded.

	.PARAMETER Name
		The name of the module to test.

	.EXAMPLE
		PS> Test-mIsModuleLoaded -Name mVMwarePowerCLI
		True

	.INPUTS
		System.String
		The name of the module to test.

	.OUTPUTS
		System.Boolean
		Returns $true if the module is loaded, $false otherwise.

	.NOTES
		Designed to be used with the conditional statements and cmdlets.

		Created by:   	Christopher Monahan
		Organization: 	companyname

	.LINK
		https://github.com/companyname-Platform-Services/mPowerShellGenerics/blob/main/InModule/Test-mIsModuleLoaded.ps1
#>

	<# Comment History
	2026-02-25 cmonahan - Updated to match the standard function template using Google Antigravity editor and Gemini 3 Pro Low.
#>

	[OutputType([System.Boolean])]
	[cmdletbinding(SupportsShouldProcess = $false)]
	param (
		[Parameter(Position = 0, Mandatory = $true, ValueFromPipeline = $true)]
		[System.String]$Name
	)

	begin {
		# Code to be executed once BEFORE the pipeline is processed goes here.

		Write-Verbose -Message "$(Get-mNow)- $($MyInvocation.InvocationName) - Line $(Get-mCurrentLine) - Function started."

		Write-Verbose -Message "$(Get-mNow)- $($MyInvocation.InvocationName) - Line $(Get-mCurrentLine) - Begin block start"
		$EAPsaved = $ErrorActionPreference

		# Note: Omitting Get-mNow/Get-mCurrentLine checks since Test-mIsModuleLoaded might be called before those generic ones are guaranteed.
		# Omitting Test-mIsModuleLoaded check because that creates an infinite loop.

		Write-Verbose -Message "$(Get-mNow)- $($MyInvocation.InvocationName) - Line $(Get-mCurrentLine) - Begin block end"

	} # end begin block

	process {
		# Code to be executed against every object in the pipeline goes here.

		Write-Verbose -Message "$(Get-mNow)- $($MyInvocation.InvocationName) - Line $(Get-mCurrentLine) - Process block start"

		$result = $false

		# The core test: retrieve modules with exactly the requested name
		if (Get-Module -Name $Name) {
			Write-Verbose -Message "$(Get-mNow)- $($MyInvocation.InvocationName) - Line $(Get-mCurrentLine) - Module $($Name) is loaded in this session."
			$result = $true
		}
		else {
			Write-Error -Message "$(Get-mNow)- $($MyInvocation.InvocationName) - Line $(Get-mCurrentLine) - Module $($Name) is not loaded in this session."
		}

		# Output result to pipeline
		$result

		Write-Verbose -Message "$(Get-mNow)- $($MyInvocation.InvocationName) - Line $(Get-mCurrentLine) - Process block end"

	} # end of the process block

	end {
		# Code to be executed once AFTER the pipeline is processed goes here.

		Write-Verbose -Message "$(Get-mNow)- $($MyInvocation.InvocationName) - Line $(Get-mCurrentLine) - End block start"

		Remove-Variable -Name Name, result -ErrorAction SilentlyContinue -WhatIf:$false # Using -WhatIf:$false to suppress unnecessary messages when a calling function has -Whatif:$true enabled.

		[System.GC]::Collect() # Memory cleanup
		$ErrorActionPreference = $EAPsaved

		Write-Verbose -Message "$(Get-mNow)- $($MyInvocation.InvocationName) - Line $(Get-mCurrentLine) - End block end"
		Write-Verbose -Message "$(Get-mNow)- $($MyInvocation.InvocationName) - Line $(Get-mCurrentLine) - Function ended - $($MyInvocation.InvocationName)"

	} # end of the end block
} # end function

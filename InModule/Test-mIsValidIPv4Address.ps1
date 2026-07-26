function Test-mIsValidIPv4Address {
	<#
    .SYNOPSIS
        Tests if a string matches the IPv4 format and returns true or false.

    .DESCRIPTION
        Uses a regular expression to validate the format of an IPv4 address string.

    .PARAMETER IPv4Address
        The IPv4 address test.  It will be cast to type [System.String]

    .EXAMPLE
        PS> Test-mIsValidIPv4Address -IPv4Address 192.168.110.176
		True

    .EXAMPLE
		PS> "192.168.110.376" | Test-mIsValidIPv4Address
		False

    .INPUTS
        System.String
		The string to test as an IPv4 address.

    .OUTPUTS
        System.Boolean
		Returns $true if valid, otherwise $false.

    .NOTES
        Source article: https://powershell.one/code/1.html

		Created by:   	Christopher Monahan
		Organization: 	companyname

	.LINK
		https://github.com/companyname-Platform-Services/mPowerShellGenerics/blob/main/InModule/Test-mIsValidIPv4Address.ps1

#>

	<# Comment History
	2026-02-25 cmonahan - Updated to match the standard function template using Google Antigravity editor and Gemini 3 Pro Low.
#>

	[OutputType([System.Boolean])]
	[cmdletbinding(SupportsShouldProcess = $false)]
	param (
		[Parameter(Position = 0, Mandatory = $true, ValueFromPipeline = $true)]
		[System.String]$IPv4Address
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

		# Test for required functions that aren't in required modules.
		$FunctionList = "Test-mIsModuleLoaded", "Get-mCurrentLine", "Get-mNow"
		$FunctionList | ForEach-Object {
			if (Test-Path -Path function:\"$($_)") { Write-Verbose -Message "$(Get-mNow)- $($MyInvocation.InvocationName) - Line $(Get-mCurrentLine) - Function $($_) is loaded in the session." }
			else { throw "$(Get-mNow)- $($MyInvocation.InvocationName) - Line $(Get-mCurrentLine) - Function $($_) is not loaded in the session." }
		}

		# Test for required modules.
		$ModuleList = "mPowerShellGenerics"
		$ModuleList | ForEach-Object {
			if (Test-mIsModuleLoaded -Name $_) { Write-Verbose -Message "$(Get-mNow)- $($MyInvocation.InvocationName) - Line $(Get-mCurrentLine) - Module $($_) is loaded in the session." }
			else { throw "$(Get-mNow)- $($MyInvocation.InvocationName) - Line $(Get-mCurrentLine) - Module $($_) is not loaded in the session." }
		}

		$IPv4Pattern = '^((?:25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)\.){3}(?:25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)$'

		Write-Verbose -Message "$(Get-mNow)- $($MyInvocation.InvocationName) - Line $(Get-mCurrentLine) - Begin block end"

	} # end begin block

	process {
		# Code to be executed against every object in the pipeline goes here.

		Write-Verbose -Message "$(Get-mNow)- $($MyInvocation.InvocationName) - Line $(Get-mCurrentLine) - Process block start"

		if ($IPv4Address -match $IPv4Pattern) {
			Write-Verbose -Message "$(Get-mNow)- $($MyInvocation.InvocationName) - Line $(Get-mCurrentLine) - IPv4 Address is valid."
			$true
		}
		else {
			Write-Verbose -Message "$(Get-mNow)- $($MyInvocation.InvocationName) - Line $(Get-mCurrentLine) - IPv4 Address is NOT valid."
			$false
		}

		Write-Verbose -Message "$(Get-mNow)- $($MyInvocation.InvocationName) - Line $(Get-mCurrentLine) - Process block end"

	} #end of the process block

	end {
		# Code to be executed once AFTER the pipeline is processed goes here.  Disconnect server connections, remove variables, reset the transcript file if necessary, and any other cleanup.

		Write-Verbose -Message "$(Get-mNow)- $($MyInvocation.InvocationName) - Line $(Get-mCurrentLine) - End block start"

		Remove-Variable -Name IPv4Address, IPv4Pattern, FunctionList, ModuleList -ErrorAction SilentlyContinue -WhatIf:$false # Using -WhatIf:$false to suppress unnecessary messages when a calling function has -Whatif:$true enabled.

		[System.GC]::Collect() # Memory cleanup
		$ErrorActionPreference = $EAPsaved

		Write-Verbose -Message "$(Get-mNow)- $($MyInvocation.InvocationName) - Line $(Get-mCurrentLine) - End block end"
		Write-Verbose -Message "$(Get-mNow)- $($MyInvocation.InvocationName) - Line $(Get-mCurrentLine) - Function ended - $($MyInvocation.InvocationName)"

	} #end of the end block

} # end function

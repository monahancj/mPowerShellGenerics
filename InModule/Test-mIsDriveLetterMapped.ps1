Function Test-mIsDriveLetterMapped {
	<#
    .SYNOPSIS
        Tests if the drive letter supplied is mapped to a network share.

    .DESCRIPTION
        It is a simple test.  Using Get-PSDrive "\\" in the Root property.  A local drive will be in the usual "D:\" format.

    .PARAMETER DriveLetter
        The single letter representing the drive.  For example, "D" instead of "D:\"

    .EXAMPLE
		PS> Test-mIsDriveLetterMapped -DriveLetter d
		False

    .EXAMPLE
		PS> Test-mIsDriveLetterMapped -DriveLetter o
		True

	.EXAMPLE
		PS> Test-mIsDriveLetterMapped -DriveLetter "x" -verbose
		VERBOSE: 01/04/2019 14:27:39- *** DriveLetter not valid.
		False

    .INPUTS
        System.String

    .OUTPUTS
        System.Boolean

    .NOTES
		Created by:   	Christopher Monahan
		Organization: 	companyname

	.LINK
        https://github.com/companyname-Platform-Services/mPowerShellGenerics/blob/main/InModule/Test-mIsDriveLetterMapped.ps1

#>

	<# Comment History
	2026-02-25 cmonahan - Updated to match the standard function template using Google Antigravity editor and Gemini 3 Pro Low.
	2018-09-07 cmonahan - Initial creation.
#>

	[OutputType([System.Boolean])]
	[cmdletbinding(SupportsShouldProcess = $false)]
	param (
		[Parameter(Position = 0, Mandatory = $true, ValueFromPipeline = $true)]
		[System.String]$DriveLetter
	)

	<#TODO: Add code to test differently on different operating systems.
		- In all environments test with Get-PSDrive
		- In Windows test with "net use".
		- In MacOS test with ??
		- In Linux test with mount point?
	#>

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

		Write-Verbose -Message "$(Get-mNow)- $($MyInvocation.InvocationName) - Line $(Get-mCurrentLine) - Begin block end"

	} # end begin block

	process {
		# Code to be executed against every object in the pipeline goes here.
		Write-Verbose -Message "$(Get-mNow)- $($MyInvocation.InvocationName) - Line $(Get-mCurrentLine) - Process block start"

		$result = $false
		if ($DriveLetter.Length -eq 1) {
			if ($DriveLetter -match "[a-z]") {
				if (Get-PSDrive -Name $DriveLetter -ErrorAction SilentlyContinue) {
					if ((Get-PSDrive -Name $DriveLetter).Root -match "\\\\") {
						Write-Verbose -Message "$(Get-mNow)- $($MyInvocation.InvocationName) - Line $(Get-mCurrentLine) - *** DriveLetter is mapped."
						$result = $true
					}
					else {
						Write-Verbose -Message "$(Get-mNow)- $($MyInvocation.InvocationName) - Line $(Get-mCurrentLine) - *** Driveletter is local drive.  Not mapped."
					}
				} # end of drive exists block
				else {
					Write-Verbose -Message "$(Get-mNow)- $($MyInvocation.InvocationName) - Line $(Get-mCurrentLine) - *** DriveLetter not valid."
				} # end of drive letter mapped or not block
			}
			else {
				Write-Verbose -Message "$(Get-mNow)- $($MyInvocation.InvocationName) - Line $(Get-mCurrentLine) - *** DriveLetter needs to be a letter."
			} # end [a-z] test block
		}
		else {
			Write-Verbose -Message "$(Get-mNow)- $($MyInvocation.InvocationName) - Line $(Get-mCurrentLine) - *** DriveLetter needs to be a single character."
		} # end of length -eq 1 block

		# Output result to pipeline
		$result

		Write-Verbose -Message "$(Get-mNow)- $($MyInvocation.InvocationName) - Line $(Get-mCurrentLine) - Process block end"

	} #end of the process block

	end {
		# Code to be executed once AFTER the pipeline is processed goes here
		Write-Verbose -Message "$(Get-mNow)- $($MyInvocation.InvocationName) - Line $(Get-mCurrentLine) - End block start"

		# When testing comment out "-ErrorAction SilentlyContinue"
		Remove-Variable -Name DriveLetter, result, FunctionList, ModuleList -ErrorAction SilentlyContinue -WhatIf:$false # Using -WhatIf:$false to suppress unnecessary messages when a calling function has -Whatif:$true enabled.

		[System.GC]::Collect() # Memory cleanup
		$ErrorActionPreference = $EAPsaved

		Write-Verbose -Message "$(Get-mNow)- $($MyInvocation.InvocationName) - Line $(Get-mCurrentLine) - End block end"
		Write-Verbose -Message "$(Get-mNow)- $($MyInvocation.InvocationName) - Line $(Get-mCurrentLine) - Function ended - $($MyInvocation.InvocationName)"

	} #end of the end block

} # end function

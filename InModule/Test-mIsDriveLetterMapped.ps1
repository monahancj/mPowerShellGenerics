Function Test-mIsDriveLetterMapped
{
	<#
    .SYNOPSIS
        Tests if the drive letter supplied is mapped to a network share.

    .DESCRIPTION
        It is a simple test.  Using Get-PSDrive "\\" in the Root property.  A local drive will be in the usual "D:\" format.

    .PARAMETER  DriveLetter
        The single letter representing the drive.  For example, "D" instead of "D:\"

    .EXAMPLE
		PS O:\repos> Test-DriveLetterIsMapped -DriveLetter d
		False

    .EXAMPLE
		PS O:\repos> Test-DriveLetterIsMapped -DriveLetter o
		True

    .EXAMPLE
		PS O:\repos> Test-mDriveLetterIsMapped -DriveLetter "d"
		False

	.EXAMPLE
		PS O:\repos> Test-mDriveLetterIsMapped -DriveLetter "o"
		True

	.EXAMPLE
		PS O:\repos> Test-mDriveLetterIsMapped -DriveLetter "x" -verbose
		VERBOSE: 01/04/2019 14:27:39- *** DriveLetter not valid.
		False

    .INPUTS
        [System.String]

    .OUTPUTS
        [System.Boolean]

    .NOTES

		Created by:   	cmonahan
		Organization: 	Monster Worldwide, GTI

		Recent Comment History
		----------------------
		20180907 cmonahan- Initial creation.

	.LINK
        https://opsgit.monster.com/Ops/WindowsGeneral/blob/master/Functions/Test-DriveLetterIsMapped.ps1

#>

	[OutputType([System.Boolean])]
	[cmdletbinding()]
	param (
		[Parameter(Position = 0, Mandatory = $true, ValueFromPipeline = $true)]
		[System.String]$DriveLetter
	)
	
	#TODO: Move to module mPowerShellGenerics
	<#TODO: Add code to test differently on different operating systems.
		- In all environments test with Get-PSDrive
		- In Windows test with "net use".
		- In MacOS test with ??
		- In Linux test with mount point?
	#>
	
	begin # code to be executed once BEFORE the pipeline is processed goes here
	{

	} # end begin block

	process # code to be executed against every object in the pipeline goes here
	{
		if ($DriveLetter.Length -eq 1) {
			if ($DriveLetter -match "[a-z]") {
				if (Get-PSDrive -Name $DriveLetter -ErrorAction SilentlyContinue) {
					if ((Get-PSDrive -Name $DriveLetter).Root -match "\\\\") {
						Write-Verbose "$(Get-Date)- *** DriveLetter is mapped."
						return $true }
					else {
						Write-Verbose "$(Get-Date)- *** Driveletter is local drive.  Not mapped."
						return $false
 					}
				} # end of drive exists block
				else {
					Write-Verbose "$(Get-Date)- *** DriveLetter not valid."
					return $false
				} # end of drive letter mapped or not block
			}
			else {
				Write-Verbose "$(Get-Date)- *** DriveLetter needs to be a letter."
				return $false
			} # end [a-z] test block
		}
		else {
			Write-Verbose "$(Get-Date)- *** DriveLetter needs to be a single character."
			return $false
		} # end of length -eq 1 block

	} #end of the process block

	end # code to be executed once AFTER the pipeline is processed goes here
	{
		Remove-Variable DriveLetter -ErrorAction SilentlyContinue -WhatIf:$false # Using -WhatIf:$false to suppress unnecessary messages when a calling function has -Whatif:$true enabled.
		[System.GC]::Collect() # Memory cleanup

	} #end of the end block

} # end function

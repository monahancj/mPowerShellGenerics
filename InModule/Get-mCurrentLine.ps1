function Get-mCurrentLine {

	<#
    .SYNOPSIS
		Returns the current line number.

    .DESCRIPTION
		When called within a function or a script it will return the current
		line number of the file that contains the function or script.

    .EXAMPLE
        From within the shell.

		$> Get-CurrentLine
		1

	.EXAMPLE
		From line 27 of a function or script.

		Write-Verbose "Line number: $(Get-CurrentLine)"
		Line number: 27

    .NOTES
		I forget where and who I copied the base idea from.  My apologies to whomever it is.

		Created by:   	cmonahan
		Organization: 	companyname

	.LINK
		https://github.com/companyname-Platform-Services/mPowerShellGenerics/blob/main/InModule/Get-mCurrentLine.ps1

#>
	<# Comment History
	2026-02-25 cmonahan - Updated to match the standard function template using Google Antigravity editor and Gemini 3 Pro Low.
	2017-06-08 cmonahan - Finally put it into a file and module.
#>

	[cmdletbinding()]
	param ()

	begin {
		# Code to be executed once BEFORE the pipeline is processed goes here.

		# Note: This primitive function omits standard Get-mNow and Get-mCurrentLine.
		# verbose logging constraints and module checks to prevent circular dependencies.

		$EAPsaved = $ErrorActionPreference

	} # end of the begin block

	process {
		# Code to be executed against every object in the pipeline goes here.

		$Myinvocation.ScriptlineNumber

	} #end of the process block

	end {
		# Code to be executed once AFTER the pipeline is processed goes here.  Disconnect server connections, remove variables, reset the transcript file if necessary, and any other cleanup.

		$ErrorActionPreference = $EAPsaved

	} #end of the end block

} # end of the function Get-mCurrentLine

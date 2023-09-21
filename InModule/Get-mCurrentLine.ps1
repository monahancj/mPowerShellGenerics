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
		Organization: 	Monster Worldwide, GTI

		Recent Comment History
		----------------------
		20170608 cmonahan - Finally put it into a file and module.

	.LINK
		https://github.com/monster-next/mPowerShellGenerics/blob/main/Get-mCurrentLine.ps1

#>	
	$Myinvocation.ScriptlineNumber
	
<# Comment History
 20170608 cmonahan - Finally put it into a file and module.
#>
	
} # end function
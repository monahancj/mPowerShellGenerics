function Get-mNow {
	<#
    .SYNOPSIS
        Returns and ISO 8601 standard machine friendly string formatted date/time with UTC offset.

    .DESCRIPTION
        Useful for logging.

    .EXAMPLE
        Get-mNow
		2022-06-28T16:24:53-04:00

    .OUTPUTS
		System.String

	.LINK
		https://github.com/companyname-Platform-Services/mPowerShellGenerics/blob/main/InModule/Get-mNow.ps1

	.NOTES
        It's been floating around in various scripts/programs for years as needed as a one line function declaration and never changed.  Finally put it into a file and module.

		Created by:   	cmonahan
		Organization: 	companyname

		Recent Comment History
		----------------------
		2022-06-28 cmonahan - Renamed from Get-Now to Get-mNow to match the function naming convention.  Also update output format to the ISO 8601 standard- https://en.wikipedia.org/wiki/ISO_8601 .  Minor updates to the help.
		2017-06-02 cmonahan - Finally put it into a file and module.

#>

	(Get-Date -uformat %Y-%m-%d) + "T" + (Get-Date -uformat %H:%M:%S%Z) + ":00"

} # end function

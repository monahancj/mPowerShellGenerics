function Get-mRecordFromArray {

<#
    .SYNOPSIS
        A brief description of the function or script. This keyword can be used
        only once in each topic.

    .DESCRIPTION
        A detailed description of the function or script. This keyword can be
        used only once in each topic.

    .PARAMETER  <Parameter-Name>
        The description of a parameter. Add a .PARAMETER keyword for
        each parameter in the function or script syntax.

    .EXAMPLE
        Get-mRecordFromArray -SearchData $pinv -SearchColumn "Serial Number" -SearchItems $data -ResultsColumn "Serial Number"

    .INPUTS
        The Microsoft .NET Framework types of objects that can be piped to the
        function or script. You can also include a description of the input
        objects.

    .OUTPUTS
        The .NET Framework type of the objects that the cmdlet returns. You can
        also include a description of the returned objects.

    .NOTES
        Additional information about the function or script.

		Created by:   	cmonahan
		Organization: 	Monster Worldwide, GTI

		Recent Comment History
		----------------------
		YYYMMDD username- 3rd comment.
		YYYMMDD username- 2nd comment.
		20161205 cmonahan- Initial release.

	.LINK
        The name of a related topic. The value appears on the line below
        the .LINK keyword and must be preceded by a comment symbol (#) or
        included in the comment block.

        Repeat the .LINK keyword for each related topic.

        This content appears in the Related Links section of the help topic.

        The Link keyword content can also include a Uniform Resource Identifier
        (URI) to an online version of the same help topic. The online version
        opens when you use the Online parameter of Get-Help. The URI must begin
        with "http" or "https".

#>

	#ToDo: Fill out comment based help

	[cmdletbinding(SupportsShouldProcess = $true)]
	param (
		[Parameter(Position = 0, Mandatory = $true, ValueFromPipeline = $false)]
		$SearchData,
		[Parameter(Position = 1, Mandatory = $true, ValueFromPipeline = $false)]
		$SearchColumn,
		[Parameter(Position = 2, Mandatory = $true, ValueFromPipeline = $false)]
		$SearchItem,
		[Parameter(Position = 3, Mandatory = $true, ValueFromPipeline = $false)]
		$ResultsColumn
	)

	begin {

		# code to be executed once BEFORE the pipeline is processed goes here

	} # end begin block

	process {

		#foreach ($Record in ($SearchItem)) { if ($SearchData.$SearchColumn.Contains($Record)) { $SearchData | Where-Object { $_.$SearchColumn -eq $Record } } }
		if ($SearchData.$SearchColumn.Contains($SearchItem)) { ($SearchData | Where-Object { $_.$SearchColumn -eq $SearchItem }).$ResultsColumn }

	} #end of the process block

	end {
		# code to be executed once AFTER the pipeline is processed goes here
		
		Remove-Variable SearchData, SearchColumn, SearchItem, ResultsColumn -ErrorAction SilentlyContinue -WhatIf:$false # Using -WhatIf:$false to suppress unnecessary messages when a calling function has -Whatif:$true enabled.
		[System.GC]::Collect() # Memory cleanup

	} #end of the end block

#>

} # end function

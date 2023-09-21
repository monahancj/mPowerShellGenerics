function Get-mSynopsis {
<#
    .SYNOPSIS
        Returns a briefer version of a function's command line help section .SYNOPSIS.  Just the 1 or 2 lines of text after the synopsis keyword.

    .DESCRIPTION
        See the synopsis.

    .PARAMETER  File

    .EXAMPLE
        $> gci .\*.ps1 -recurse | select name,@{n='Synopsis';e={Get-Synopsis -File $_}} | ft -a

		Name                                     Synopsis
		----                                     --------
		New-mUcsBlade.ps1                        A brief description of the function or script. This keyword can be used only once in each topic.
		Get-Synopsis.ps1                         Returns the line of text after the f
		PurgeFilesUsingCSV.ps1                   A brief description of the function or script. This keyword can be used only once in each topic.
		Remove-OldFiles.ps1
		VMScriptHost_DataReplication.ps1         A brief description of the function or script. This keyword can be used only once in each topic.
		Get-mClusterResourceUsage.ps1            A brief description of the function or script. This keyword can be used only once in each topic.
		Wait-mTaskvMotions.ps1                   Will enter a wait/loop if there are running vMotion or svMotion tasks. .DESCRIPTION
		alarms.ps1
		Deploy_Template_fromCSV.ps1              Mass cloning of virtual machines .DESCRIPTION

    .EXAMPLE
		For Markdown table format.  This does not make the table headers.  I use this to update a module's readme.md file.
	
		$> gc .\__ModuleBuildFiles\mVMwarePowerCLI_FileList.txt | % { "|$((gci $_).BaseName)|$(Get-mSynopsis -File $_)|" }

		PS> gc .\__ModuleBuildFiles\mVMwarePowerCLI_FileList.txt | % { "|$((gci $_).BaseName)|$(Get-mSynopsis -File $_)|" }

		|Get-mClusterResourceUsage|Reports on various cluster statistics.|
		|Test-mClusterIsPresent|Tests if a host cluster exist in the currently connected vCenter(s).  Returns true or false.|
		|Wait-mTaskvMotion|Will enter a wait/loop if there are running vMotion or svMotion tasks. |
		|Get-mClusterGeneric|Will find a host or datastore cluster matching the provided cluster name.        |
		|Get-mDatastoreFromCanonical|<A brief description of the script> .DESCRIPTION|
		|Get-mDataStoreInfo|<A brief description of the script> .DESCRIPTION|
		|Get-mDataStoreList|Returns a list of valid datastores in the cluster. |

	.INPUTS
        System.IO.FileInfo
		A file object

    .OUTPUTS
        Selected.System.IO.FileInfo
        The file name and synopsis text if it's there.

    .NOTES
        I use this to generate a one page list of the functions/scripts in my internal module, or a directory, for use on our wiki, and to make a table listing for a module's readme.md file.
	
		This is also a useful spot check for functions that don't have their comment based help updated.
		Example: The help template is there but not filled out.

			|Get-mDatastoreFromCanonical|<A brief description of the script> .DESCRIPTION|

		Example: This runaway error means the .SYNOPSIS text is on the same line as ".SYNOPSIS" or that ".SYNOPSIS" isn't all uppercase.  Hit CTRL-C quickly.  :)
	
			OperationStopped: C:\Users\cmonahan\OneDrive - Monster_AD\repos\mPowerShellGenerics\Get-mSynopsis.ps1:64
			Line |
			  64 |          if ($lines[$i] -clike '*.SYNOPSIS')
			     |              ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
			     | Index was outside the bounds of the array.
	
		Recent Comment History
		----------------------
		2022-06-28 cmonahan - Renamed from Get-Synopsis to Get-mSynopsis to match the function naming convention.

    .LINK
        https://github.monster.com/OPS/mPowerShellGenerics

#>
	
	#ToDo: Change input to be a string.  Will allow input from a file with Get-Content or from Get-Help output.
	#TODO: Update comment based help.
	#TODO: Update to match PowerShell function template.
	#TODO: Update all output to the standard format using the snippet "OutputMessage".
	
	param ($File)

	$found = $false
	$i = 0
	$lines = Get-Content $File
	while ((!$found) -and ($i -le $lines.Count))
	{
		if ($lines[$i] -clike '*.SYNOPSIS')
		{
			$found = $true
			if ($lines[$i + 2] -eq "")
			{
				Write-Output ($lines[$i + 1]).TrimStart()
			}
			else
			{
				Write-Output -InputObject (($lines[$i + 1]).TrimStart() + " " + ($lines[$i + 2]).TrimStart())
			}
		}
		else
		{
			$i++ # move to the next line
		}
	}
}

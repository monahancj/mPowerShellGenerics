function Get-mSynopsis {

	<#
    .SYNOPSIS
        Returns a briefer version of a function's command line help section .SYNOPSIS.  Just the 1 or 2 lines of text after the synopsis keyword.

    .DESCRIPTION
        See the synopsis.

    .PARAMETER File
		A file object or path to extract the synopsis from.

    .EXAMPLE
		PS> Get-mSynopsis -File .\New-mUcsBlade.ps1
		Provisions a new blade.

	.EXAMPLE
    $> gci .\*.ps1 -recurse | select name,@{n='Synopsis';e={Get-mSynopsis -File $_}} | ft -a

	Name                                     Synopsis
	----                                     --------
	New-mUcsBlade.ps1                        A brief description of the function or script. This keyword can be used only once in each topic.
	Get-mSynopsis.ps1                         Returns the line of text after the f
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
		Example: This runaway error means the .SYNOPSIS text is on the same line as ".SYNOPSIS" or that ".SYNOPSIS" isn't all uppercase.  Hit CTRL-C quickly.  :)
		OperationStopped: C:\repos\mPowerShellGenerics\Get-mSynopsis.ps1:64
		Line |
		  64 |          if ($lines[$i] -clike '*.SYNOPSIS')
		     |              ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
		     | Index was outside the bounds of the array.

    .LINK
        https://github.com/companyname-Platform-Services/mPowerShellGenerics/blob/main/InModule/Get-mSynopsis.ps1

#>

	<# Comment History
	2026-02-25 cmonahan - Updated to match the standard function template using Google Antigravity editor and Gemini 3 Pro Low.
	2022-06-28 cmonahan - Renamed from Get-Synopsis to Get-mSynopsis to match the function naming convention.
#>

	#TODO: Change input to be a string.  Will allow input from a file with Get-Content or from Get-Help output.
	#TODO: Update all output to the standard format using the snippet "OutputMessage".

	[cmdletbinding(SupportsShouldProcess = $false)]
	param (
		[Parameter(Position = 0, Mandatory = $true, ValueFromPipeline = $true)]
		$File
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

		# Test for required functions that aren't in required modules.  Remove this section if it's not needed.
		$FunctionList = "Test-mIsModuleLoaded", "Get-mCurrentLine", "Get-mNow"
		$FunctionList | ForEach-Object {
			if (Test-Path -Path function:\"$($_)") { Write-Verbose -Message "$(Get-mNow)- $($MyInvocation.InvocationName) - Line $(Get-mCurrentLine) - Function $($_) is loaded in the session." }
			else { throw "$(Get-mNow)- $($MyInvocation.InvocationName) - Line $(Get-mCurrentLine) - Function $($_) is not loaded in the session." }
		}

		# Test for required modules.  Internal support modules and vendor specific technology modules in addition to the builtin Microsoft PowerShell modules.  Remove this section if it's not needed.
		$ModuleList = "mPowerShellGenerics"
		$ModuleList | ForEach-Object {
			if (Test-mIsModuleLoaded -Name $_) { Write-Verbose -Message "$(Get-mNow)- $($MyInvocation.InvocationName) - Line $(Get-mCurrentLine) - Module $($_) is loaded in the session." }
			else { throw "$(Get-mNow)- $($MyInvocation.InvocationName) - Line $(Get-mCurrentLine) - Module $($_) is not loaded in the session." }
		}

		Write-Verbose -Message "$(Get-mNow)- $($MyInvocation.InvocationName) - Line $(Get-mCurrentLine) - Begin block end"

	} # end of the begin block

	process {
		# Code to be executed against every object in the pipeline goes here.

		Write-Verbose -Message "$(Get-mNow)- $($MyInvocation.InvocationName) - Line $(Get-mCurrentLine) - Process block start"

		$found = $false
		$i = 0
		$lines = @(Get-Content $File)
		while ((!$found) -and ($i -lt $lines.Count)) {
			if ($lines[$i] -clike '*.SYNOPSIS') {
				$found = $true
				if (($i + 1) -lt $lines.Count) {
					if ((($i + 2) -lt $lines.Count) -and ($lines[$i + 2] -eq "")) {
						Write-Output ($lines[$i + 1]).TrimStart()
					}
					elseif ((($i + 2) -lt $lines.Count) -and ($lines[$i + 2] -ne "")) {
						Write-Output -InputObject (($lines[$i + 1]).TrimStart() + " " + ($lines[$i + 2]).TrimStart())
					}
					else {
						Write-Output ($lines[$i + 1]).TrimStart()
					}
				}
			}
			else {
				$i++ # move to the next line
			}
		}

		Write-Verbose -Message "$(Get-mNow)- $($MyInvocation.InvocationName) - Line $(Get-mCurrentLine) - Process block end"

	} #end of the process block

	end {
		# Code to be executed once AFTER the pipeline is processed goes here.  Disconnect server connections, remove variables, reset the transcript file if necessary, and any other cleanup.

		Write-Verbose -Message "$(Get-mNow)- $($MyInvocation.InvocationName) - Line $(Get-mCurrentLine) - End block start"

		Remove-Variable -Name File, found, i, lines, ModuleList, FunctionList -ErrorAction SilentlyContinue -WhatIf:$false # Using -WhatIf:$false to suppress unnecessary messages when a calling function has -Whatif:$true enabled.

		[System.GC]::Collect() # Memory cleanup
		$ErrorActionPreference = $EAPsaved

		Write-Verbose -Message "$(Get-mNow)- $($MyInvocation.InvocationName) - Line $(Get-mCurrentLine) - End block end"
		Write-Verbose -Message "$(Get-mNow)- $($MyInvocation.InvocationName) - Line $(Get-mCurrentLine) - Function ended - $($MyInvocation.InvocationName)"

	} #end of the end block
} # end of the function Get-mSynopsis

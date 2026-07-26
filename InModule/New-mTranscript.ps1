function New-mTranscript {

	<#
    .SYNOPSIS
        A wrapper around Start-Transcript with a default path to the "My Documents" folder and an automatic date/time stamp on the transcript file.

    .DESCRIPTION
        Creates a session transcript in the path specified using a standard file name.  Default is to append if the transcript file already exists (-Append) and include the timestamp each command was run (-IncludeInvocationHeader).

    .PARAMETER ScriptName
		The name of the script to create a transcript for.  Recommend using $MyInvocation.MyCommand.Name from the calling script.

	.PARAMETER Directory
        The path to the transcript files.

    .PARAMETER Force
        If the path of the Directory parameter doesn't exist then attempt to create the directory.  Otherwise exit.

    .EXAMPLE
        New-mTranscript -ScriptName "MyScript.ps1"

    .INPUTS
        None

    .OUTPUTS
        System.String
        The path to the newly created transcript file.

    .NOTES
        For server wide logging of any PowerShell session add this to the "All Users, All Hosts" profile.  See:
			https://docs.microsoft.com/en-us/powershell/module/microsoft.powershell.core/about/about_profiles?view=powershell-5.1 .

		Use $TranscriptPath = (New-mTranscript) to store the path to the transcript file.

		Created by:   	Christopher Monahan
		Organization: 	companyname

	.LINK
		https://github.com/companyname-Platform-Services/mPowerShellGenerics/blob/main/InModule/New-mTranscript.ps1

#>

	<# Comment History
	2026-02-25 cmonahan - Updated to match the standard function template using Google Antigravity editor and Gemini 3 Pro Low.
#>

	[OutputType([System.String])]
	[cmdletbinding(SupportsShouldProcess = $false)]
	param (
		[Parameter(Position = 0, Mandatory = $false, ValueFromPipeline = $false)]
		[string]$ScriptName = "",

		[Parameter(Position = 1, Mandatory = $false, ValueFromPipeline = $false)]
		[string]$Directory = "$($Env:OneDrive)\Logs\Transcripts",

		[Parameter(Position = 2, Mandatory = $false, ValueFromPipeline = $false)]
		[switch]$Force
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

		Write-Verbose -Message "$(Get-mNow)- $($MyInvocation.InvocationName) - Line $(Get-mCurrentLine) - Begin block end"

	} # end of the begin block

	process {
		# Code to be executed against every object in the pipeline goes here.

		Write-Verbose -Message "$(Get-mNow)- $($MyInvocation.InvocationName) - Line $(Get-mCurrentLine) - Process block start"

		#TODO: Make variable names accurate.
		$logname = Get-Date -Format "yyyy-MM-dd"
		$uname = (Get-Item env:USERNAME).Value
		if ($ScriptName -ne "") { $ScriptName = ($ScriptName -split ("\."))[0] }
		else { $ScriptName = "CommandLine_$(Get-Random -Minimum 100000 -Maximum 999999)" } # Append a 6 digit random number to the script name.

		$Directory = $Directory.Trim()
		$Directory = $Directory.TrimEnd('\')

		if (-not (Test-Path $Directory) -and ($Force)) { New-Item -ItemType Directory -Path $Directory | Out-Null }
		if (-not (Test-Path $Directory)) {
			if (Test-Path D:\) {
				$Directory = 'D:\Logs\Transcripts'
				if (-not (Test-Path $Directory)) { New-Item -ItemType Directory -Path $Directory | Out-Null }
			}
			elseif (Test-Path C:\) {
				$Directory = 'C:\Logs\Transcripts'
				if (-not (Test-Path $Directory)) { New-Item -ItemType Directory -Path $Directory | Out-Null }
			}
		}

		if (Test-Path $Directory) {
			# Build the transcript file path
			$TranscriptPath = $Directory + '\' + $logname + "_" + $env:COMPUTERNAME + "_" + $uname + "_" + $ScriptName + "_pid" + [string]$PID + ".log"
			Start-Transcript -Path $TranscriptPath -IncludeInvocationHeader -Append -Force > $null
			# Return the path
			$TranscriptPath
		}
		else {
			throw "$(Get-mNow)- $($MyInvocation.InvocationName) - Line $(Get-mCurrentLine) *** Unable to find or create the transcript directory.  Aborting."
		}

		Write-Verbose -Message "$(Get-mNow)- $($MyInvocation.InvocationName) - Line $(Get-mCurrentLine) - Process block end"

	} #end of the process block

	end {
		# Code to be executed once AFTER the pipeline is processed goes here.  Disconnect server connections, remove variables, reset the transcript file if necessary, and any other cleanup.

		Write-Verbose -Message "$(Get-mNow)- $($MyInvocation.InvocationName) - Line $(Get-mCurrentLine) - End block start"

		Remove-Variable -Name ScriptName, Directory, Force, FunctionList, ModuleList, logname, uname, TranscriptPath -ErrorAction SilentlyContinue -WhatIf:$false # Using -WhatIf:$false to suppress unnecessary messages when a calling function has -Whatif:$true enabled.

		[System.GC]::Collect() # Memory cleanup
		$ErrorActionPreference = $EAPsaved

		Write-Verbose -Message "$(Get-mNow)- $($MyInvocation.InvocationName) - Line $(Get-mCurrentLine) - End block end"
		Write-Verbose -Message "$(Get-mNow)- $($MyInvocation.InvocationName) - Line $(Get-mCurrentLine) - Function ended - $($MyInvocation.InvocationName)"

	} #end of the end block

} # end of the function New-mTranscript

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
        A sample command that uses the function or script, optionally followed
        by sample output and a description. Repeat this keyword for each example.

    .INPUTS
        The Microsoft .NET Framework types of objects that can be piped to the
        function or script. You can also include a description of the input
        objects.

    .OUTPUTS
        The .NET Framework type of the objects that the cmdlet returns. You can
        also include a description of the returned objects.

    .NOTES
        For server wide logging of any PowerShell session add this to the "All Users, All Hosts" profile.  See:
			https://docs.microsoft.com/en-us/powershell/module/microsoft.powershell.core/about/about_profiles?view=powershell-5.1 .

		Use $TranscriptPath = (New-mTranscript) to store the path to the transcript file.

		Deliberately decided not to use the begin/process/end blocks.  I didn't see any scenario where this should be used in a pipeline.

		Created by:   	Christopher Monahan
		Organization: 	Monster Worldwide, GTI
#>

	[cmdletbinding()]
	param (
		[Parameter(Position = 0, Mandatory = $false, ValueFromPipeline = $false)]
		$ScriptName = "",
		[Parameter(Position = 1, Mandatory = $false, ValueFromPipeline = $false)]
		$Directory = "$($Env:OneDrive)\Logs\Transcripts"
	)

	#TODO: Replacing this cmdlet name with Start-mTranscript.  "Start" was the appropriate verb, which I should have realized because the cmdlet this is a wrapper for is "Start-Transcript".  Adding Suspend-mTranscript, Resume-mTranscript, and Stop-mTranscript.
	#TODO: Add Write-Verbose lines
	#TODO: Handle pausing and restarting an already running transcript
	#TODO: Add required module logic
	#TODO: Add calling function/cmdlet/executable name to the transcript file name if it exists.  Useful for scheduled tasks.

	Import-Module -Name Microsoft.PowerShell.Host

	Write-Verbose "$(Get-Date)- $($MyInvocation.MyCommand.Name) Line $(Get-mCurrentLine) *** Start of the function"

	#TODO: Make variable names accurate.
	$logname = Get-Date -Format "yyyy-MM-dd"
	$uname = (get-item env:USERNAME).Value
	if ($ScriptName -ne "") { $ScriptName = ($ScriptName -split ("\."))[0] }
	else { $ScriptName = "CommandLine_$(Get-Random -Minimum 100000 -Maximum 999999)" } # Append a 6 digit random number to the script name.  Accounts for when multiple sessions are open on one computer so $MyInvocation.MyCommand.Name will be empty.

	$Directory = $Directory.Trim()
	$Directory = $Directory.TrimEnd('\')

	#TODO: Test if D: exists (preferred location), and if it doesn't exist put the directory on the C: drive.
	if (-not (Test-Path $Directory) -and ($Force)) { mkdir $Directory }
	if (-not (Test-Path $Directory)) {
		if (Test-Path D:\) {
			$Directory = 'D:\Logs\Transcripts'
			if (-not (Test-Path $Directory)) { mkdir $Directory }
		}
		elseif (Test-Path C:\) {
			$Directory = 'C:\Logs\Transcripts'
			if (-not (Test-Path $Directory)) { mkdir $Directory }
		}
	}
	if (Test-Path $Directory) {
		# Build the transcript file path
		$TranscriptPath = $Directory + '\' + $logname + "_" + $env:COMPUTERNAME + "_" + $uname + "_" + $ScriptName + "_pid" + [string]$PID + ".log"
		Start-Transcript -Path $TranscriptPath -IncludeInvocationHeader -Append -Force
	}
	else {
		#TODO: Replace with throw.
		Write-Error "$(Get-Date)- $($MyInvocation.MyCommand.Name) Line $(Get-mCurrentLine) *** Unable to find or create the transcript directory.  Aborting."
		break
	}

	# ===============================================
	# Clean up
	Remove-Variable -Name Path, Force -ErrorAction SilentlyContinue -WhatIf:$false # Using -WhatIf:$false to suppress unnecessary messages when a calling function has -Whatif:$true enabled.
	[System.GC]::Collect() # Memory cleanup

	Write-Verbose "$(Get-Date)- $($MyInvocation.MyCommand.Name) Line $(Get-mCurrentLine) *** End of the function"

	# Return the path to the transcript file
	$TranscriptPath
} # end function

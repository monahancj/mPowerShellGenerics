function Connect-mSSHSession {
	
<#
    .SYNOPSIS
        A wrapper around PowerShell's OpenSSH client.

    .DESCRIPTION
        Creates a session with a log file created by default.  Default is to append if the transcript file already exists (-Append) and include the timestamp each command was run (-IncludeInvocationHeader).

    .PARAMETER Host
	
	.PARAMETER Username
	
	.PARAMETER LogDirectory
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

		Created by:   	YOUR NAME HERE
		Organization: 	companyname
#>
	
	[cmdletbinding()]
	param (
		[Parameter(Position = 0, Mandatory = $false, ValueFromPipeline = $false)]$UserName,
		[Parameter(Position = 0, Mandatory = $true,  ValueFromPipeline = $false)]$Host
		#[Parameter(Position = 0, Mandatory = $false, ValueFromPipeline = $false)]$Directory = 'D:\Ops\Logs\SSHSessionTranscripts'
		
	)
	#TODO: Add Write-Verbose lines
	
	begin {
		
		Write-Verbose "$(Get-Date)- $($MyInvocation.InvocationName) Line $(Get-mCurrentLine) *** Start of the Begin block"
		
		if (-not (Get-Alias -Name mssh)) { New-Alias -Name mssh -Value Start-mSSHSession }
				
		Write-Verbose "$(Get-Date)- $($MyInvocation.InvocationName) Line $(Get-mCurrentLine) *** End of the Begin block"
		
	} # end begin block
	
	process {
		Write-Verbose "$(Get-Date)- $($MyInvocation.InvocationName) Line $(Get-mCurrentLine) *** Start of the Process block"
		
<#
		$LogFileName = Get-Date -Format "yyyy-MM-dd"
		$UsernamePowerShell = (get-item env:USERNAME).Value
		
		$Directory = $Directory.Trim()
		$Directory = $Directory.TrimEnd('\')
		
		# Test if D: exists (preferred location), and if it doesn't exist put the directory on the C: drive.  If putting it on the C: drive fails then exit.  Something's whacked.
		if (-not (Test-Path $Directory)) { mkdir $Directory }
		if (-not (Test-Path $Directory)) {
			$Directory = 'C:\Ops\Logs\SSHSessionTranscripts'
			mkdir $Directory }
		else {
			#TODO: Replace with throw.
			Write-Error "$(Get-Date)- $($MyInvocation.InvocationName) Line $(Get-CurrentLine) *** Log directory \Ops\Logs\SSHSessionTranscripts could not be created on the D: or C: drives.  Aborting."
			break
		}
		
		# Build the log file path.
		$LogFilePath = $Directory + '\' + $LogFileName + "_" + $env:COMPUTERNAME + "_" + $UsernamePowerShell + "_pid" + [string]$PID + ".log"
		Write-Verbose "$(Get-Date)- $($MyInvocation.InvocationName) Line $(Get-mCurrentLine) *** $($LogFilePath)"
#>		
		#TODO: Finish writing this.
		ssh -
		
		Write-Verbose "$(Get-Date)- $($MyInvocation.InvocationName) Line $(Get-mCurrentLine) *** End of the Process block"
		
	} #end of the process block
	
	end {
		Write-Verbose "$(Get-Date)- $($MyInvocation.InvocationName) Line $(Get-mCurrentLine) *** Start of the end block"
		
		Remove-Variable Username, Host, Directory, LogFileName, UsernamePowerShell, LogFilePath -ErrorAction SilentlyContinue -WhatIf:$false # Using -WhatIf:$false to suppress unnecessary messages when a calling function has -Whatif:$true enabled.
		[System.GC]::Collect() # Memory cleanup
		
		Write-Verbose "$(Get-Date)- $($MyInvocation.InvocationName) Line $(Get-mCurrentLine) *** End of the End block"
		
	} #end of the end block
	
} # end function


class cmdletNoun_Properties {
	#TODO: Determine if defining a class is needed.
	# Class to define a custom output type.  Remove if not needed.  Name the class using the function's noun with "cmdletNoun_Properties" appended.  The function "Get-Stuff" would have the class name "Stuff_Properties".  This is also used for the PSCustomObject name.
	[string]$OutputProperty1
	[int]$OutputProperty2
}

function Update-mNugetModule {
	
<#
    .SYNOPSIS
        Update one, multiple, or all installed PowerShell module(s) from the available Nuget repository(ies) with a newer version and uninstall the old version(s).

    .DESCRIPTION
        Defaults to updating with the latest avaialable version.  Can specify a version to update to.

    .PARAMETER  Name
        The

    .EXAMPLE
        A sample command that uses the function or script, optionally followed

    .INPUTS
        The Microsoft .NET Framework types of objects that can be piped to the

    .OUTPUTS
        The .NET Framework type of the objects that the cmdlet returns. You can

    .NOTES
        Use 'Get-PSRepository' to see which repositories are configured.

	.LINK
        The name of a related topic. The value appears on the line below

#>
	
<#
	Created by:   	cmonahan
	Organization: 	companyname

	Recent Comment History
	----------------------
	YYYMMDD username- 1st comment.
	YYYMMDD username- 2nd comment.
	YYYMMDD username- 3rd comment.
#>
	
	#TODO: Support -WhatIf for generating a report.  Example: Update-mNugetModule -Automatic -WhatIf
	#TODO: Write function Remove-NugetModule -Version -OldVersions -Latest -Automatic -Quiet
	#TODO: Add code for "SupportsShouldProcess"
	[cmdletbinding(SupportsShouldProcess)]
	param (
		[Parameter(Position = 0, Mandatory = $false, ValueFromPipeline = $true)][string]$Name,
		[Parameter(Position = 1, Mandatory = $false, ValueFromPipeline = $false)][switch]$Automatic
	)
	
	begin {
		# Code to be executed once BEFORE the pipeline is processed goes here.
		
		# The function Get-mCurrentLine is used in ever script and function.
		if (Test-Path -Path function:\Get-mCurrentLine) { Write-Verbose "$(Get-Now)- $($MyInvocation.InvocationName) - Line $(Get-mCurrentLine) - Function Get-mCurrentLine is loaded in the session." }
		else { throw "$(Get-Now)- $($MyInvocation.InvocationName) - Line 52 or so - Function Get-mCurrentLine is not loaded in the session." }
		
		Write-Verbose "$(Get-Now)- $($MyInvocation.InvocationName) - Line $(Get-mCurrentLine) - Function started."
		
		# Importing modules that may not normally be loaded, are required, and are safe to load.
		$ModuleList = "PackageManagement", "PowerShellGet"
		$ModuleList | ForEach-Object {
			# Test and import if necessary.
			if (Test-mIsModuleLoaded -Name $_) { Write-Verbose "$(Get-Now)- $($MyInvocation.InvocationName) - Line $(Get-mCurrentLine) - Module $($_) is loaded in the session." }
			else { Import-Module -Name $_ }
			
			# Test and fail if the module isn't loaded.
			if (Test-mIsModuleLoaded -Name $_) { Write-Verbose "$(Get-Now)- $($MyInvocation.InvocationName) - Line $(Get-mCurrentLine) - Module $($_) is loaded in the session." }
			else { throw "$(Get-Now)- $($MyInvocation.InvocationName) - Line $(Get-mCurrentLine) - Module $($_) is not loaded in the session." }
		}
		
		# Test for required modules.  Internal support modules and vendor specific technology modules in addition to the builtin Microsoft PowerShell modules.  Remove this section if it's not needed.
		$ModuleList = "mPowerShellGenerics"
		$ModuleList | ForEach-Object {
			if (Test-mIsModuleLoaded -Name $_) { Write-Verbose "$(Get-Now)- $($MyInvocation.InvocationName) - Line $(Get-mCurrentLine) - Module $($_) is loaded in the session." }
			else { throw "$(Get-Now)- $($MyInvocation.InvocationName) - Line $(Get-mCurrentLine) - Module $($_) is not loaded in the session." }
		}
		
	<#
		#TODO: When done coding remove if not needed.
		# Test for required functions that aren't in required modules.  Remove this section if it's not needed.
		$FunctionList = "InsertAFunctionNameHere", "InsertAnotherFunctionNameHere"
		$FunctionList | ForEach-Object {
			if (Test-Path -Path function:\"$($_)") { Write-Verbose -Message "$(Get-Now)- $($MyInvocation.InvocationName) - Line $(Get-mCurrentLine) - Function $($_) is loaded in the session." }
			else { throw "$(Get-Now)- $($MyInvocation.InvocationName) - Line $(Get-mCurrentLine) - Function $($_) is not loaded in the session." }
		}
	#>
		
		#TODO: Figure out if/how to keep repo sources secure.  Breaks if more than one repo is defined.  Commenting out for now.
	<#
		$RepoPaths = 'https://www.powershellgallery.com/api/v2/'

		# Verify PowerShell Gallery is configured as the repository.
		if ((Get-PSRepository).SourceLocation -ne $RepoPath) {
			Write-Error "$(Get-Date)- *** PowerShell Gallery source location incorrect: $((Get-PSRepository).SourceLocation).  Aborting for security concerns."
			break
		}
	#>
		
	} # end of the begin block
	
	process {
		# Code to be executed against every object in the pipeline goes here.
		Write-Verbose "$(Get-Now)- $($MyInvocation.InvocationName) - Line $(Get-mCurrentLine) - Process block start - param1 $($Name) - param2 $($Automatic)"
		
		#TODO: Validate the parameters as needed.
		if (Get-Module -Name $Name -ListAvailable) {
			Write-Verbose -Message "$(Get-Date)- $($MyInvocation.InvocationName) - Line $(Get-mCurrentLine) - Module $($Name) is loaded in this session."
		}
		else {
			Write-Error -Message "$(Get-Date)- $($MyInvocation.InvocationName) - Line $(Get-mCurrentLine) - Module $($Name) is NOT loaded in this session.  Exiting."
			break
		}
		
		# Do the work
		<# Steps to uprade the installed modules.
			Get the list of installed modules.  Include latest local version number and the Gallery version number.
			Print a report of the installed module list if -Quiet not set.
			Update each module.  Ask for confirmation if -Automatic not set.  Check for special cases, module bundles, like VMware.PowerCLI.
			If -Summary set add the action taken for each module (installed/not) to the summary report variable.
		#>
		
		# Get a unique name list of installed PowerShell Gallery modules.  Include latest local version number and the Gallery version number.
		if ($Name) {
			$PSGalleryModulesInstalled = Get-Module -Name $Name -ListAvailable | Select-Object -Property Name -ExpandProperty Name -Unique | Sort-Object | Select-Object @{ n = 'Name'; e = { $_ } }, @{ n = 'LocalVersion'; e = { (Get-Module -Name $_ -ListAvailable | Sort-Object Version | Select-Object -First 1).Version } }, @{ n = 'GalleryVersion'; e = { (Find-Module -Name $_).Version } }
			Write-Verbose -Message "$(Get-Date)- $($MyInvocation.InvocationName) - Line $(Get-mCurrentLine) - PSGalleryModulesInstalled = $($PSGalleryModulesInstalled)"
		}
<#		else {
			$PSGalleryModulesInstalled = Get-Module -ListAvailable | Select-Object -Property Name -ExpandProperty Name -Unique | Sort-Object | Select-Object @{ n = 'Name'; e = { $_ } }, @{ n = 'LocalVersion'; e = { (Get-Module -Name $_ -ListAvailable | Sort-Object Version | Select-Object -First 1).Version } }, @{ n = 'GalleryVersion'; e = { (Find-Module -Name $_).Version } }
		}
#>
		# Update each module.  Ask for confirmation if -Automatic not set.
		#TODO: Check for special cases, module bundles, like VMware.PowerCLI.
		if ($PSGalleryModulesInstalled) {
			
			foreach ($Module in $PSGalleryModulesInstalled) {
				Write-Verbose -Message "$(Get-Date)- $($MyInvocation.InvocationName) - Line $(Get-mCurrentLine) - Current module to upgrade: $($Module)"
				if ((Get-Module -Name JiraPS -ListAvailable).Version -eq (Find-Module -Name JiraPS).Version) { 't' }
				else { 'f' }
				$UpdateCommand = "Update-Module -Name $($Module.Name)"
				if ($Automatic) { $UpdateCommand += ' -Confirm:$false' }
				else { $UpdateCommand += ' -Confirm:$true' }
				if ($PSCmdlet.ShouldProcess("$($Module.Name)", "Update Module")) { $UpdateCommand += ' -WhatIf:$false' }
				else { $UpdateCommand += ' -WhatIf:$true' }
				$UpdateCommand += ' -ErrorVariable ModuleUpdateError'
				Write-Output "$($UpdateCommand)"
				Invoke-Expression -Command $UpdateCommand
				
<#
			Update-mNugetModule -Name mPowerShellGenerics
			Update-mNugetModule -Name mPowerShellGenerics -Automatic
			Update-mNugetModule -Name mPowerShellGenerics -WhatIf
			Update-mNugetModule -Name mPowerShellGenerics -Automatic -WhatIf
#>
<#			if ($Automatic) {
				if ($PSCmdlet.ShouldProcess("$($Module)", "Update Module")) {
					"The -WhatIf parameter was NOT used."
					Update-Module -Name $Module -Confirm:$false -ErrorVariable $ModuleUpdateError -WhatIf #still testing
					$ModuleUpdateResult = $?
				}
				else {
					"The -WhatIf parameter was used."
					Update-Module -Name $Module -Confirm:$false -ErrorVariable $ModuleUpdateError -WhatIf #still testing
					$ModuleUpdateResult = $?
				}
			}
			else {
				if ($PSCmdlet.ShouldProcess("$($Module)", "Update Module")) {
					"The -WhatIf parameter was NOT used."
					Update-Module -Name $Module -Confirm:$true -ErrorVariable $ModuleUpdateError -WhatIf
					$ModuleUpdateResult = $?
				}
				else {
					"The -WhatIf parameter was used."
					Update-Module -Name $Module -Confirm:$false -ErrorVariable $ModuleUpdateError -WhatIf #still testing
					$ModuleUpdateResult = $?
				}
			} #>
			} #end foreach
		} #end if ($PSGalleryModulesInstalled)
		# if ((Get-Module -Name mVMwarePowerCLI -ListAvailable | Select-Object -Property Version -Unique).Count -gt 1) { Write-Verbose "gt1" }

		<# Steps to delete old versions of the installed modules.
			Get a list of modules with more than one version installed.
			Print report if -Quiet not set.
			Delete the old version(s) starting with oldest version.  Ask for confirmation if -Automatic not set.
			If -Summary set add the action taken for each module (installed/not) to the summary report variable.
		#>
		
<#		$PSGalleryModulesInstalled | ForEach-Object {
			if ((Get-Module -Name $_.Name -ListAvailable | Select-Object -Property Version -Unique).Count -gt 1) {
				"`n`n$($_.Name) gt1"
				Get-Module -Name $_.Name -ListAvailable | Select-Object -Property Version -Unique | Sort-Object | Format-Table -AutoSize
				if (($_.Name -match "VMware") -and ($_.Name -ne "VMware.PowerCLI")) { Write-Output "$(Get-Date)- *** Skipping removal of module $($_.Name).  It is part of the VMware.PowerCLI module bundle." }
				else { Uninstall-Module -Name $_.Name -RequiredVersion (Get-Module -Name $_.Name -ListAvailable | Select-Object -Property Version -Unique | Sort-Object | Select-Object -first 1).Version }
			}
		}
#>
	} #end of the process block
	
	end {
		# Code to be executed once AFTER the pipeline is processed goes here.  Disconnect server connections, remove variables, reset the transcript file if necessary, and any other cleanup.
		
		# When testing comment out "-ErrorAction SilentlyContinue".  This will help find typos, unused variables, and other problems.
		Remove-Variable ModuleList, Automatic, UpdateCommand, ModuleUpdateError -WhatIf:$false -ErrorAction SilentlyContinue # Using -WhatIf:$false to suppress unnecessary messages when a calling function has -Whatif:$true enabled.
		#, FunctionList, Name, All, Quiet, PSGalleryModulesInstalled
		
		[System.GC]::Collect() # Memory cleanup
		
		Write-Verbose "$(Get-Now)- $($MyInvocation.InvocationName) - Line $(Get-mCurrentLine) - Function ended."
		
	} #end of the end block
	
} # end of the function

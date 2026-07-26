[string]$pw = $null
$char = $null

do {
	$char = [char](Get-Random -Minimum 33 -Maximum 126 -Count 1)
	Write-Verbose -Message "$(Get-mNow)- $($MyInvocation.InvocationName) - Line $(Get-mCurrentLine) - char = $($char)"
	
	if ($char -notmatch "\\|\/|``|\.") { $pw += $char } # `"|`\|`/|`.
	Write-Verbose -Message "$(Get-mNow)- $($MyInvocation.InvocationName) - Line $(Get-mCurrentLine) - pw = $($pw)"
}
until ($pw.length -ge 17)
$pw

function Copy-ADUser
{
	<#	
		.SYNOPSIS
			A brief description of the Copy-ADUser function.
		
		.DESCRIPTION
			A detailed description of the Copy-ADUser function.
		
		.PARAMETER GivenName
			A description of the GivenName parameter.
		
		.PARAMETER Surname
			A description of the Surname parameter.
		
		.PARAMETER Template
			A description of the Template parameter.
		
		.EXAMPLE
			PS C:\> Copy-ADUser -GivenName "Max" -Surname "Mustermann" -Template "Jonny.Normal"
		
		.NOTES
			Additional information about the function.

    #>

	[CmdletBinding()]
	Param (
		[Parameter(Mandatory = $true)]
		[string]
		$Surname,
		
		[Parameter(Mandatory = $true)]
		[string]
		$GivenName,

		[Parameter(Mandatory = $true)]
		[string]
		$MiddleInitial,
	
		[Parameter(Mandatory = $true)]
		[string]
		$Template
	)	


<#

$GivenName = Read-Host "Enter given name: "

$MiddleInitial = Read-Host "Enter middle initial: "

$Surname = Read-Host "Enter Surname: "

$Template = Read-Host "Who to copy? "





$Session = New-PSSession -ComputerName chevdc1

Import-PSSession $Session

Load-ADmodule Activedirectory

#>

# Create finished Strings
	$JoinedName = $GivenName + "." + $MiddleInitial + "." + $Surname
	
	# Create new User
	$NewUser = New-ADUser -Surname $Surname -GivenName $GivenName -DisplayName "$GivenName $Surname" -SamAccountName $JoinedName -Name "$GivenName $Surname" -PassThru
	
	# Copy from old User
	$NewUser | Add-ADPrincipalGroupMembership -MemberOf (Get-ADPrincipalGroupMembership $Template | Where { $_.Name -ne 'Domain Users' })
	

}

#Remove-PSSession $Session


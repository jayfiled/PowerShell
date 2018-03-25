#Mac server Services

get-service -computername {entercomputername} | Where-Object {$_.Name -eq 'ExtremeZ-IP'}


#GFI services

get-service -computername {entercomputername} | Where-Object {$_.Status -eq 'stopped' -and $_.StartType -eq 'Automatic'}
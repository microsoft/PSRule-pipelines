
# Synopsis: Check for plain text conversion
Rule 'Repos.Creds.PS1' -Type 'System.IO.FileInfo' -If { $TargetObject.Extension -eq '.ps1' -and $TargetObject.FullName -notlike '*.ps-rule*'} {
    (Get-Content -Path $TargetObject.FullName -Raw) -notlike "*ConvertTo-SecureString*-AsPlainText*"
}

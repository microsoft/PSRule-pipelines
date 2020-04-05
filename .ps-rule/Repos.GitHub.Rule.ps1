
# Synopsis: Check for recommended community files
Rule 'Repos.GH.Contribute' -Type 'System.IO.DirectoryInfo' {
    $requiredFiles = @(
        'CHANGELOG.md'
        'LICENSE'
        'CONTRIBUTING.md'
        '.github/CODEOWNERS'
        '.github/PULL_REQUEST_TEMPLATE.md'
    )
    Test-Path -Path $TargetObject.FullName;

    for ($i =0; $i -lt $requiredFiles.Length; $i++) {
        $filePath = Join-Path -Path $TargetObject.FullName -ChildPath $requiredFiles[$i];
        $Assert.Create((Test-Path -Path $filePath -PathType Leaf), "$($requiredFiles[$i]) does not exist");
    }
}

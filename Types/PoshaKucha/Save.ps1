<#
.SYNOPSIS
    Saves a PoshaKucha
.DESCRIPTION
    Saves a PoshaKucha to a json file.
#>
param([string]$Path)
if (-not $path) { $path = "$($this.Title)" }
# Fix the path
$jsonPath =
    $path -replace
        '[\s\p{P}]', '-' -replace
        '-{1,}', '-' -replace
        '(?:\.poshkucha)?\.json$' -replace
        '$', '.poshakucha.json'
        
# We only want to save note properties.
$noteProperties = [Ordered]@{}
foreach ($property in $this.psobject.properties) {
    # so skip anything that is not a note property
    if ($property -isnot [psnoteproperty]) { continue }
    $noteProperties[$property.Name] = $this.$($property.Name)
}
# Create a new file at the path
New-Item -ItemType File -Path $jsonPath -Value (
    $noteProperties | # containing only the note properties.
        ConvertTo-Json -Depth 100
) -Force
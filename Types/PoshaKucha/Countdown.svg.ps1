<#
.SYNOPSIS
    Generates a Countdown
.DESCRIPTION
    Generates a Countdown animation
#>
param(
[Collections.IDictionary]
$Option = [Ordered]@{}
)

if (-not $option['Countdown']) {
    $option['Countdown'] = 20
}

$count = [Math]::Abs($Option['Countdown'])
$fadeSeconds = "attributeName='opacity' from='1' to='0' dur='1s' fill='freeze'"
@(
    "<svg xmlns='http://www.w3.org/2000/svg' width='100%' height='100%'>"
    foreach ($n in 1..$Count) {
        "<text x='95%' y='95%' font-size='2rem' opacity='0' class='countdown countdown-$n'>"
            "$($Count - $n + 1)"
            if ($n -eq 1 ) {
                $secondsId = "SecondsLeft_$($Count)"            
                "<animate id='$secondsId' begin='0s;SecondsLeft_1.end' $fadeSeconds />"
            } else {
                $secondsId = "SecondsLeft_$($count - $n + 1)"
                "<animate id='$secondsId' begin='$lastSecondsId.end' $fadeSeconds />"
            }
            $lastSecondsId = $secondsId
        "</text>"
    }
    "</svg>"

) -join [Environment]::NewLine
function New-PoshaKucha {
    <#
    .SYNOPSIS
        Creates a new PoshaKucha
    .DESCRIPTION
        Creates a new PoshaKucha presentation.
    #>
    param(
    # The title of the PoshaKucha
    [Parameter(ValueFromPipelineByPropertyName)]
    [string]
    $Title,

    # A recording of the PoshaKucha
    [Parameter(ValueFromPipelineByPropertyName)]
    [Alias('Video')]
    [string]$RecordingUrl,

    [Parameter(ValueFromPipelineByPropertyName)]
    [Alias('Date')]
    [PSObject]$DateTime,

    # Either a link to a slide deck or a series of slides.
    # SlideDecks can be:
    # * A Url
    # * HTML
    # * SVG
    # * Markdown
    [Parameter(ValueFromPipelineByPropertyName)]
    [Alias('Slides','Slide')]
    [psobject[]]$SlideDeck,

    # Who wrote or presented the PoshaKucha.
    [Parameter(ValueFromPipelineByPropertyName)]
    [Alias('Presenter')]
    [string]
    $Author,
    
    # The language the PoshaKucha was delivered in.
    [Parameter(ValueFromPipelineByPropertyName)]
    [Alias('Locale','Culture')]
    [string[]]
    $Language,

    # The current slide number.
    [Parameter(ValueFromPipelineByPropertyName)]
    [int]
    $SlideNumber,

    # Any html to display with the PoshaKucha
    # This can be a page fragment, an iframe, or an entire rendered PoshaKucha.
    [Parameter(ValueFromPipelineByPropertyName)]
    [string]
    $Html
    )

    process {
        
        
        $output = [Ordered]@{
            # We creating a new `PoshaKucha`
            PSTypeName='PoshaKucha'
        } + # by copying over our parameters
            $PSBoundParameters

        # If the recording url was not https
        if ($output.RecordingUrl -and 
            $output.RecordingUrl -notmatch '^https://') {
            # prepend the protocol.
            $output.RecordingUrl = "https://$($output.RecordingUrl)"
        }

        # If we had a datetime
        if ($output.DateTime) {
            # but it wasn't a proper datetime
            $output.DateTime = $output.DateTime -as [DateTime]
            if (-not $output.DateTime) {
                # remove that property.
                $output.Remove('DateTime') 
            }
        }

        # return our info as an object
        return [PSCustomObject]$output
    }
}
    
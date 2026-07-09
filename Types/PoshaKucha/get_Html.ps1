# If the talk had html that looked like a whole page
if ($this.Content -match '^[\s\r\n]{0,}<html') {
    return $this.Content # return it.
}

# Otherwise, create a part of a page by joining elements
@(
    # The title goes in an `<h2>`
    if ($this.Title) {
        "<h2>$([Web.HttpUtility]::HtmlEncode($this.Title))</h2>"
    }        
    # The author in an `<h3>`
    if ($this.Author) {
        "<h3>By $($this.Author)</h3>"
    }
    # The recording url should be embedded if possible
    if ($this.RecordingUrl) {
        # (just call oembed
        $(
            try {
                oembed -Url $this.RecordingUrl -ErrorAction Ignore -MaxHeight 480 -MaxWidth 640
            } catch {
                $null
            }
        ).Html # and output the `.html`)
    }
    # If any custom content was provided
    if ($this.content) {
        $this.content # output it
    }
) -join [Environment]::NewLine

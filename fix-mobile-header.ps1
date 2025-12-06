$files = @(
    "about.html",
    "books.html",
    "career.html",
    "contact.html",
    "csr-project.html",
    "e-bulletin.html",
    "events.html",
    "gallery.html",
    "govt-project.html",
    "membership.html",
    "mou.html",
    "notice.html",
    "our-engagement.html",
    "team.html",
    "vasistha-prakashan.html",
    "volunteer.html",
    "workshops-seminar.html"
)

$basePath = "c:\Users\ASUS\Downloads\Vasista Latestt 4th dec 2025 AM\Vasista Latestt 4th dec 2025\Vasista Latestt 3 dec 2025\Vasista Latestt\Vasista Latest\E-file"

foreach ($file in $files) {
    $filePath = Join-Path $basePath $file
    if (Test-Path $filePath) {
        $content = Get-Content $filePath -Raw
        
        # Remove the .vf-top-right { display: none !important; } block
        $pattern = '(\s*)\.vf-top-right\s*\{\s*display:\s*none\s*!important;\s*\}'
        $content = $content -replace $pattern, ''
        
        # Save the file
        Set-Content -Path $filePath -Value $content -NoNewline
        Write-Host "Fixed: $file"
    } else {
        Write-Host "Not found: $file"
    }
}

Write-Host "All files processed!"

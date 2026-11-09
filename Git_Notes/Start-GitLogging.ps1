
# Automatic Git Command Logger

$LogFile = Join-Path $PSScriptRoot "git-commands.md"

if (!(Test-Path $LogFile)) {
    "# Git Command Execution Log`n" | Out-File $LogFile
}

function git {
    $commandText = $args -join " "

    # Execute the actual Git command
    & git.exe @args
    $exitCode = $LASTEXITCODE

    # Record the command
    $date = Get-Date -Format "yyyy-MM-dd HH:mm:ss"

    $status = if ($exitCode -eq 0) {
        "Successful"
    } else {
        "Failed (Exit code: $exitCode)"
    }

    $entry = @"

## $date

- Command: ``git $commandText``
- Status: $status

"@

    Add-Content -Path $LogFile -Value $entry

    return
}

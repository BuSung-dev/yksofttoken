param(
    [Parameter(ValueFromRemainingArguments = $true)]
    [string[]] $yksoftArgs
)

& wsl.exe --cd $PSScriptRoot -- ./yksoft @yksoftArgs
exit $LASTEXITCODE

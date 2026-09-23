& wsl.exe --user root -- apt-get install -y build-essential libyubikey-dev
if ($LASTEXITCODE -ne 0) { exit $LASTEXITCODE }

& wsl.exe --cd $PSScriptRoot -- make
exit $LASTEXITCODE

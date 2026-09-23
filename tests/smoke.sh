#!/bin/sh
set -eu

tokenDir=$(mktemp -d)
trap 'rm -rf "$tokenDir"' EXIT

publicId=cccccccccccc
privateId=010203040506
aesKey=000102030405060708090a0b0c0d0e0f

registration=$(./yksoft -f "$tokenDir" -I "$publicId" -i "$privateId" -k "$aesKey" test)
test "$registration" = "$publicId, $privateId, $aesKey"

firstOtp=$(./yksoft -f "$tokenDir" test)
test "${#firstOtp}" -eq 44
ykparse "$aesKey" "$firstOtp" >/dev/null
grep -q '^session: 2$' "$tokenDir/test"

secondOtp=$(./yksoft -f "$tokenDir" test)
test "${#secondOtp}" -eq 44
test "$firstOtp" != "$secondOtp"
ykparse "$aesKey" "$secondOtp" >/dev/null
grep -q '^session: 3$' "$tokenDir/test"

printf 'smoke test passed\n'

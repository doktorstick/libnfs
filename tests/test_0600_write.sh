#!/bin/sh

. ./functions.sh

echo "basic write test"

start_share

echo -n "Create a 10M file ... "
dd if=/dev/urandom of="${TESTDIR}/orig" bs=1M count=10 2>/dev/null || failure
success

echo -n "Copy file to the NFS server ... "
../utils/nfs-cp "${TESTDIR}/orig" "${TESTURL}/copy" >/dev/null || failure
success

echo -n "Verify the files are identical  ... "
ORIGSUM=`md5sum "${TESTDIR}/orig" | cut -d " " -f 1`
COPYSUM=`md5sum "${TESTDIR}/copy" | cut -d " " -f 1`
[ "${ORIGSUM}" != "${COPYSUM}" ] && failure
success

stop_share

exit 0

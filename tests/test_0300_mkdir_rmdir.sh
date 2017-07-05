#!/bin/sh

. ./functions.sh

echo "basic mkdir/rmdir tests"

start_share

mkdir "${TESTDIR}/subdir"
mkdir "${TESTDIR}/subdir2"

echo -n "Create a root directory (abs) (1) ... "
./prog_mkdir "${TESTURL}/" "." /testdir 2>/dev/null || failure
success

echo -n "Stat the new directory ... "
./prog_stat "${TESTURL}/testdir" > "${TESTDIR}/output" || failure
success

echo -n "Verifying it is a directory ... "
grep "nfs_mode:40" "${TESTDIR}/output" >/dev/null || failure
success

echo -n "Remove a root directory (abs) (2) ... "
./prog_rmdir "${TESTURL}/" "." /testdir 2>/dev/null || failure
success

echo -n "Create a root directory (rel) (3) ... "
./prog_mkdir "${TESTURL}/" "." testdir 2>/dev/null || failure
success

echo -n "Remove a root directory (rel) (4) ... "
./prog_rmdir "${TESTURL}/" "." testdir 2>/dev/null || failure
success

echo -n "Create a directory in a subdirectory (abs) (5) ... "
./prog_mkdir "${TESTURL}/" "." /subdir/testdir 2>/dev/null || failure
success

echo -n "Remove a directory from a subdirectory (abs) (6) ... "
./prog_rmdir "${TESTURL}/" "." /subdir/testdir 2>/dev/null || failure
success

echo -n "Create a directory in a subdirectory (rel) (7) ... "
./prog_mkdir "${TESTURL}/" "." subdir/testdir 2>/dev/null || failure
success

echo -n "Remove a directory from a subdirectory (rel) (8) ... "
./prog_rmdir "${TESTURL}/" "." subdir/testdir 2>/dev/null || failure
success

echo -n "Create a directory in a different directory (rel) (9) ... "
./prog_mkdir "${TESTURL}/" "subdir" ../subdir2/testdir 2>/dev/null || failure
success

echo -n "Remove a directory from a subdirectory (rel) (10) ... "
./prog_rmdir "${TESTURL}/" "." subdir2/testdir 2>/dev/null || failure
success

echo -n "Create a directory outside of the share (rel) (11) ... "
./prog_mkdir "${TESTURL}/" "subdir" ../subdir2/../../testdir 2>/dev/null && failure
success

echo -n "Remove a directory outside of the share (rel) (12) ... "
./prog_rmdir "${TESTURL}/" "subdir" ../subdir2/../../testdir 2>/dev/null && failure
success

echo -n "Create a directory that already exists (rel) (13) ... "
./prog_mkdir "${TESTURL}/" "subdir" ../subdir2 2>/dev/null && failure
success

echo -n "Remove a directory that does not exist (rel) (14) ... "
./prog_rmdir "${TESTURL}/" "subdir" ../subdir3 2>/dev/null && failure
success

stop_share

exit 0

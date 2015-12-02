#/bin/sh
#
# Run this script in a directory with a working makefile to check for 
# compiler warnings in SQLite.
#
rm -f sqlite4.c
make sqlite4.c
echo '************* FTS4 and RTREE ****************'
scan-build gcc -c -DHAVE_STDINT_H -DSQLITE_ENABLE_FTS4 -DSQLITE_ENABLE_RTREE \
      -DSQLITE_DEBUG sqlite4.c 2>&1 | grep -v 'ANALYZE:'
echo '********** ENABLE_STAT3. THREADSAFE=0 *******'
scan-build gcc -c -DSQLITE_ENABLE_STAT3 -DSQLITE_THREADSAFE=0 \
      -DSQLITE_DEBUG sqlite4.c 2>&1 | grep -v 'ANALYZE:'

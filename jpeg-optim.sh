#!/bin/sh

EXTENSIONS="jpe?g"
PROGESSIVE_SIZE_TRIGGER=500000

if [ -z "$1" ]; then
    DIR="`pwd`"
else
    DIR="$1"
fi

# Called with $1 = name of a file to process
function each_file() {
    local file="$1"
    local file_="$1.optimized"

    ((NUM_FILES++))
    sizeA=$( du "$file" | awk '{print $1}' )
    if [ $sizeA -gt $PROGESSIVE_SIZE_TRIGGER ]; then
        xtra="-progressive"
    else
        xtra=""
    fi

    jpegtran -optimize $xtra -outfile "$file_" "$file"

    if [ $? -gt 0 ]; then
        echo "$file: jpegtran failed"
        ((NUM_FAILED++))
        rm -f "$file_"
        return 1
    fi

    sizeB=$( du "$file_" | awk '{print $1}' )

    if [ $sizeB -lt $sizeA ]; then
        local bytesSaved=$(( sizeA - sizeB ))
        echo "$file: Saved ${bytesSaved}b"
        NUM_BYTES=$(( NUM_BYTES + bytesSaved ))

        #chown `ls -ld "$file" | awk '{print $3 ":" $4}'` "$file_"
        #chown $(stat -c "%U:%G" "$file.optimized") "$file"
        #chmod $(stat -c "%a" "$file.optimized") "$file"
        mv -f "$file_" "$file";

    elif [ $sizeB -eq $sizeA ]; then
        echo "$file: skipping, optimized was same size"
        ((NUM_SKIPPED++))
    else
        echo "$file: skipping, optimized was "$(( $sizeB - $sizeA ))"b larger"
        ((NUM_LARGER++))
    fi

    rm -f "$file_"
}

# The find command is different between platforms
if [ "$(uname)" == "Darwin" ]; then
    # Is Mac OS X
    CMD="find -E '$DIR'"
elif [ "$(expr substr $(uname -s) 1 5)" == "Linux" ]; then
    # Is Linux
    CMD="find '$DIR' -regextype posix-egrep"
fi

# Perform find
eval "$CMD -regex '.*\.($EXTENSIONS)\$' -type f" | {
    # Use sub-shell to encapsulate variables
    NUM_FILES=0
    NUM_SKIPPED=0
    NUM_LARGER=0
    NUM_FAILED=0
    NUM_BYTES=0

    while read file; do
        each_file "$file"
    done

    echo "Found $NUM_FILES, skipped $NUM_SKIPPED, enlarged/skipped $NUM_LARGER, failed $NUM_FAILED, saved $NUM_BYTES bytes"
}

# Rename xxx.jpg.optimized -> xxx.jpg
#find "$DIR" -name '*.optimized' -print0 | while read -d $'\0' file; do
#    chown $(stat -c "%U:%G" "${file%.optimized}") "$file"
#    chmod $(stat -c "%a" "${file%.optimized}") "$file"
#    mv -f "$file" "${file%.optimized}";
#done

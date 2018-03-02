#!/bin/sh

if [ -z "$1" ]; then
    DIR="`pwd`"
else
    DIR="$1"
fi

function each_file() {
    local file="$1"
    local file_="$1.optimized"

    ((NUM_FILES++))
    sizeA=$( du "$file" | awk '{print $1}' )

    # -brute  : try 100+ additional optimization methods, slow
    # -rem    : remove data:
    #       gAMA : gamma
    #       cHRM : chroma
    #       iCCP : ICCP color profile
    #       sRGB : additional sRGB profile
    #       alla : all chunks, except transparency
    #       allb : all chunks, except transparency and gamma
    #       text : textual chunks like attribution
    # -reduce : eliminate unused colors and reduce bit-depth if possible
    pngcrush -brute -rem alla -reduce "$file" "$file_"

    if [ $? -gt 0 ]; then
        echo "$file: pngcrush failed"
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

find "$DIR" -name '*.png' -type f | {
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

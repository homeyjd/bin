#!/bin/sh

# timerlib.sh -- functions for timing long-running operations
# by allen brunson  allen.brunson@gmail.com  february 3 2009

# return seconds since 1970
# does not work on some unix variants.  check 'man date' for details

function timerCurrent()
{
    date "+%s"
}

# inputs a number of seconds, outputs a string like "2 minutes, 1 second"
# $1: number of seconds

function timerLengthString()
{
    local days=$((0))
    local hour=$((0))
    local mins=$((0))
    local secs=$1
    local text=""
    
    # convert seconds to days, hours, etc
    days=$((secs / 86400))
    secs=$((secs % 86400))
    hour=$((secs / 3600))
    secs=$((secs % 3600))
    mins=$((secs / 60))
    secs=$((secs % 60))
    
    # build full string from unit strings
    text="$text$(timerLengthStringPart $days "day")"
    text="$text$(timerLengthStringPart $hour "hr")"
    text="$text$(timerLengthStringPart $mins "m")"
    text="$text$(timerLengthStringPart $secs "s")"
    
    # trim leading and trailing whitespace
    text=${text## }
    text=${text%% }
    
    # special case for zero seconds
    if [ "$text" == "" ]; then
        text="0s"
    fi
    
    # echo output for the caller
    echo ${text}
}

# formats a time unit into a string
# $1: integer count of units: 0, 6, etc
# $2: unit name: "hour", "minute", etc

function timerLengthStringPart()
{
    local unit=$1
    local name=$2
    
    #if [ $unit -ge 2 ]; then
    #    echo " ${unit} ${name}s"
    #elif
    if [ $unit -ge 1 ]; then
        echo " ${unit}${name}"
    else
        echo ""    
    fi    
}

# useful for testing timerLengthString

function timerLengthStringTest()
{
    local days=$((86400))
    local hour=$((3600))
    local mins=$((60))
    local secs=$((1))
    
    timerLengthString  0
    timerLengthString 20
    timerLengthString $(( ($hour * 3) + ($mins * 1) + ($secs * 52) ))
    timerLengthString $(( ($days * 1) + ($secs * 14) ))
}

# synonym for timerCurrent

function timerStart()
{
    timerCurrent $*
}

# display final elapsed time
# $1: value returned from an earlier call to timerStart()
# $2: optional descriptive string, such as "total wait time:"

function timerStop()
{
    local desc=$2
    local secs=$((0))
    local stop=$(timerCurrent)
    local text=""
    local time=$1
    
    if [ "$desc" != "" ]; then
        text="$desc "
    fi
    
    secs=$(( $stop - $time ))
    text="$text$(timerLengthString $secs)"
    
    echo $text
}

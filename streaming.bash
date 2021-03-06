#!/bin/bash

DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )"

# What hours when streaming should start and stop are configured in streaming.conf
source $DIR/streaming.conf

H=$(date +%H)
if (( $START <= 10#$H && 10#$H < $STOP )); then 
    echo Time between $START and $STOP, streaming should be on
    systemctl is-active --quiet snapserver || service snapserver start
else
    echo Streaming should be off
    systemctl is-active --quiet snapserver && service snapserver stop 
fi

exit 0

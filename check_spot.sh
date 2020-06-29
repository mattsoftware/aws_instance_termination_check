#!/usr/bin/env bash

ERR_NOT_A_DIRECTORY=2

[[ -f /etc/check_spot ]] && source /etc/check_spot

for x in "$@"; do
    case $x in
        *)
            RUN_D=$(echo $x | cut -d= -f2)
            ;;
    esac
done

: ${RUN_D:?"You must provide a directory to run with as the only parameter"}
[[ ! -d $RUN_D ]] && echo "The directory you provided does not exist as a directory" && exit $ERR_NOT_A_DIRECTORY

IS_TERMINATING=0
DELAY=5
while true; do
    ACTION=$(curl -f http://169.254.169.254/latest/meta-data/spot/instance-action 2>/dev/null)
    RET=$?
    if [[ $RET == 0 ]]; then
        echo "Ready for termination: $ACTION"
        for file in "$RUN_D"/*; do
            echo "Running termination script $file"
            [ -x "$file" ] && (echo "$ACTION" | IS_TERMINATING=$IS_TERMINATING ACTION="$ACTION" "$file")
            RES=$?
            [[ $RES != 0 ]] && echo "Error running $file ($RES)"
        done
        ((IS_TERMINATING++))
        DELAY=10
    fi
    sleep $DELAY
done


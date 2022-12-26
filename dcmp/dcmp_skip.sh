#!/usr/bin/env sh

set -e

# SKIP_MESSAGE="Result is true, skipping DCMP on this project." # optional
# DO_NOT_SKIP_MESSAGE="Result is not true, running DCMP on this project." # optional
# SKIP_SCRIPT="/path/to/script_to_run.sh"

skip_dcmp() {
    printf "0,%s\n" "$SKIP_MESSAGE"
    exit 0
}

do_not_skip_dcmp() {
    printf "1,%s\n" "$DO_NOT_SKIP_MESSAGE"
    exit 1
}

main() {
    if [ -n "$SKIP_SCRIPT" ]; then
        if sh -c "$SKIP_SCRIPT"; then
            skip_dcmp
        else
            do_not_skip_dcmp
        fi
    fi
}

main $@

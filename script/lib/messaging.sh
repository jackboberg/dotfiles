#!/usr/bin/env bash

# script/lib/messaging.sh: Shared messaging functions

bootstrap_colors () {
    if [[ -t 2 ]] && [[ -z "${NO_COLOR-}" ]] && [[ "${TERM-}" != "dumb" ]]; then
        NOFORMAT='\033[0m' RED='\033[0;31m' GREEN='\033[0;32m' ORANGE='\033[0;33m' BLUE='\033[0;34m' PURPLE='\033[0;35m' CYAN='\033[0;36m' YELLOW='\033[1;33m'
    else
        # shellcheck disable=SC2034  # Unused variables left for readability
        NOFORMAT='' RED='' GREEN='' ORANGE='' BLUE='' PURPLE='' CYAN='' YELLOW=''
    fi
}

msg () {
    echo >&2 -e "${1-}"
}

msg_header () {
    msg "${BLUE}${1-}${NOFORMAT}"
}

msg_info () {
    msg "${CYAN}${1-}${NOFORMAT}"
}

msg_warn () {
    msg "${ORANGE}${1-}${NOFORMAT}"
}

msg_error () {
    msg "${RED}${1-}${NOFORMAT}"
}

confirm () {
    local prompt=$1
    local YN

    msg_warn "\n${prompt}"
    read -e -r -p "[Y/n]: " YN

    if [[ $YN == "y" || $YN == "Y" || $YN == "" ]]; then
        return 0
    else
        return 1
    fi
}

affirm () {
    if ! confirm "$@"; then exit 1; fi
}

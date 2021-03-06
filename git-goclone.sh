#!/usr/bin/env bash
set -e

if [ ! -d $GOPATH ]; then
  echo "\$GOPATH is not found." >&2
  exit 1
fi



# bash option parser originated at http://qiita.com/b4b4r07/items/dcd6be0bb9c9185475bb
# NOTE: But simply wanna get if commanded `git clone` has optional output directory.
PROGNAME=$(basename $0)
VERSION="1.0"

usage() {
    echo "Usage: $PROGNAME [OPTIONS] FILE"
    echo "  This script is ~."
    echo
    echo "Options:"
    echo "  -h, --help"
    echo "      --version"
    echo "  -a, --long-a ARG"
    echo "  -b, --long-b [ARG]"
    echo "  -c, --long-c"
    echo
    exit 1
}

for OPT in "$@"
do
    case "$OPT" in
        '-h'|'--help' )
            usage
            exit 1
            ;;
        '--version' )
            echo $VERSION
            exit 1
            ;;
        '-a'|'--long-a' )
            if [[ -z "$2" ]] || [[ "$2" =~ ^-+ ]]; then
                echo "$PROGNAME: option requires an argument -- $1" 1>&2
                exit 1
            fi
            ARG_A="$2"
            shift 2
            ;;
        '-b'|'--long-b' )
            if [[ -z "$2" ]] || [[ "$2" =~ ^-+ ]]; then
                shift
            else
                shift 2
            fi
            ;;
        '-c'|'--long-c' )
            shift 1
            ;;
        '--'|'-' )
            shift 1
            param+=( "$@" )
            break
            ;;
        -*)
            echo "$PROGNAME: illegal option -- '$(echo $1 | sed 's/^-*//')'" 1>&2
            exit 1
            ;;
        *)
            if [[ ! -z "$1" ]] && [[ ! "$1" =~ ^-+ ]]; then
                #param=( ${param[@]} "$1" )
                param+=( "$1" )
                shift 1
            fi
            ;;
    esac
done

if [ -z $param ]; then
    echo "$PROGNAME: too few arguments" 1>&2
    echo "Try '$PROGNAME --help' for more information." 1>&2
    exit 1
fi

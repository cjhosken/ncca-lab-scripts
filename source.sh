DIR=$(dirname "$(realpath "${BASH_SOURCE[0]}")")

export OCIO=$DIR/ocio/BU_nov2024_config.ocio
export HTOA=$DIR/plugins/htoa/htoa-6.3.4.1
export NUKE_PATH=$DIR/plugins/nuke/plugins

alias goHoudini="$DIR/scripts/goHoudini.sh"
alias goMaya="$DIR/scripts/goMaya.sh"
alias goBlender="$DIR/scripts/goBlender.sh"
alias goNuke="$DIR/scripts/goNuke.sh"
alias goChrome="$DIR/scripts/goChrome.sh"
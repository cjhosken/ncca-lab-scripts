DIR=$(dirname "$(realpath "${BASH_SOURCE[0]}")")

# Set OCIO configuration path
OCIO_FILE=$(ls -d "$DIR"/../ocio/*.ocio 2>/dev/null | head -n 1)
if [ -n "$OCIO_FILE" ]; then
    export OCIO="$OCIO_FILE"
fi

alias goHoudini="$DIR/goHoudini.sh"
alias goMaya="$DIR/goMaya.sh"
alias goNuke="$DIR/goNuke.sh"
alias goChrome="$DIR/goChrome.sh"
alias goQube="$DIR/goQube.sh"
alias goTete="$DIR/goTete.sh"
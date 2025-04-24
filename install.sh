DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
INSTALL_ROOT="$HOME/.ncca"
USERNAME=$(whoami)
HERE=$(pwd)

SCRIPTS_ROOT="$DIR/scripts"
OCIO_ROOT="$DIR/ocio"

cd $HOME

# Install Python
# Need to remove .oh-my-bash for the install to work

rm -rf ~/.oh-my-bash

/public/devel/24-25/bin/new_install_python.sh
python3 -m ensurepip --default-pip

# Copy Go Scripts & Tools
mkdir -p $INSTALL_ROOT/scripts
mkdir -p $INSTALL_ROOT/ocio
cp -r $SCRIPTS_ROOT/* $INSTALL_ROOT/scripts/
cp -r $OCIO_ROOT/* $INSTALL_ROOT/ocio

SOURCE_SCRIPT="""
# Custom NCCA Go scripts
source $INSTALL_ROOT/scripts/source.sh
"""

echo "$SOURCE_SCRIPT" >> ~/.bashrc

# Install plugins

HTOA_SOURCE=htoa-6.3.4.1_re0e79ae_houdini-20.5.332_gcc11.tar.xz 

wget https://github.com/cjhosken/ncca-lab-scripts/releases/download/htoa/$HTOA_SOURCE

rm -rf "$INSTALL_ROOT/plugins/htoa"
mkdir -p "$INSTALL_ROOT/plugins/htoa"

tar -xvf $HTOA_SOURCE -C "$INSTALL_ROOT/plugins/htoa" --strip-components=1

rm -rf $HOME/htoa*.tar.xz

cd $HERE
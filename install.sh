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
mkdir -p $INSTALL_ROOT
cp -r $DIR/* $INSTALL_ROOT

SOURCE_SCRIPT="""
# Custom NCCA Go scripts
source $INSTALL_ROOT/scripts/source.sh
"""

echo "$SOURCE_SCRIPT" >> ~/.bashrc

### Install plugins
# Houdini To Arnold (htoa)
HTOA_SOURCE=htoa-6.3.4.1_re0e79ae_houdini-20.5.332_gcc11.tar.xz 
wget https://github.com/cjhosken/ncca-lab-scripts/releases/download/htoa/$HTOA_SOURCE
rm -rf "$INSTALL_ROOT/plugins/htoa"
mkdir -p "$INSTALL_ROOT/plugins/htoa"
tar -xvf $HTOA_SOURCE -C "$INSTALL_ROOT/plugins/htoa" --strip-components=1
rm -rf $HOME/htoa*.tar.xz

# Keen Tools
KEENTOOLS_SOURCE=keentools-2025_1_0-for-nuke-14_1-linux
wget https://downloads.keentools.io/$KEENTOOLS_SOURCE
mkdir -p ~/.nuke/plugins
rm -rf ~/.nuke/plugins/KeenTools
unzip "$KEENTOOLS_SOURCE" -d "$KEENTOOLS_SOURCE"_TEMP
cp -r "$KEENTOOLS_SOURCE"_TEMP/manual/KeenTools ~/.nuke/plugins/
rm -rf $KEENTOOLS_SOURCE*

### Install onedrive


## Install libcurl
if [! -d ~/local/include/curl]; then
mkdir -p ~/local/src ~/local
cd ~/local/src
wget https://curl.se/download/curl-8.7.1.tar.gz
tar -xvzf curl-8.7.1.tar.gz
cd curl-8.7.1
./configure --prefix=$HOME/local --with-openssl
make && make install
fi

export PKG_CONFIG_PATH=$HOME/local/lib/pkgconfig:$PKG_CONFIG_PATH

## Get and install onedrive
curl -fsS https://dlang.org/install.sh | bash -s dmd
source ~/dlang/dmd-2.111.0/activate
git clone https://github.com/abraunegg/onedrive.git ~/.onedrive
cd ~/.onedrive
./configure --prefix=$HOME/local
make clean; make
make install DESTDIR=$HOME/local
deactivate

cd $HERE
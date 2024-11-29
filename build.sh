#!/bin/zsh
# #################################
# Model: Macbook pro m3 Max
# macos: 15
# #################################
# macos lib
brew update
brew install git
brew install make
brew install automake
brew install autoconf
brew install sox
brew install gfortran
brew install subversion
brew install python3
brew install libtool



# use root permissions
cd /opt
git clone -b vosk --single-branch --depth=1 https://github.com/alphacep/kaldi /opt/kaldi
cd kaldi/tools
make openfst cub
./extras/install_openblas_clapack.sh
cd ../src
./configure --mathlib=OPENBLAS_CLAPACK --shared
make -j 10 online2 lm rnnlm
cd ../..

# These three files are necessary, but there is no cp operation in vosk.
cp /opt/kaldi/tools/clapack/BUILD/SRC/liblapack.a /opt/kaldi/tools/OpenBLAS/install/lib/
cp /opt/kaldi/tools/clapack/BUILD/F2CLIBS/libf2c/libf2c.a /opt/kaldi/tools/OpenBLAS/install/lib/
cp /opt/kaldi/tools/clapack/BUILD/BLAS/SRC/libblas.a /opt/kaldi/tools/OpenBLAS/install/lib/


git clone https://github.com/alphacep/vosk-api --depth=1
cd vosk-api/src
# EXT: mac is dylib ,linux is so
KALDI_ROOT=/opt/kaldi EXT=dylib  make

# done
# You should be able to see libvosk.dylib. It is in vosk-api/src.

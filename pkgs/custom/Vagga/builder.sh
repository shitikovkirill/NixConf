 
source $stdenv/setup
PATH=$dpkg/bin:$PATH

tar -xJf $src vagga

cp -r vagga* $out/
mkdir -p $out/bin/
ln -s $out/vagga $out/bin/vagga

set -e
LFS=/mnt/lfs
echo "INFO: Store sources under $LFS/sources and make writable"
mkdir -v $LFS/sources
chmod -v a+wt $LFS/sources
echo "INFO: Download sources using wget-list "
wget http://www.linuxfromscratch.org/lfs/view/7.8/wget-list -O $LFS/wget-list 
wget --input-file=$LFS/wget-list --continue --directory-prefix=$LFS/sources

echo "INFO: Create tools directory"
mkdir -v $LFS/tools
ln -sv $LFS/tools /

echo "INFO: Create lfs user which will be used to do builds"
groupadd lfs
useradd -s /bin/bash -g lfs -m -k /dev/null lfs
chown -v lfs $LFS/tools
chown -v lfs $LFS/sources

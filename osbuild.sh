#set -e
#LFS=/mnt/lfs
#echo "INFO: Store sources under $LFS/sources and make writable"
#mkdir -v $LFS/sources
#chmod -v a+wt $LFS/sources
#echo "INFO: Download sources using wget-list "
#wget http://www.linuxfromscratch.org/lfs/view/7.8/wget-list -O $LFS/wget-list 
#wget --input-file=$LFS/wget-list --continue --directory-prefix=$LFS/sources
#
#echo "INFO: Create tools directory"
#mkdir -v $LFS/tools
#ln -sv $LFS/tools /

echo "INFO: Create lfs user which will be used to do builds"
groupadd lfs
useradd -s /bin/bash -g lfs -m -k /dev/null lfs
chown -v lfs $LFS/tools
chown -v lfs $LFS/sources

echo "INFO: Create bare bash_profile for user lfs to ensure clean build environment"
su - lfs
cat > ~/.bash_profile << "EOF"
exec env -i HOME=$HOME TERM=$TERM PS1='\u:\w\$ ' /bin/bash
EOF


echo "INFO: Create bash.rc for lfs user"
cat > ~/.bashrc << "EOF"
# Turn off hashing so that path is searched everytime 
set +h
# File creation mask to 022 to ensure stuff is only writable by current user  
umask 022
# LFS is where the operating system gets mounted 
LFS=/mnt/lfs
LC_ALL=POSIX
LFS_TGT=$(uname -m)-lfs-linux-gnu
PATH=/tools/bin:/bin:/usr/bin
export LFS LC_ALL LFS_TGT PATH
EOF
echo "INFO: Source the bash_profile"
source ~/.bash_profile

set +e

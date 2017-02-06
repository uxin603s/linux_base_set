#https://www.vultr.com/docs/install-imagemagick-on-centos-6
PATH=/sbin:/usr/sbin:/bin:/usr/bin:/usr/local/sbin:/usr/local/bin; export PATH
BASE_PATH=`readlink -e $(dirname $0)`

if [ ! -e ${BASE_PATH}/ImageMagick-7.0.4-7.tar.xz ]; then
	wget https://www.imagemagick.org/download/ImageMagick-7.0.4-7.tar.xz -O ${BASE_PATH}/ImageMagick-7.0.4-7.tar.xz	
	tar -Jxf ${BASE_PATH}/ImageMagick-7.0.4-7.tar.xz -C ${BASE_PATH}
fi

cd ${BASE_PATH}/ImageMagick-7.0.4-7

yum -y install bzip2-devel freetype-devel libjpeg-devel libpng-devel libtiff-devel giflib-devel zlib-devel ghostscript-devel djvulibre-devel libwmf-devel jasper-devel libtool-ltdl-devel libX11-devel libXext-devel libXt-devel lcms-devel libxml2-devel librsvg2-devel OpenEXR-devel 
# php-devel

./configure
make 
make install
#make check
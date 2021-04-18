#!/bin/bash

echo "==============================安装依赖软件======================================"
yum install -y  gcc  make git  google-perftools   libxslt libxml2 libxslt-devel gd-devel perl-ExtUtils-Embed GeoIP GeoIP-devel GeoIP-data gperftools gcc-c++

wget http://nginx.org/download/nginx-1.19.6.tar.gz
wget http://zlib.net/zlib-1.2.11.tar.gz
wget https://www.openssl.org/source/openssl-1.1.1k.tar.gz
wget https://ftp.pcre.org/pub/pcre/pcre-8.44.tar.gz
git clone https://github.guiyunweb.com/yaoweibin/ngx_http_substitutions_filter_module


tar -zxvf nginx-1.19.6.tar.gz
tar -zxvf openssl-1.1.1k.tar.gz 
tar -zxvf pcre-8.44.tar.gz
tar -zxvf zlib-1.2.11.tar.gz


cd openssl-1.1.1k/
./config && make && make install
cd ..

echo "==============================编译安装软件======================================"
cd nginx-1.19.6/
./configure \
  --prefix=/usr/local/nginx \
  --with-pcre=../pcre-8.44 \
  --with-openssl=../openssl-1.1.1k \
  --with-zlib=../zlib-1.2.11 \
  --add-module=../ngx_http_substitutions_filter_module \
  --with-file-aio --with-ipv6 --with-http_auth_request_module --with-http_ssl_module --with-http_v2_module --with-http_realip_module --with-http_addition_module --with-http_xslt_module=dynamic --with-http_image_filter_module=dynamic --with-http_geoip_module=dynamic --with-http_sub_module --with-http_dav_module --with-http_flv_module --with-http_mp4_module --with-http_gunzip_module --with-http_gzip_static_module --with-http_random_index_module --with-http_secure_link_module --with-http_degradation_module --with-http_slice_module --with-http_stub_status_module --with-http_perl_module=dynamic --with-mail=dynamic --with-mail_ssl_module --with-pcre --with-pcre-jit --with-stream=dynamic --with-stream_ssl_module --with-google_perftools_module --with-debug

make && make install

echo "==============================Nginx安装完成======================================"

cd ..
cat << EOF >> /etc/profile
export PATH=/usr/local/nginx/sbin:$PATH
EOF

source /etc/profile

cp -f  nginx.conf /usr/local/nginx/conf/nginx.conf

mkdir /usr/local/nginx/conf/conf.d/

touch /usr/local/nginx/conf/conf.d/default.conf

cat << EOF >> /usr/local/nginx/conf/conf.d/default.conf
 server {
    listen       80;
    server_name  localhost;
    location / {
        root   html;
        index  index.php index.html index.htm ;
    }    
    error_page   500 502 503 504  /50x.html;
    location = /50x.html {
        root   html;
    }
    location ~ /\.ht {
        deny  all;
    }
}
EOF

nginx

echo "==============================Nginx配置完成======================================"
# ffmpeg安装

## 安装yasm

cd /softwares/nginx-rtmp-ffmpeg
tar -xzf yasm-1.3.0.tar.gz
cd yasm-1.3.0
./configure --prefix=/litsoft/yasm
make && make install

## 安装x264视频编码库
cd /softwares/nginx-rtmp-ffmpeg
wget ftp://ftp.videolan.org/pub/x264/snapshots/x264-snapshot-20120718-2245-stable.tar.bz2
tar -xjf x264-snapshot-20120718-2245-stable.tar.bz2
cd x264-snapshot-20120718-2245-stable
./configure --prefix=/litsoft/x264 --disable-asm --enable-shared
make && make install 
vi /etc/ld.so.conf
加入: /litsoft/x264/lib
执行: ldconfig

## 安装faac音频编码库
cd /softwares/nginx-rtmp-ffmpeg
tar -xjf faac-1.28.tar.bz2
cd faac-1.28
./configure --prefix=/litsoft/faac --enable-shared
make && make install

遇到错误：
mpeg4ip.h:126: error: new declaration ‘char* strcasestr(const char*, const char*)’

解决方法：
vi common/mp4v2/mpeg4ip.h

修改第123行： 
|#ifdef __cplusplus 
|extern "C++" { 
|#endif 
|const char *strcasestr(const char *haystack, const char *needle); 
|#ifdef __cplusplus 
|} 
|#endif

vi /etc/ld.so.conf
加入: /litsoft/faac/lib
执行: ldconfig

## 安装ffmpeg
cd /softwares/nginx-rtmp-ffmpeg
tar -xjf ffmpeg-2.8.tar.bz2
cd ffmpeg-2.8

./configure \
--enable-shared \
--enable-gpl \
--enable-libx264 \
--enable-libfaac \
--enable-nonfree \
--disable-yasm \
--prefix=/litsoft/ffmpeg \
--extra-cflags=-I/litsoft/x264/include \
--extra-ldflags=-L/litsoft/x264/lib \
--extra-cflags=-I/litsoft/faac/include \
--extra-ldflags=-L/litsoft/faac/lib

make && make install

vi /etc/ld.so.conf
加入: /litsoft/ffmpeg/lib
执行: ldconfig
执行：/litsoft/ffmpeg/bin/ffmpeg -version
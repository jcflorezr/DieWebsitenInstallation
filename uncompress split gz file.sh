split gz file
split -b 40m "jdk-8u51-linux-x64.gz" "jdk-8u51-linux-x64.gz.part-" 

uncompress gz splitted file
cat jdk-8u51-linux-x64.gz.part-* | tar xz
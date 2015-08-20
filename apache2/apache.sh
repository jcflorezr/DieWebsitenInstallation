# https://www.digitalocean.com/community/tutorials/how-to-set-up-a-host-name-with-digitalocean
# http://tecadmin.net/setup-apache-as-reverse-proxy-for-tomcat/

apt-get update

apt-get install -y build-essential

apt-get install -y libapache2-mod-proxy-html libxml2-dev

a2enmod --> Prompt to say ok

proxy proxy_ajp proxy_http rewrite deflate headers proxy_balancer proxy_connect proxy_html

cp {HOME_DIEWEBSITEN}/000-default.conf /etc/apache2/sites-enabled/000-default.conf
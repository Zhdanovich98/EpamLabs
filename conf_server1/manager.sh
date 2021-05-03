sudo yum update -y
sudo yum install mc -y
sudo yum install httpd -y
sudo yum install httpd-devel -y
sudo yum install wget -y
sudo systemctl start httpd
sudo systemctl enable httpd
#update conf
sudo rm /etc/httpd/conf/httpd.conf
sudo rm /etc/httpd/conf/workers.properties
sudo cp httpd.conf /etc/httpd/conf/
sudo cp workers.properties /etc/httpd/conf/
#install mod_jk.so
sudo rm tomcat-connectors-1.2.48-src.tar.gz
sudo rm -R tomcat-connectors-1.2.48-src
sudo rm /usr/lib64/httpd/modules/mod_jk.so
wget https://downloads.apache.org/tomcat/tomcat-connectors/jk/tomcat-connectors-1.2.48-src.tar.gz
tar -xvf tomcat-connectors-1.2.48-src.tar.gz
cd ./tomcat-connectors-1.2.48-src/native
./configure -with-apxs=/usr/bin/apxs
make
cd ./apache-2.0
sudo cp mod_jk.so /usr/lib64/httpd/modules/mod_jk.so
#restart httpd
sudo systemctl restart httpd

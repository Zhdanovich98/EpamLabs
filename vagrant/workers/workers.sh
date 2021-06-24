n=$[$1]
echo $n
sudo yum update -y
sudo yum install mc -y
sudo yum install tomcat -y
sudo yum install tomcat-webapps tomcat-admin-webapps -y
sudo systemctl start tomcat
sudo systemctl enable tomcat
sudo systemctl restart tomcat
#update content
sudo rm /usr/share/tomcat/webapps/ROOT/index.jsp
sudo rm /usr/share/tomcat/webapps/ROOT/index.html
echo "<html>" >> /usr/share/tomcat/webapps/ROOT/index.html
echo "<header><title>This is server</title></header>" >> /usr/share/tomcat/webapps/ROOT/index.html
echo "<body>" >> /usr/share/tomcat/webapps/ROOT/index.html
echo "SERVER $n" >> /usr/share/tomcat/webapps/ROOT/index.html
echo "</body>" >> /usr/share/tomcat/webapps/ROOT/index.html
echo "</html>" >> /usr/share/tomcat/webapps/ROOT/index.html
echo "complete add index.html"

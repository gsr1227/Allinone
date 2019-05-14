yum install wget -y
yum install vim -y
yum install unzip -y

##---------------------------------------------------------------------------------------------------------------------------------------------
echo 'Java Installation started.'
echo '--------------------------'
cd /opt
wget --no-cookies --no-check-certificate --header "Cookie: gpw_e24=http%3A%2F%2Fwww.oracle.com%2F; oraclelicense=accept-securebackup-cookie" http://download.oracle.com/otn-pub/java/jdk/8u181-b13/96a7b8442fe848ef90c96a2fad6ed6d1/jdk-8u181-linux-x64.rpm
yum install jdk-8u181-linux-x64.rpm -y
 
echo 'Java Installation done.'                                                                                                                             
echo '-----------------------'
##---------------------------------------------------------------------------------------------------------------------------------------------
#Tomcat Installation
cd /opt
wget http://mirrors.wuchna.com/apachemirror/tomcat/tomcat-9/v9.0.12/bin/apache-tomcat-9.0.12.zip
unzip apache-tomcat-9.0.12.zip
cd /opt/apache-tomcat-9.0.12/bin
chmod u+x *.sh

sh /opt/apache-tomcat-9.0.12/bin/startup.sh

ln -s /opt/apache-tomcat-9.0.12/bin/startup.sh /usr/bin/startTomcat
ln -s /opt/apache-tomcat-9.0.12/bin/shutdown.sh /usr/bin/stopTomcat

ps -fax

netstat -tunlp

#/opt/apache-tomcat-9.0.12/webapps/manager/META-INF/context.xml

<!-- <Valve className="org.apache.catalina.valves.RemoteAddrValve"
         allow="127\.\d+\.\d+\.\d+|::1|0:0:0:0:0:0:0:1" /> -->
		 


		 
##---------------------------------------------------------------------------------------------------------------------------------------------
#Wildfly Installation
cd /opt
wget http://download.jboss.org/wildfly/14.0.1.Final/wildfly-14.0.1.Final.zip
unzip wildfly-14.0.1.Final.zip

#cd /opt/wildfly-14.0.1.Final/standalone/configuration/
#############################################################################################

## Manual Steps
Find and replace 127.0.0.1 with your Private IP address in standalone.xml like below

vim /opt/wildfly-13.0.0.Final/standalone/configuration/standalone.xml
<wsdl-host>${jboss.bind.address:172.31.24.62}</wsdl-host>
<inet-address value="${jboss.bind.address.management:172.31.24.62}"/>
<inet-address value="${jboss.bind.address:172.31.24.62}"/>

sh /opt/wildfly-13.0.0.Final/bin/add-user.sh
sh /opt/wildfly-13.0.0.Final/bin/standalone.sh

#./standalone.sh -b=private ip address -bmanagement=private ip address
#./standalone.sh -b=172.31.27.29 -bmanagement=172.31.27.29
#############################################################################################

##Once it started successfully, Open the broeser and access the Wildfly server as follows.

#http://<<Host Name>>:<<PortNumber>>
#---------------------------------------------------------------------------------------------------------------------------------------------

#Hardware Requirements for SonarQube
#-----------------------------------
#The SonarQube server requires at least 2GB of RAM to run efficiently and 1GB of free RAM for the OS.

#Login with ec2-user in ec2 instance
cd ~
mkdir sonarqube
cd sonarqube
wget https://sonarsource.bintray.com/Distribution/sonarqube/sonarqube-7.2.1.zip
unzip sonarqube-7.2.1.zip

cd sonarqube-7.2.1/bin/linux-64...
sh sonar.sh start console 

sh sonar.sh status
#---------------------------------------------------------------------------------------------------------------------------------------------
#Hardware Requirements for Nexus
#-------------------------------
#https://help.sonatype.com/repomanager3/system-requirements
#You will need at least 4GB of RAM to run Nexus


#---------------------------------------------------------------------------------------------------------------------------------------------
cd /opt
echo 'Ansible Installation started.'
echo '-----------------------------'
rpm -Uvh https://dl.fedoraproject.org/pub/epel/epel-release-latest-7.noarch.rpm

yum install ansible -y
echo 'Ansible Installation done.'
echo '--------------------------'

echo 'Ansible Version.'
echo '----------------'
ansible --version
#-----------------------------
#(OR)
#cd /opt
#yum install https://dl.fedoraproject.org/pub/epel/epel-release-latest-7.noarch.rpm -y 
#yum install epel-release
#yum install ansible -y
#---------------------------------------------------------------------------------------------------------------------------------------------

rm -rf *.zip



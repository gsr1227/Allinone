echo 'Installing DevOps Tools (Git, JDK, Ant, Maven, Tomcat,Wildfly)'
echo '============================================================= '

echo 'Git Installation started.'
echo '-------------------------'
cd /opt
yum groupinstall "Development Tools" -y
yum install gettext-devel openssl-devel perl-CPAN perl-devel zlib-devel curl-devel -y
yum install wget -y
##Open below URL and select the specific version and right click on that and click on Copy Link Address, then execute the wget command.
##https://github.com/git/git/releases
wget https://github.com/git/git/archive/v2.18.0.tar.gz -O git-bash.tar.gz
tar -zxf git-bash.tar.gz

cd git-2.18.0
make configure
./configure --prefix=/usr/local
make install

git config --global user.name "sree"
git config --global user.email "gsreddy1227@gmail.com"
git config --list

echo 'Git Installation done successfully.'
echo '-----------------------------------'
##---------------------------------------------------------------------------------------------------------------------------------------------
echo 'Java Installation started.'
echo '--------------------------'
cd /opt
wget --no-cookies --no-check-certificate --header "Cookie: gpw_e24=http%3A%2F%2Fwww.oracle.com%2F; oraclelicense=accept-securebackup-cookie" https://download.oracle.com/otn-pub/java/jdk/8u201-b09/42970487e3af4f5aa5bca3f542482c60/jdk-8u201-linux-x64.rpm

yum install jdk-8u191-linux-x64.rpm -y
 
echo 'Java Installation done.'                                                                                                                             
echo '-----------------------'
##---------------------------------------------------------------------------------------------------------------------------------------------
echo 'Ant Installation started.'
echo '-------------------------'
cd /opt
wget http://mirrors.estointernet.in/apache//ant/binaries/apache-ant-1.10.5-bin.zip -O apache-ant-1.10.5.zip
unzip apache-ant-1.10.5.zip
echo "export ANT_HOME=/opt/apache-ant-1.10.5" >> ~/.bash_profile

echo 'Ant Installation done.'
echo '----------------------'
##---------------------------------------------------------------------------------------------------------------------------------------------
echo 'Maven Installation started.'
echo '---------------------------'
cd /opt
wget http://www-eu.apache.org/dist/maven/maven-3/3.5.4/binaries/apache-maven-3.5.4-bin.zip -O apache-maven-3.5.4.zip
unzip apache-maven-3.5.4.zip
echo "export M2_HOME=/opt/apache-maven-3.5.4" >> ~/.bash_profile
#To set the varibales in System wide environment , use below file
#echo "export M2_HOME=/opt/apache-maven-3.5.4" >> /etc/profile
echo 'Maven Installation done.'
echo '-----------------------'

##---------------------------------------------------------------------------------------------------------------------------------------------
cd /opt
echo 'Jenkins Installation started.'
echo '-----------------------------'
wget -O /etc/yum.repos.d/jenkins.repo https://pkg.jenkins.io/redhat-stable/jenkins.repo
rpm --import https://pkg.jenkins.io/redhat-stable/jenkins.io.key
yum install jenkins -y
systemctl start jenkins.service
#(OR)
#service jenkins start

echo 'Jenkins Installation done.'
echo '--------------------------'
#Access the Jenkins with Below URL
#http://HostName:8080
#---------------------------------------------------------------------------------------------------------------------------------------------
#Setting the classpath for ANT, Maven......

#classPath='export PATH=$PATH:$M2_HOME/bin:$ANT_HOME/bin'
#echo "$classPath" >> ~/.bash_profile

echo 'export PATH=$PATH:$M2_HOME/bin:$ANT_HOME/bin' >> ~/.bash_profile
source ~/.bash_profile

echo 'Git Version.'
echo '------------'
git --version

echo 'Java Version.'
echo '-------------'
java -version

echo 'Ant Version.'
echo '------------'
ant -version

echo 'Maven Version.'
echo '--------------'
mvn -version

echo 'Jenkins Status.'
echo '--------------'
systemctl status jenkins.service 
#(OR)
#service jenkins status
#---------------------------------------------------------------------------------------------------------------------------------------------
##Cleaning up...
rm -f *.zip
rm -f *.rpm
rm -f *.gz





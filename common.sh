#!/bin/bash
# common

sudo apt update 

sudo apt -y install openjdk-11-jre-headless

sudo adduser --system --home /opt/hadoop --shell /bin/bash --uid 800  --group --disabled-login hadoop

sudo -u hadoop mkdir /opt/hadoop/software

sudo -u hadoop wget --quiet --directory-prefix /opt/hadoop/software https://downloads.apache.org/hadoop/common/hadoop-3.2.2/hadoop-3.2.2.tar.gz

sudo -u hadoop tar --directory /opt/hadoop/ --extract --file /opt/hadoop/software/hadoop-3.2.2.tar.gz

cat <<EOF | sudo tee /etc/profile.d/javahome.sh
export JAVA_HOME=$(readlink -f /usr/bin/java | sed "s:bin/java::")
EOF

cat <<EOF | sudo tee /etc/profile.d/hadoop_path.sh
export PATH=/opt/hadoop/hadoop-3.2.2/bin:/opt/hadoop/hadoop-3.2.2/sbin:\$PATH
EOF

cat <<EOF | sudo tee /opt/hadoop/software/systemd_service.template
[Unit]
Description=\${SERVICE_DESCRIPTION}
After=network-online.target 
Requires=network-online.target

[Service]
Type=forking

User=hadoop
Group=hadoop

ExecStart=/opt/hadoop/hadoop-3.2.2/\${SERVICE_START_CMD}
ExecStop=/opt/hadoop/hadoop-3.2.2/\${SERVICE_STOP_CMD}

WorkingDirectory=/opt/hadoop/hadoop-3.2.2
Environment=JAVA_HOME=/usr/lib/jvm/java-11-openjdk-amd64/
Environment=HADOOP_HOME=/opt/hadoop/hadoop-3.2.2
Restart=on-failure

[Install]
WantedBy=multi-user.target
EOF

SERVICE_DESCRIPTION="Hadoop HDFS datanode service" SERVICE_START_CMD="bin/hdfs --daemon start datanode" SERVICE_STOP_CMD="bin/hdfs --daemon stop datanode" \
	 envsubst  < /opt/hadoop/software/systemd_service.template | sudo tee /etc/systemd/system/hadoop-datanode.service
	 
	 
SERVICE_DESCRIPTION="Hadoop HDFS namenode service" SERVICE_START_CMD="bin/hdfs --daemon start namenode" SERVICE_STOP_CMD="bin/hdfs --daemon stop namenode" \
	 envsubst  < /opt/hadoop/software/systemd_service.template | sudo tee /etc/systemd/system/hadoop-namenode.service
	 
	 
SERVICE_DESCRIPTION="Hadoop HDFS secondary namenode service" SERVICE_START_CMD="bin/hdfs --daemon start secondarynamenode" SERVICE_STOP_CMD="bin/hdfs --daemon stop secondarynamenode" \
	 envsubst  < /opt/hadoop/software/systemd_service.template | sudo tee /etc/systemd/system/hadoop-secondarynamenode.service
  
  
  
SERVICE_DESCRIPTION="Hadoop YARN resourcemanager service" SERVICE_START_CMD="bin/yarn --daemon start resourcemanager" SERVICE_STOP_CMD="bin/yarn --daemon stop resourcemanager" \
	 envsubst  < /opt/hadoop/software/systemd_service.template | sudo tee /etc/systemd/system/hadoop-yarn-resourcemanger.service

SERVICE_DESCRIPTION="Hadoop YARN service" SERVICE_START_CMD="bin/yarn --daemon start nodemanager" SERVICE_STOP_CMD="bin/yarn --daemon stop nodemanager" \
	 envsubst  < /opt/hadoop/software/systemd_service.template | sudo tee /etc/systemd/system/hadoop-yarn-nodemanager.service

sudo systemctl daemon-reload

cat <<EOF | sudo tee /etc/hosts
127.0.0.1       localhost

172.16.0.110 namenode.example.org
172.16.0.111 secondarynamenode.example.org

172.16.0.120 resourcemanager.example.org

172.16.0.131 datanode1.example.org
172.16.0.132 datanode2.example.org
172.16.0.133 datanode3.example.org

172.16.0.150 client.example.org
EOF

hostname -f | grep -q example.org || sudo hostnamectl --static set-hostname $(hostname).example.org

if [ "$(hostname)" == "namenode.example.org" ]; then
  bash /vagrant/namenode.sh
fi

if [ "$(hostname)" == "resourcemanager.example.org" ]; then
  bash /vagrant/resourcemanager.sh
fi

if [ "$(hostname)" == "secondarynamenode.example.org" ]; then
  bash /vagrant/secondarynamenode.sh
fi

if [ "$(hostname)" == "datanode1.example.org" ]; then
  bash /vagrant/datanode.sh
fi

if [ "$(hostname)" == "datanode2.example.org" ]; then
  bash /vagrant/datanode.sh
fi

if [ "$(hostname)" == "datanode3.example.org" ]; then
  bash /vagrant/datanode.sh
fi

if [ "$(hostname)" == "client.example.org" ]; then
  bash /vagrant/client.sh
fi

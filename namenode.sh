#!/bin/bash
# namenode

sudo -u hadoop mkdir -p /opt/hadoop/local_data/{namenode,tmp}

cat <<EOF | sudo tee /opt/hadoop/hadoop-3.2.2/etc/hadoop/core-site.xml
<?xml version="1.0" encoding="UTF-8"?>
<?xml-stylesheet type="text/xsl" href="configuration.xsl"?>
<!--
  Licensed under the Apache License, Version 2.0 (the "License");
  you may not use this file except in compliance with the License.
  You may obtain a copy of the License at

    http://www.apache.org/licenses/LICENSE-2.0

  Unless required by applicable law or agreed to in writing, software
  distributed under the License is distributed on an "AS IS" BASIS,
  WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
  See the License for the specific language governing permissions and
  limitations under the License. See accompanying LICENSE file.
-->

<!-- Put site-specific property overrides in this file. -->

<configuration>
	<property>
		<name>fs.defaultFS</name>
		<value>hdfs://namenode.example.org:9000</value>
	</property>
	<property>
		<name>hadoop.tmp.dir</name>
		<value>/opt/hadoop/local_data/tmp</value>
	</property>
        <property>
                <name>hadoop.http.staticuser.user</name>
                <value>hadoop</value>
        </property>
		
</configuration>
EOF

cat <<EOF | sudo tee /opt/hadoop/hadoop-3.2.2/etc/hadoop/hdfs-site.xml
<?xml version="1.0" encoding="UTF-8"?>
<?xml-stylesheet type="text/xsl" href="configuration.xsl"?>
<!--
  Licensed under the Apache License, Version 2.0 (the "License");
  you may not use this file except in compliance with the License.
  You may obtain a copy of the License at

    http://www.apache.org/licenses/LICENSE-2.0

  Unless required by applicable law or agreed to in writing, software
  distributed under the License is distributed on an "AS IS" BASIS,
  WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
  See the License for the specific language governing permissions and
  limitations under the License. See accompanying LICENSE file.
-->

<!-- Put site-specific property overrides in this file. -->

<configuration>
	<property>
		<name>dfs.name.dir</name>
		<value>/opt/hadoop/local_data/namenode</value>
	</property>
        <property>
                <name>dfs.namenode.secondary.http-address</name>
                <value>https://secondarynamenode.example.org:9870</value>
        </property>
        <property>
                <name>dfs.replication</name>
                <value>3</value>
        </property>
</configuration>
EOF

sudo -i -u hadoop hdfs namenode -format


# czy replication tez na

sudo systemctl enable --now hadoop-namenode.service


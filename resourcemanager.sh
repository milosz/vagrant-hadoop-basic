#!/bin/bash
# resource manager

cat <<EOF | sudo tee /opt/hadoop/hadoop-3.2.2/etc/hadoop/mapred-site.xml
<?xml version="1.0"?>
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
        <name>mapreduce.framework.name</name>
        <value>yarn</value>
    </property>
</configuration>
EOF

cat <<EOF | sudo tee /opt/hadoop/hadoop-3.2.2/etc/hadoop/yarn-site.xml
<?xml version="1.0"?>
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
<configuration>

<!-- Site specific YARN configuration properties -->

<property>
   <name>yarn.nodemanager.aux-services</name>
   <value>mapreduce_shuffle</value>
 </property>
 <property>
   <name>yarn.nodemanager.aux-services.mapreduce.shuffle.class</name>
   <value>org.apache.hadoop.mapred.ShuffleHandler</value>
 </property>


</configuration>
EOF

cat <<EOF | sudo tee /opt/hadoop/hadoop-3.2.2/etc/hadoop/mapred-site.xml
<?xml version="1.0"?>
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
<configuration>

<!-- Site specific YARN configuration properties -->

    <property>
        <name>mapreduce.framework.name</name>
        <value>yarn</value>
    </property>
    <property>                                                                                                                                                                                                                                                                        
        <name>yarn.app.mapreduce.am.env</name>                                                                                                                                                                                                                                          
        <value>HADOOP_MAPRED_HOME=/opt/hadoop/hadoop-3.2.2</value>                                                                                                                                                                                            
    </property>                                                                                                                                                                                                                                                                       
    <property>                                                                                                                                                                                                                                                                        
        <name>mapreduce.map.env</name>                                                                                                                                                                                                                                                  
        <value>HADOOP_MAPRED_HOME=/opt/hadoop/hadoop-3.2.2</value>                                                                                                                                                                                            
    </property>                                                                                                                                                                                                                                                                       
    <property>                                                                                                                                                                                                                                                                        
        <name>mapreduce.reduce.env</name>                                                                                                                                                                                                                                               
        <value>HADOOP_MAPRED_HOME=/opt/hadoop/hadoop-3.2.2</value>                                                                                                                                                                                            
    </property> 
</configuration>
EOF

sudo systemctl enable --now hadoop-yarn-resourcemanger.service 


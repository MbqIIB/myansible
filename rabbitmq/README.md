# Rabbit
## enable / disable rabbit plugins
```shell
ansible syh1,syh2,syh3 -m shell -a "rabbitmq-plugins enable rabbitmq_management rabbitmq_shovel rabbitmq_shovel_management"

ansible syh1,syh2,syh3 -m shell -a "rabbitmq-plugins disable rabbitmq_management rabbitmq_shovel rabbitmq_shovel_management"

ansible syh1,syh2,syh3 -m shell -a "rabbitmq-plugins list"
```


pcs resource disable RABBITMQ-clone
pcs resource unmanaged RABBITMQ-clone
pcs resource unmanage RABBITMQ-clone

pcs resource manage RABBITMQ-clone
pcs resource enable RABBITMQ-clone

ansible controller-server -m shell -a "rm -rf /var/lib/rabbitmq/erl_crash.dump"


ansible controller-server -m shell -a "chown  rabbitmq:rabbitmq -R /var/lib/rabbitmq/"
ansible controller-server -m shell -a "chown  rabbitmq:rabbitmq -R /etc/rabbitmq/"
ansible controller-server -m shell -a "chown  rabbitmq:rabbitmq -R /var/log/rabbitmq/"





rabbitmq-plugins enable rabbitmq_shovel rabbitmq_management

#ansible syh1,syh2,syh3 -m shell -a "cat /etc/rabbitmq/enable*"

#ansible controller-server -m shell -a "cat /etc/rabbitmq/enabled_plugins"
ansible controller-server -m shell -a "rabbitmq-plugins list"
ansible controller-server -m shell -a "rabbitmq-plugins disable rabbitmq_management rabbitmq_management_visualiser rabbitmq_shovel rabbitmq_shovel_management rabbitmq_tracing"


ansible ctl-n1,ctl-n2,ctl-n3  -m shell -a "rm -rf /var/lib/rabbitmq/mnesia/rabbit\@ctl-n1/msg_store_persistent/*"
ansible ctl-n1,ctl-n2,ctl-n3  -m shell -a "rm -rf /var/lib/rabbitmq/mnesia/rabbit\@ctl-n1/msg_store_transient/*"
ansible ctl-n1,ctl-n2,ctl-n3  -m shell -a "rm -rf /var/lib/rabbitmq/mnesia/rabbit\@ctl-n2/msg_store_persistent/*"
ansible ctl-n1,ctl-n2,ctl-n3  -m shell -a "rm -rf /var/lib/rabbitmq/mnesia/rabbit\@ctl-n2/msg_store_transient/*"
ansible ctl-n1,ctl-n2,ctl-n3  -m shell -a "rm -rf /var/lib/rabbitmq/mnesia/rabbit\@ctl-n3/msg_store_persistent/*"
ansible ctl-n1,ctl-n2,ctl-n3  -m shell -a "rm -rf /var/lib/rabbitmq/mnesia/rabbit\@ctl-n3/msg_store_transient/*"




ACTION=disable
ACTION=enable
ACTION=cleanup
pcs resource $ACTION NOVA_API-clone
pcs resource $ACTION NOVA_CERT-clone
pcs resource $ACTION NOVA_CONDUCTOR-clone
pcs resource $ACTION NOVA_CONSOLE-clone
pcs resource $ACTION NOVA_CONSOLEAUTH-clone
pcs resource $ACTION NOVA_NOVNCPROXY-clone
pcs resource $ACTION NOVA_SCHEDULER-clone


#pcs resource $ACTION RABBITMQ-clone [RABBITMQ]

pcs resource $ACTION KEYSTONE-clone [KEYSTONE]

pcs resource $ACTION GLANCE_API-clone [GLANCE_API]
pcs resource $ACTION GLANCE_REGISTRY-clone [GLANCE_REGISTRY]

pcs resource $ACTION NEUTRON_SERVER-clone [NEUTRON_SERVER]

pcs resource $ACTION CINDER_API-clone [CINDER_API]
pcs resource $ACTION CINDER_SCHEDULER-clone [CINDER_SCHEDULER]
pcs resource $ACTION CINDER_VOLUME-clone [CINDER_VOLUME]

pcs resource $ACTION HEAT_API-clone [HEAT_API]
pcs resource $ACTION HEAT_ENGINE-clone [HEAT_ENGINE]



pcs resource





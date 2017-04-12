
ansible  ctl-n1 -m shell -a "rm -f /var/lib/rabbitmq/mnesia/rabbit@ctl-n1/msg_store_persistent/*"
ansible  ctl-n2 -m shell -a "rm -f /var/lib/rabbitmq/mnesia/rabbit@ctl-n2/msg_store_persistent/*"
ansible  ctl-n3 -m shell -a "rm -f /var/lib/rabbitmq/mnesia/rabbit@ctl-n3/msg_store_persistent/*"



ansible   ctl-n1 -m shell -a "rm -f /var/lib/rabbitmq/mnesia/rabbit@ctl-n1/msg_store_transient/*"
ansible   ctl-n2 -m shell -a "rm -f /var/lib/rabbitmq/mnesia/rabbit@ctl-n2/msg_store_transient/*"
ansible   ctl-n3 -m shell -a "rm -f /var/lib/rabbitmq/mnesia/rabbit@ctl-n3/msg_store_transient/*"

pcs resource | grep NOVA    |awk '{print $3}'|xargs -i pcs resource disable {}      
pcs resource | grep NEUTRON |awk '{print $3}'|xargs -i pcs resource disable {}    
pcs resource | grep GLANCE  |awk '{print $3}'|xargs -i pcs resource disable {}
pcs resource | grep CINDER  |awk '{print $3}'|xargs -i pcs resource disable {}      
pcs resource | grep HEAT    |awk '{print $3}'|xargs -i pcs resource disable {}    


pcs resource | grep NOVA     |awk '{print $3}'|xargs -i pcs resource cleanup {}      
pcs resource | grep NEUTRON  |awk '{print $3}'|xargs -i pcs resource cleanup {}    
pcs resource | grep GLANCE   |awk '{print $3}'|xargs -i pcs resource cleanup {}
pcs resource | grep CINDER   |awk '{print $3}'|xargs -i pcs resource cleanup {}      
pcs resource | grep HEAT     |awk '{print $3}'|xargs -i pcs resource cleanup {}    


pcs resource | grep NOVA   |awk '{print $3}'  |xargs -i pcs resource  enable {}      
pcs resource | grep NEUTRON|awk '{print $3}'  |xargs -i pcs resource  enable {}    
pcs resource | grep GLANCE |awk '{print $3}'  |xargs -i pcs resource  enable {}
pcs resource | grep CINDER |awk '{print $3}'  |xargs -i pcs resource  enable {}      
pcs resource | grep HEAT   |awk '{print $3}'  |xargs -i pcs resource  enable {}


pcs resource cleanup XXXunmanged



pcs resource disable RABBITMQ-clone
pcs resource enable RABBITMQ-clone

ansible net-server -m shell -a "/root/service.sh restart"
ansible compute-server -m shell -a "/root/mitaka_servicerestart.sh restart"

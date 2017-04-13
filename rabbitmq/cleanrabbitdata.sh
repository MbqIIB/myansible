#!/bin/bash
set -x

ansible ctl-n1,ctl-n2,ctl-n3  -m shell -a "rm -rf /var/lib/rabbitmq/mnesia/rabbit\@ctl-n1/msg_store_persistent/*"
ansible ctl-n1,ctl-n2,ctl-n3  -m shell -a "rm -rf /var/lib/rabbitmq/mnesia/rabbit\@ctl-n1/msg_store_transient/*"

ansible ctl-n1,ctl-n2,ctl-n3  -m shell -a "rm -rf /var/lib/rabbitmq/mnesia/rabbit\@ctl-n2/msg_store_persistent/*"
ansible ctl-n1,ctl-n2,ctl-n3  -m shell -a "rm -rf /var/lib/rabbitmq/mnesia/rabbit\@ctl-n2/msg_store_transient/*"

ansible ctl-n1,ctl-n2,ctl-n3  -m shell -a "rm -rf /var/lib/rabbitmq/mnesia/rabbit\@ctl-n3/msg_store_persistent/*"
ansible ctl-n1,ctl-n2,ctl-n3  -m shell -a "rm -rf /var/lib/rabbitmq/mnesia/rabbit\@ctl-n3/msg_store_transient/*"


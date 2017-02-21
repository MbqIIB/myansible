
#### config network
''' shell
ansible  mitaka-op-server -m shell -a "route add default gw 10.0.0.64"
ansible  mitaka-op-server -m shell -a "date"
ansible  mitaka-op-server -m shell -a "route del default gw 172.31.255.254 "
'''

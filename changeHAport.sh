#!/bin/bash
perl -pi -e 's/35357/11001/g' /etc/haproxy/haproxy.cfg 
perl -pi -e 's/5000/11000/g' /etc/haproxy/haproxy.cfg
perl -pi -e 's/8774/11005/g' /etc/haproxy/haproxy.cfg
perl -pi -e 's/9696/11003/g' /etc/haproxy/haproxy.cfg
perl -pi -e 's/9292/11002/g' /etc/haproxy/haproxy.cfg
perl -pi -e 's/8776/11006/g' /etc/haproxy/haproxy.cfg
perl -pi -e 's/8000/11008/g' /etc/haproxy/haproxy.cfg
perl -pi -e 's/8777/11004/g' /etc/haproxy/haproxy.cfg
perl -pi -e 's/8004/11007/g' /etc/haproxy/haproxy.cfg                                                                                                      

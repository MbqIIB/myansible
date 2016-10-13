#!/bin/bash

#root passw0rd
ROOTPASS="\$6\$tZIWhKGn\$ZLhQd5HqCik59sX\/seUlIuGnrXVAUuN\/e.4Z2b5Rd.0UVQMjRtE9eUmHEuY0Fx3Q1WFspxTvGJkVgg1I\/se5k1"                                                                                            
sed -i "s/^root.\+:::/root:${ROOTPASS}:16687:0:99999:7:::/" /etc/shadow

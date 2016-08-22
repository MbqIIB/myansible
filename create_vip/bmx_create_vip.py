#!/usr/bin/env python

import os
import sys
import subprocess
import re

import argparse

#| 2f758a57-4fee-4497-a054-384d33e3a0ae | priv-net-vlan1 | None |
#| 4c25836a-19b7-4972-ab54-ccb972713b13 | pub-net1       | None |

private_net = os.environ['PRIVATE_NET'] if 'PRIVATE_NET' in os.environ \
    else '2f758a57-4fee-4497-a054-384d33e3a0ae'

ext_net = os.environ['EXT_NET'] if 'EXT_NET' in os.environ \
    else '4c25836a-19b7-4972-ab54-ccb972713b13'
_debug_flag = False


def _call_with_result(args):
    child = subprocess.Popen(
        args,
        stdout=subprocess.PIPE,
        stderr=subprocess.PIPE)
    child.wait()
    result = child.stdout.readlines()
    if _debug_flag:
        print '-' * 40
        print os.linesep.join(result)
        print '-' * 40
    return result


def create_vip():
    lines = _call_with_result(['neutron', 'port-create', private_net])
    # try to match "ip_address": "192.168.35.11"}
    pattern_fixed_ip = r'ip_address":\s*"(\d+\.\d+\.\d+\.\d+)"'
    # try to match '| id                    | fc19f6a6-6a2a-4ee2-8cbe-41c9ecb72bcd  '
    pattern_fixed_ip_id = r'^[|]\s+id\s+[|]\s+([^ ]+)\s*'
    fixed_ip = [
        re.search(pattern_fixed_ip, line).group(1) for line in lines
        if re.search(pattern_fixed_ip, line)][0]
    fixed_ip_id = [
        re.search(pattern_fixed_ip_id, line).group(1) for line in lines
        if re.search(pattern_fixed_ip_id, line)][0]
    lines = _call_with_result(['nova', 'floating-ip-create', ext_net])
    # try to match ' 93b2e75c-7690-4f42-9579-eaa214525d55 | 172.16.2.162 | -'
    pattern_floating_ip = r'\s*([0-9a-f]{8}-([0-9a-f]{4}-){3}[0-9a-f]{12})' \
                          r'\s*[|]\s*(\d+\.\d+\.\d+\.\d+)\s*[|]'
    floating_ip_id, floating_ip = [
        (re.search(pattern_floating_ip, line).group(1),
         re.search(pattern_floating_ip, line).group(3)) for line in lines
        if re.search(pattern_floating_ip, line)][0]
    if fixed_ip and floating_ip:
        print("associate fixed ip:{}->floating ip:{}"
              .format(fixed_ip, floating_ip))
        subprocess.call(
            ['neutron', 'floatingip-associate', floating_ip_id, fixed_ip_id])
    else:
        sys.stderr.write("failed to get fixed and floating ip pair")
    return fixed_ip, floating_ip


def bind2server(fixed_ip, vips, tag):
    # find the mac address for fixed_ip
    lines = _call_with_result(['neutron', 'port-list'])
    pattern = r"([0-9a-f]{8}-([0-9a-f]{4}-){3}[0-9a-f]{12})" \
              r".*(([0-9a-f]{2}:){5}[0-9a-f]{2}).*" + re.escape(fixed_ip)
    port, mac = [
        (re.search(pattern, line).group(1), re.search(pattern, line).group(3))
        for line in lines if re.search(pattern, line)][0]
    args = ['neutron', 'port-update', port, '--name', tag or 'test',
            '--allowed-address-pairs', 'type=dict', 'list=true',
            ' '.join(["ip_address={}".format(vip) for vip in vips])]
    print ' '.join(args)
    subprocess.call(['bash', '-c', ' '.join(args)])


if __name__ == '__main__':
    parser = argparse.ArgumentParser('vip-create-bind')
    parser.add_argument(
        '--verbose', '-V', action="store_true", default=False,
        help="extra output")
    parser.add_argument('--create', '-c', action='store_true', default=False,
                        help="create new virtual ip pair")
    parser.add_argument('--vip', '-v', metavar='VIP',
                        required=False, action='append',
                        help='virtual ip list (its fixed ip)')
    parser.add_argument('--ip', '-i', metavar='IP',
                        required=False,
                        help='fixed ip (ips) to bind to created virtual ip address,'
                             ' could be comma separate or range fomat')
    parser.add_argument('--tag', '-t', metavar='TAG', required=False,
                        help='tag for binding')

    # examples:
    # 1. create a vip pair
    #  ./create_vip.py -c
    # 2. bind to VMs
    # ./create_vip.py  -v 192.168.35.56 -v 192.168.35.57 -v 192.168.35.58 -i 192.168.34.22-192.168.34.27
    args = parser.parse_args()
    if args.verbose:
        _debug_flag = True
    vips = []
    if args.vip:
        vips.extend(args.vip)
    if args.create:
        new_vip = create_vip()
        vips.extend(new_vip[0])
        print("-" * 70)
        print("created vip: fixed:{} ---> floating:{}".format(new_vip[0], new_vip[1]))
        print("-" * 70)
    if args.ip:
        ips = []
        if '-' in args.ip:  # range format, only support last part range
            first, last = tuple(args.ip.split('-'))
            parts1 = first.split('.')
            parts2 = last.split('.')
            print parts1,parts2
            for i in range(int(parts1[3]), int(parts2[3]) + 1):
                parts = parts1[:-1]
                parts.append(str(i))
                ips.append('.'.join(parts))
        else:
            ips = args.ip.split(',')
        for ip in ips:
            bind2server(ip, vips, args.tag)

#!/bin/bash
nova flavor-create kvm.4c8g100G  auto 8192 100 4
nova flavor-create kvm.4c8g20G  auto 8192 20 4
nova flavor-create docker.4c8g100G  auto 8192 100 4
nova flavor-create docker.small  auto 2048 20 1
nova flavor-create kvm.small auto 2048 20 1

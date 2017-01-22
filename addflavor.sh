#!/bin/bash
nova flavor-create kvm.small auto 2048 20 1
nova flavor-create kvm.4c8g20G  auto 8192 20 4
nova flavor-create kvm.4c8g50G  auto 8192 50 4
nova flavor-create kvm.4c8g100G  auto 8192 100 4
nova flavor-create kvm.4c8g200G  auto 8192 200 4
nova flavor-create kvm.8c16g200G  auto 16384 200 8

nova flavor-create docker.small  auto 2048 20 1
nova flavor-create docker.4c8g100G  auto 8192 100 4
nova flavor-create docker.4c8g200G  auto 8192 200 4

nova flavor-create docker.6c10g40G auto 10240  40 6




nova flavor-create kvm.4c4g100G  auto 4096 100 4

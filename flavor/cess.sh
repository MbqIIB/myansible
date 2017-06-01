#!/bin/bash

#nova flavor-create kvm.small     auto 2048 20 1
#nova flavor-create kvm.4c8g20G   auto 8192 20 4
#nova flavor-create kvm.4c8g50G   auto 8192 50 4
#nova flavor-create kvm.4c8g100G  auto 8192 100 4
#nova flavor-create kvm.4c8g200G  auto 8192 200 4
#nova flavor-create kvm.8c16g200G auto 16384 200 8

nova flavor-create 2c4g20G    auto 4096 20 2
nova flavor-create 4c4g20G    auto 4096 20 4
nova flavor-create 4c8g20G    auto 8192  20 4
nova flavor-create 8c16g20G   auto 16384 20 8
nova flavor-create 8c32g20G   auto 32768 20 8



nova flavor-create 2c4g50G    auto 4096  50 2
nova flavor-create 4c4g50G    auto 4096  50 4
nova flavor-create 4c8g50G    auto 8192  50 4
nova flavor-create 8c16g50G   auto 16384 50 8
nova flavor-create 8c32g50G   auto 32768 50 8

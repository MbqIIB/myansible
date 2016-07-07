#!/bin/bash

set -x
nova list --all-tenants --host `hostname`

#!/bin/bash
#| 0f26b95b-4847-4ba7-aa1c-729eb0c95922 | devops.kvm.large      | 8192      | 80   | 0         |      | 4     | 1.0         | True      |
#| 24de09d4-c50a-48a2-850c-014c3d2d2fd1 | devops.kvm.small      | 2048      | 20   | 0         |      | 1     | 1.0         | True      |
#| 55f31059-cecf-41dc-98aa-7f0a2d01c4e2 | devops.kvm.extralarge | 16384     | 160  | 0         |      | 8     | 1.0         | True      |
#| 59cc9360-864e-4c6f-8810-e8573a1c3692 | devops.kvm.medium     | 4096      | 40   | 0         |      | 2     | 1.0         | True      |
nova flavor-create devops.docker.small auto 2048 20 1
nova flavor-create devops.docker.medium auto 4096 40 2
nova flavor-create devops.docker.large auto 8192 80 4
nova flavor-create devops.docker.extralarge auto 16384 160 8


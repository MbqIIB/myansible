



| 0f26b95b-4847-4ba7-aa1c-729eb0c95922 | devops.kvm.large      | 8192      | 80   | 0         |      | 4     | 1.0         | True      |
| 24de09d4-c50a-48a2-850c-014c3d2d2fd1 | devops.kvm.small      | 2048      | 20   | 0         |      | 1     | 1.0         | True      |
| 55f31059-cecf-41dc-98aa-7f0a2d01c4e2 | devops.kvm.extralarge | 16384     | 160  | 0         |      | 8     | 1.0         | True      |
| 59cc9360-864e-4c6f-8810-e8573a1c3692 | devops.kvm.medium     | 4096      | 40   | 0         |      | 2     | 1.0         | True      |



CPU_SOCKETS=1
CPU_CORES=1
CPU_THREADS=4
 nova flavor-key devops.kvm.large set hw:cpu_cores=${CPU_CORES} hw:cpu_sockets=${CPU_SOCKETS} hw:cpu_threads=${CPU_THREADS}


CPU_SOCKETS=1
CPU_CORES=1
CPU_THREADS=1
nova flavor-key devops.kvm.small set hw:cpu_cores=${CPU_CORES} hw:cpu_sockets=${CPU_SOCKETS} hw:cpu_threads=${CPU_THREADS}



CPU_SOCKETS=1
CPU_CORES=1
CPU_THREADS=2
nova flavor-key devops.kvm.medium set hw:cpu_cores=${CPU_CORES} hw:cpu_sockets=${CPU_SOCKETS} hw:cpu_threads=${CPU_THREADS}



CPU_SOCKETS=1
CPU_CORES=1
CPU_THREADS=8
nova flavor-key devops.kvm.extralarge set hw:cpu_cores=${CPU_CORES} hw:cpu_sockets=${CPU_SOCKETS} hw:cpu_threads=${CPU_THREADS}
| 46ae8f10-12d5-4814-8998-37109e8d5218 | 2c4g20G         | 4096      | 20   | 0         |      | 2     | 1.0         | True      |
| 6e0f5768-f3cd-4dd9-9ca6-3073924d108e | 8c32g20G        | 32768     | 20   | 0         |      | 8     | 1.0         | True      |
| 7899a7d1-7c08-4d1e-9196-0bf979583338 | 8c16g20G        | 16384     | 20   | 0         |      | 8     | 1.0         | True      |
| 9d7d5275-48ae-4653-ab57-a6a41a282d5f | 4c4g20G         | 4096      | 20   | 0         |      | 4     | 1.0         | True      |
| e3e6e9e5-dfa2-43e9-9581-a7a1db70a8be | 4c8g20G         | 8192      | 20   | 0         |      | 4     | 1.0         | True      |


| 2dda0ecd-8969-4f5f-9b77-e8558322f60d | 2c4g50G         | 4096      | 50   | 0         |      | 2     | 1.0         | True      |
| 337903e6-a42a-4225-b43b-b9626d8fb8c6 | 8c32g50G        | 32768     | 50   | 0         |      | 8     | 1.0         | True      |
| 7371a5a8-cdf6-4e3c-b27d-a0f73b1a1bf1 | 8c16g50G        | 16384     | 50   | 0         |      | 8     | 1.0         | True      |
| 98f30630-6e06-4937-ac10-df6a63eca66a | 4c4g50G         | 4096      | 50   | 0         |      | 4     | 1.0         | True      |
| f4e95b73-bad3-465a-956a-14a35652f85b | 4c8g50G         | 8192      | 50   | 0         |      | 4     | 1.0         | True      |

2c4g20G 
8c32g20G
8c16g20G
4c4g20G 
4c8g20G 

2c4g50G 
8c32g50G
8c16g50G
4c4g50G 
4c8g50G 


# smt8c.1s1c8t32g300G

nova flavor-create smt16c.2s1c8t32g300G  auto 32768 300 16
CPU_SOCKETS=2
CPU_CORES=1
CPU_THREADS=8
nova flavor-key smt16c.2s1c8t32g300G set hw:cpu_cores=${CPU_CORES} hw:cpu_sockets=${CPU_SOCKETS} hw:cpu_threads=${CPU_THREADS}





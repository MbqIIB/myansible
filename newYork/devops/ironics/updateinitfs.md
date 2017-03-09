90f23f07-a537-4022-b1b7-282a33523b3a | p8el-deploy-initrd 
目前 cpio 解压后放在 /root/ironic_p8le/test 
 在那个目录下打包  find . -path ./sys -prune -o -path ./proc -prune -o -path './tmp/*' -prune -o -print | sudo cpio -o -H newc | gzip > /tmp/initrd.initramfs 

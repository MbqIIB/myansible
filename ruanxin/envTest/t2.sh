
#!/bin/bash
declare -i i=0
declare -i sum=0
while ((i<10))
do
  let ++i
  #echo $i
  printf "%0.3d\n" $i
done

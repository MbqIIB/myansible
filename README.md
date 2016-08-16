# myansible
Only for study ansible by myself.


### require
pip install python-keyczar


# Generate password
python -c "from passlib.hash import sha512_crypt; import getpass; print sha512_crypt.encrypt(getpass.getpass())"

python -c "from passlib.hash import sha512_crypt; import getpass; print sha512_crypt.encrypt('12345')"

# get gpu infomation

ansible compute-server-ubuntu-svf -m script -a openstackfile/getgpulocked.py | grep nvidia | grep -v stdout > gpu.log
%s/",//g
%s/"//g

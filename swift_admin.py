import swiftclient
from oslo_utils import timeutils

username = "test8@cn.ibm.com"
#token = "2045f12b97f84a54b2c3abf36de4b010"
#token = "1ece6f38125a41ecb33c4441b48f14a8"
#token = "e679ee505be0404b96f07a137a01c0b5"
#token = "d5fa9b8b6a584e01b14e7944e4755828"
token = "dd0ac283848f4cbaa91b4c5b49bc33fc"
endpoint = "http://swift-proxy-vip:8080/v1/AUTH_074b2880fec348e8aa766f64a4ac6e08"

container_name = "image_lin"
#path_name = "openrc"
path_name = "test.py"


def get_swiftclient(username="", token="", endpoint=""):
    return swiftclient.client.Connection(None,
                                         username,
                                         None,
                                         preauthtoken=token,
                                         preauthurl=endpoint,
                                         cacert=None,
                                         insecure=False,
                                         auth_version="2.0")

sc = get_swiftclient(username=username, token=token, endpoint=endpoint)
print sc, sc.__dict__
headers, data = sc.get_object(container_name, path_name)

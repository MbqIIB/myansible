

% openssl s_client -showcerts -connect example.com:443 </dev/null 2>/dev/null | sed -n '/-----BEGIN CERTIFICATE-----/,/-----END CERTIFICATE-----/p' | grep -m1 -B-1 -- '-----END CERTIFICATE-----'  > cert.pem
% curl --cacert cert.pem https://example.com

openssl s_client -showcerts -connect 172.31.250.21:1337  </dev/null 2>/dev/null | sed -n '/-----BEGIN CERTIFICATE-----/,/-----END CERTIFICATE-----/p' | grep -m1 -B-1 -- '-----END CERTIFICATE-----'  > cert.pem

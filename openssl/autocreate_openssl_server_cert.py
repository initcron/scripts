#!/usr/bin/python 
"""
This program automatically  generates SSL Certificates which could 
be used on a web server to encrypt and serve SSL traffic. This is 
ideally suited to be packages with a software appliance with admin 
interface uses SSL and manual generation of SSL certs is not the 
ideal option. 

Requires: Python, Pexpect

Author: Gourav Shah (gs@initcron.org)
http://www.initcron.org | http://www.initcron.com
Version: 1.0 
Date: 22 Feb 2012

"""

import pexpect 
import os
child = pexpect.spawn ('openssl genrsa -des3 -out server.key 1024')
child.expect ('Enter pass phrase for server.key:')
child.sendline ('12345678')
child.expect ('Verifying - Enter pass phrase for server.key:')
child.sendline ('12345678')
child = pexpect.spawn ('openssl req -new -key server.key -out server.csr')
child.expect ('Enter pass phrase for server.key:')
child.sendline ('12345678')
child.expect ('Country Name .*')
child.sendline ('')
child.expect ('State or Province Name')
child.sendline ('')
child.expect ('Locality Name')
child.sendline ('')
child.expect ('Organization Name')
child.sendline ('')
child.expect ('Organizational Unit')
child.sendline ('')
child.expect ('Common Name')
child.sendline ('')
child.expect ('Email Address')
child.sendline ('')
child.expect ('A challenge password')
child.sendline ('')
child.expect ('An optional company name')
child.sendline ('')
child = pexpect.spawn ('openssl x509 -req -days 3650 -in server.csr -signkey server.key -out server.crt')
child.expect ('Enter pass phrase for server.key:')
child.sendline ('12345678')
os.system ('cp server.key server.key.secure')
child = pexpect.spawn ('openssl rsa -in server.key.secure -out server.key')
child.expect ('Enter pass phrase for .*:')
child.sendline ('12345678')


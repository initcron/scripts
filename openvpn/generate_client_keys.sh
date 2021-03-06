#!/bin/bash 
#This scripts automates process of creating OpenVPN client keys and emails
#the keys with windows appliacation and instructions. 
#run from /etc/openvpn/easy-rsa after creating server cert etc. 

user=
mailto=
while getopts 'u:m:' OPTION
do
  case $OPTION in
      u)user="$OPTARG"
;;
      m)mailto="$OPTARG"
;;
      ?)printf "Usage: %s: [-u username] [-m mailto] args\n" $(basename $0) >&2
exit 2
;;
  esac
done
shift $(($OPTIND - 1))


  printf 'Username = "%s" specified\n' "$user"

# Create OpenVPN Client Certificates
#echo "Generating client certificates for the user"

source vars
./build-key $user

#create zip file to be sent to the user with certificates and configs

mkdir client_keys/openvpn_keys_$user
cp keys/$user.crt keys/$user.key keys/ca.crt client_keys/openvpn_keys_$user
cp client.ovpn.template client_keys/openvpn_keys_$user/client.ovpn
sed -i 's/USERNAME/'$user'/g' client_keys/openvpn_keys_$user/client.ovpn
cd client_keys && zip -r  openvpn_keys_$useropenvpn_keys_$user.zip openvpn_keys_$user  && cd ..

#send an email to the user with certs, configs and instructions
echo "Sending autogenerated email to $user"
mutt -s "Autogenerated: OpenVPN Setup" -a client_keys/openvpn_keys_$useropenvpn_keys_$user.zip -a openvpn-2.0.9-gui-1.0.3-install.exe -- $mailto < howto_setup_openvpn_on_windows.txt

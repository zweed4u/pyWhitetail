#!/bin/bash
if [ "$EUID" -ne 0 ]
  then echo "Run as root on device!"
  exit
fi
echo "Installing dependencies..."
apt-get install libffi wget ldid
echo "Pulling compiled python deb..."
wget https://people.rit.edu/zdw7287/files/python_2.7.13-1_iphoneos-arm.deb
echo "Installing python deb..."
dpkg -i python_2.7.13-1_iphoneos-arm.deb
echo "Mitigating Killed: 9 error on invoke..."
ldid -S /usr/bin/python
echo "Mitigating Abort trap: 6 error..."
ldid -S /usr/lib/libpython2.7.dylib
ldid -S /usr/lib/libssl.1.0.0.dylib
ldid -S /usr/lib/libcrypto.1.0.0.dylib
echo "Installing pip..."
PYTHONHTTPSVERIFY=0 easy_install pip 

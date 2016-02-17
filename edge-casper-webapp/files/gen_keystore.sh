#!/bin/bash
set -x
keytool -genkey -alias tomcat -keyalg RSA -keypass "${1}" -storepass "${1}" -dname "CN=${2}, OU=EDGE, O=TARGET, L=Minneapolis, ST=MN, C=US" -keystore /usr/local/jss/tomcat/keystore -validity 365 
chown tomcat7:tomcat7 /usr/local/jss/tomcat/keystore

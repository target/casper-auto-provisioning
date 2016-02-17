# Casper Auto Provisioning
Auto Provision Casper Web Server and Database Server using Ansible

## What it does

This playbook will deploy a Casper JSS Web Server and Database Server then properly import a database backup from a defined CIFS share.

Details about Casper product can be found here: http://www.jamfsoftware.com/products/casper-suite/

## Requirements

There are two seperate roles in this repo, one for the database and one for the webapp.  This code was tested (and operational) on RHEL6.  

<b>edge-casper-db</b>

Ansible play to deploy mysql database setup for Casper

Requires the following vars:
- jss_db
- jss_db_user
- jss_db_root_pass
- jss_db_pass
- mysql_data_dir
- jss_repl_pass
- jss_url
- backup_serviceaccount_username
- backup_serviceaccount_password
- backup_server_path

<b>edge-casper-webapp</b>

Ansible play to deploy a Casper JSS webapp

Requires the following vars:
- java_package
- tomcat_package
- jss_version
- jss_keystore_pass
- database_server
- database_name
- database_user
- database_password
- ansible_hostname

Version

1.0

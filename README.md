# Casper Auto Provisioning
Auto Provision Casper Web Server and Database Server using Ansible

## What it does

Auto provisions Casper Web Server and Database Server

## Requirements

There are two seperate plays in this repo, one for the database and one for the webapp.

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

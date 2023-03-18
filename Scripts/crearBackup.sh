#!/bin/bash

#Crear la carpeta
fecha=$(date +%Y-%m-%d)
DIR=$HOME/Backups/Backup-$fecha
mkdir $DIR

#Copia completa de MYSQL
mysqldump -uroot -pxabier2001 --all-databases --single-transaction --events > myBackup.sql
mv myBackup.sql $DIR

#Copia de mysqld.cnf
sudo cp /etc/mysql/mysql.conf.d/mysqld.cnf $DIR

#Crear el zip de la carpeta
zip -r Backup-$fecha.zip $DIR
sudo mv Backup-$fecha.zip /var/www/html/

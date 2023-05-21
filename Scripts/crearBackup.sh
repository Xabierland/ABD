#!/bin/bash

read -p "MySQL Password: " pass

#Crear la carpeta
fecha=$(date +%Y-%m-%d)
DIR=$HOME/Backups/Backup-$fecha
mkdir $DIR

#Copia completa de MYSQL
mysqldump -uroot -p$pass --all-databases --single-transaction --events > myBackup.sql
mv myBackup.sql $DIR

#Copia de mysqld.cnf
sudo cp /etc/mysql/mysql.conf.d/mysqld.cnf $DIR

#Crear el zip de la carpeta y lo mete en el servidor Apache 
#para poder descargarlo desde otro ordenador
zip -r Backup-$fecha.zip $DIR
sudo mv Backup-$fecha.zip /var/www/html/

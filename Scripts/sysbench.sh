#!/bin/bash
read -p "Base de datos: " db
read -p "Usuario: " user
read -p "Password: " pass
read -p "Numero tablas: " nt
read -p "Numero filas: " nf

sysbench --db-driver=mysql --mysql-db=$db --mysql-user=$user --mysql-password=$pass --mysql-host=127.0.0.1 --mysql-port=3306 --tables=$nt --table-size=$nf /usr/share/sysbench/oltp_read_write.lua prepare


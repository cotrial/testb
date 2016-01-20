#!/usr/bin/env bash

WORK_DIR="/home/ubuntu/testb/"

cd "${WORK_DIR}"/mybb/
sed -i "s/REPLACE_WITH_DATABASE/${DATABASE}/g" ./inc/config.php
sed -i "s/REPLACE_WITH_DB_TABLE_PREFIX/${DB_TABLE_PREFIX}/g" ./inc/config.php
sed -i "s/REPLACE_WITH_DB_HOSTNAME/${DB_HOSTNAME}/g" ./inc/config.php
sed -i "s/REPLACE_WITH_DB_USER/${DB_USER}/g" ./inc/config.php
sed -i "s/REPLACE_WITH_DB_PASSWORD/${DB_PASSWORD}/g" ./inc/config.php

chmod 666 ./inc/settings.php
chmod 666 ./inc/config.php
chmod 666 ./inc/languages/english/*
chmod 666 ./inc/languages/english/admin/*
chmod 777 ./cache/
chmod 777 ./cache/themes/
chmod 777 ./uploads/
chmod 777 ./uploads/avatars/
chmod 777 ./admin/backups/ 

cd "${WORK_DIR}"/
sed -i "s/REPLACE_WITH_MYBB_URL/${MYBB_URL}/g" ./init-db.sql

mysql -u "${DB_USER}" -h "${DB_HOSTNAME}" -p"${DB_PASSWORD}" "${DATABASE}" < init-db.sql 2>/dev/null || echo "DB already initialized. Ignoring import errors"

rm /var/www/html/index.html
cp -r "${WORK_DIR}"/mybb/* /var/www/html/

/usr/sbin/apache2ctl -D FOREGROUND

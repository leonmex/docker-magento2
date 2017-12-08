#!/bin/bash
echo "Start Create User"
mysql -uroot -e "CREATE USER 'magento'@'localhost' IDENTIFIED BY 'password123';"
mysql -uroot -e "GRANT ALL PRIVILEGES ON magento2.* TO 'magento'@'localhost';"
mysql -uroot -e "flush privileges;"
echo "Finish User was created"

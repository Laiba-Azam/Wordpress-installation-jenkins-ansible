db_url_1=http://wordpress.local/
db_url_2=http://wordpress_2.local/
sudo -i
whoami
mysqldump --no-tablespaces -u${1} -p${2} ${3} > exported_DB_NAME.sql
tar -czvf wordpress.tar.gz -C /var/www/html .
sudo scp wordpress.tar.gz vm2@10.0.0.198:~
sudo scp  exported_DB_NAME.sql vm2@10.0.0.198:~
sudo ssh -o StrictHostKeyChecking=no vm2@10.0.0.198 "sudo tar -xvzf wordpress.tar.gz -C /var/www/html/ && mysql -u${1} -p${2} ${3} < exported_DB_NAME.sql && wp search-replace --path='/var/www/html/wordpress' ${db_url_1} ${db_url_2}"

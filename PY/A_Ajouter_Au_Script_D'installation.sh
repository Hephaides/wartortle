apt-get install mariadb-server
myql --user=root <<_EOF_
UPDATE mysql.user SET Password=PASSWORD('${db_root_password}') WHERE User='root';
DELETE FROM mysql.user WHERE User='';
DELETE FROM mysql.user WHERE User='root' AND Host NOT IN ('localhost', '127.0.0.1', '::1');
DROP DATABASE IF EXISTS test;
DELETE FROM mysql.db WHERE Db='test' OR Db='test\\_%';
FLUSH PRIVILEGES;
_EOF_

mariadb -e "CREATE DATABASE IF NOT EXISTS WARTORTLE;USE WARTORTLE;CREATE TABLE IF NOT EXISTS DEVICES ( ID_DEVICES INTEGER NOT NULL AUTO_INCREMENT PRIMARY KEY, COMPANY VARCHAR(255) NOT NULL, NAME VARCHAR(255) NOT NULL, EXPLOITPATH VARCHAR(255)); CREATE TABLE IF NOT EXISTS MAC( ID_MAC INTEGER NOT NULL AUTO_INCREMENT PRIMARY KEY, MAC VARCHAR(255), ID_DEVICES INTEGER NOT NULL, FOREIGN KEY(ID_DEVICES) REFERENCES DEVICES(ID_DEVICES))"
# On peut découper la ligne du dessus et mettre de jolies print entre chaque disant "creation de telle chose" ou non, à toi de voir
mariadb -e "CREATE USER IF NOT EXISTS 'db_user'@'localhost'"
mariadb -e "GRANT ALL PRIVILEGES ON WARTORTLE.* TO 'db_user'"
mariadb -e "FLUSH PRIVILEGES"

pip3 install mariadb

# Je serais pas contre l'ajout d'un  subprocess.Popen("ip a|grep 192", shell=True) a la fin de start.py pour voir l'ip de notre raspberry
# Je serais pas contre le fait de créer un fichier banner où il n'y aura que cette fonction qu'on exportera
# et de même pour l'objet client ?  Histoire d'avoir un start.py propre qui fait pas 700 lignes
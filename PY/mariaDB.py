#Code permettant de tester avant de mettre dans start.py

#!/usr/bin/python 
import mariadb 

try:
    conn = mariadb.connect(
        user="db_user",
        host="localhost",
        #port=3306,
        database="WARTORTLE")
    cur = conn.cursor() 
except mariadb.Error as e:
    print(f"Error connecting to MariaDB Platform: {e}")
    exit(0)
    
#insert information 
try: 
    cur.execute("INSERT INTO DEVICES (COMPANY,NAME,EXPLOITPATH) VALUES (?, ?, ?)", ("Microsoft","NOT FOUND","/etc/exploitpath/")) 
except mariadb.Error as e: 
    print(f"Error: {e}")

cur.execute(
    "SELECT ID_DEVICES FROM DEVICES WHERE COMPANY='Microsoft' AND NAME ='NOT FOUND'")

for (ID_DEVICES) in cur:
    ID=ID_DEVICES[0]

try: 
    cur.execute("INSERT INTO MAC (MAC,ID_DEVICES) VALUES (?, ?)", ("55:21:fa:a9:41:f0",ID)) 
except mariadb.Error as e: 
    print(f"Error: {e}")

conn.commit() 
print(f"Last Inserted ID: {cur.lastrowid}")
    
conn.close()
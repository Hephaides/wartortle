#Code permettant de tester avant de mettre dans start.py
#!/usr/bin/python 

from os import system
from time import sleep
import socket
import re
import subprocess
from datetime import date


import mariadb 


def file():
    f = open("/home/screen/LOOT/Loot_WARTORTLE_" + str(date.today()), "r")
    print("/home/screen/LOOT/Loot_WARTORTLE_" + str(date.today()))
    data = f.read()
    f.close()


print("BDD CONNECT....")
try:
    conn = mariadb.connect(
        user="db_user",
        host="localhost",
        database="WARTORTLE")
    cur = conn.cursor() 
except mariadb.Error as e:
    print(f"Error connecting to MariaDB Platform: {e}")
    exit(0)
    
def insert():
    #insert information 
    try: 
        cur.execute("INSERT INTO DEVICES (COMPANY,NAME,EXPLOITPATH) VALUES (?, ?, ?)", ("Microsoft","NOT FOUND","/etc/exploitpath/")) 
    except mariadb.Error as e: 
        print(f"Error: {e}")
    
    try: 
        cur.execute(
        "SELECT ID_DEVICES FROM DEVICES WHERE COMPANY='Microsoft' AND NAME ='NOT FOUND'")
    except mariadb.Error as e: 
        print(f"Error: {e}")

    for (ID_DEVICES) in cur:
        ID=ID_DEVICES[0]

    try: 
        cur.execute("INSERT INTO MAC (MAC,ID_DEVICES) VALUES (?, ?)", ("55:21:fa:a9:41:f0",ID)) 
    except mariadb.Error as e: 
        print(f"Error: {e}")

def testDevices():
    print("testDevices....")
    try: 
        cur.execute("SELECT ID_DEVICES FROM DEVICES WHERE COMPANY='test1' AND NAME ='test2'")
    except mariadb.Error as e: 
        print(f"Error: {e}")
    
    for (ID_DEVICES) in cur:
        return ID_DEVICES[0]

    remplirDevices()
    testDevices()

def remplirDevices():
    print("remplirDevices....")
    try: 
        cur.execute("INSERT INTO DEVICES (COMPANY,NAME,EXPLOITPATH) VALUES (?, ?, ?)", ("test1","test2","/etc/exploitpath/test3")) 
    except mariadb.Error as e: 
        print(f"Error: {e}")
    print("conn.commit....")
    conn.commit()


def testMac(superID):
    print("testMac....")
    try: 
        cur.execute("SELECT MAC FROM MAC WHERE MAC='00:00:00:00:00'")
    except mariadb.Error as e: 
        print(f"Error: {e}")
    
    for (MAC) in cur:
        return MAC[0]

    remplirMac(superID)
    testMac(superID)

def remplirMac(superID):
    print("remplirMac....")
    try: 
        cur.execute("INSERT INTO MAC (MAC,ID_DEVICES) VALUES (?, ?)", ("00:00:00:00:00",superID)) 
    except mariadb.Error as e: 
        print(f"Error: {e}")   
    print("conn.commit....")
    conn.commit()



def testIfExiste():
    print("testIfExiste....")
    superID=testDevices()
    superMac=testMac(str(superID))
    print("superMac = "+str(superMac)+" superID = "+str(superID))


testIfExiste()



print("conn.close....")
conn.close()

#!/usr/bin/python 

from os import system
from time import sleep
import socket
import re
import subprocess
from datetime import date
import mariadb 

try:
    connDB = mariadb.connect(
        user="db_user",
        host="localhost",
        #port=3306,
        database="WARTORTLE")
    cur = connDB.cursor() 
except mariadb.Error as e:
    print(f"Error connecting to MariaDB Platform: {e}")
    exit(0)

def banner():
    print("""
                                                           
                                                            
                           |                 |    |         
   \ \  \   /  _` |   __|  __|   _ \    __|  __|  |   _ \   
    \ \  \ /  (   |  |     |    (   |  |     |    |   __/   
     \_/\_/  \__,_| _|    \__| \___/  _|    \__| _| \___|   
                                                            
         `Ion cannon loaded and ready to fire up.`          
     https://mickdec.com || https://github.com/mickdec      
              Bluetooth Pentesting Version.                 
                                                            
                              ______________                
                          ,=:'.,            `-._            
                             `:.`---.__         `-._        
                               `:.     `--.         `.      
                                 \.        `.         `.    
                         (,,(,    \.         `.   ____,-`   
       @@             (,'     `/   \.   ,--.___`.'          
       @ @@       ,  ,'  ,--.  `,   \.;'         `          
   &   @   @      `{D, /    \  :    \;                      
     @ @@           V,,'     /  /    //                     
       @@ @         j;;     /  ,' ,-//.    ,---.      ,     
     @ @@           \;'    /  ,' /  _  \  /  _  \   ,'/     
   &   @   @               \   `'  / \  `'  / \  `.' /      
       @ @@                 `.___,'   `.__,'   `.__,'       
       @@                                                   
                                                            
      ________________________________________________      
                                                            
        ____________________________________________        
       |                      |                     |       
       |                      |                     |       
       |                      |                     |       
       |        START         |         STOP        |       
       |                      |                     |       
       |                      |                     |       
       |______________________|_____________________|       
                                                            
      ________________________________________________      
                                                            """[1:], end="")
    sleep(0.3)
    system("clear")
    print("""
                                                           
                                                            
                           |                 |    |         
   \ \  \   /  _` |   __|  __|   _ \    __|  __|  |   _ \   
    \ \  \ /  (   |  |     |    (   |  |     |    |   __/   
     \_/\_/  \__,_| _|    \__| \___/  _|    \__| _| \___|   
                                                            
         `Ion cannon loaded and ready to fire up.`          
     https://mickdec.com || https://github.com/mickdec      
              Bluetooth Pentesting Version.                 
                                                            
                              ______________                
                          ,=:'.,            `-._            
                             `:.`---.__         `-._        
                               `:.     `--.         `.      
                                 \.        `.         `.    
                       ,,(,,(,    \.         `.   ____,-`   
       @@         , _,'       `/   \.   ,--.___`.'          
       @ @@       `{<,  ,---.  `,   \.;'         `          
   &   @   @       /  ,,     \  :    \;                     
     @ @@          ;``       /  /    //                     
       @@ @                 /  ,' ,-//.    ,---.       ,    
     @ @@                  /  ,' /  _  \  /  _  \    ,'/    
   &   @   @               \   `'  / \  `'  / \  `.' /      
       @ @@                 `.___,'   `.__,'   `.__,'       
       @@                                                   
                                                            
      ________________________________________________      
                                                            
        ____________________________________________        
       |                      |                     |       
       |                      |                     |       
       |                      |                     |       
       |        START         |         STOP        |       
       |                      |                     |       
       |                      |                     |       
       |______________________|_____________________|       
                                                            
      ________________________________________________      
                                                            """[1:], end="")
    sleep(0.3)
    system("clear")
    print("""
                                                           
                                                            
                           |                 |    |         
   \ \  \   /  _` |   __|  __|   _ \    __|  __|  |   _ \   
    \ \  \ /  (   |  |     |    (   |  |     |    |   __/   
     \_/\_/  \__,_| _|    \__| \___/  _|    \__| _| \___|   
                                                            
         `Ion cannon loaded and ready to fire up.`          
     https://mickdec.com || https://github.com/mickdec      
              Bluetooth Pentesting Version.                 
                                                            
                              ______________                
                          ,=:'.,            `-._            
                             `:.`---.__         `-._        
                               `:.     `--.         `.      
                                 \.        `.         `.    
        _______        ,,(,,(,    \.         `.   ____,-`   
      /         \ , _,'       `/   \.   ,--.___`.'          
     /           \`{<,  ,---.  `,   \.;'         `          
  & (    (    )    /  ,,     \  :    \;                     
   ((   (      )  /;``       /  /    //                     
    (   (     )  /          /  ,' ,-//.    ,---.         ,  
     \          /          /  ,' /  _  \  /  _  \     ,'/   
   &  \ ______ /           \   `'  / \  `'  / \  `. ' /     
       @ @@                 `.___,'   `.__,'   `.__,'       
       @@                                                   
                                                            
      ________________________________________________      
                                                            
        ____________________________________________        
       |                      |                     |       
       |                      |                     |       
       |                      |                     |       
       |        START         |         STOP        |       
       |                      |                     |       
       |                      |                     |       
       |______________________|_____________________|       
                                                            
      ________________________________________________      
                                                            """[1:], end="")
    sleep(0.3)
    system("clear")
    print("""
                                                           
                                                            
                           |                 |    |         
   \ \  \   /  _` |   __|  __|   _ \    __|  __|  |   _ \   
    \ \  \ /  (   |  |     |    (   |  |     |    |   __/   
     \_/\_/  \__,_| _|    \__| \___/  _|    \__| _| \___|   
                                                            
         `Ion cannon loaded and ready to fire up.`          
     https://mickdec.com || https://github.com/mickdec      
              Bluetooth Pentesting Version.                 
                                                            
                              ______________                
                          ,=:'.,            `-._            
                             `:.`---.__         `-._        
                               `:.     `--.         `.      
                                 \.        `.         `.    
        _______        ,,(,,(,    \.         `.   ____,-`   
      /         \ , _,'       `/   \.   ,--.___`.'          
     /           \`{<,  ,---.  `,   \.;'         `          
  & (   ((    ))   /  ,,     \  :    \;                     
   ((  ((      )) /;``       /  /    //                     
    (  ((     )) /          /  ,' ,-//.    ,---.         ,  
     \          /          /  ,' /  _  \  /  _  \     ,'/   
   &  \ ______ /           \   `'  / \  `'  / \  `. ' /     
       @ @@                 `.___,'   `.__,'   `.__,'       
       @@                                                   
                                                            
      ________________________________________________      
                                                            
        ____________________________________________        
       |                      |                     |       
       |                      |                     |       
       |                      |                     |       
       |        START         |         STOP        |       
       |                      |                     |       
       |                      |                     |       
       |______________________|_____________________|       
                                                            
      ________________________________________________      
                                                            """[1:], end="")
    sleep(0.3)
    system("clear")
    print("""
                                                           
                                                            
                           |                 |    |         
   \ \  \   /  _` |   __|  __|   _ \    __|  __|  |   _ \   
    \ \  \ /  (   |  |     |    (   |  |     |    |   __/   
     \_/\_/  \__,_| _|    \__| \___/  _|    \__| _| \___|   
                                                            
         `Ion cannon loaded and ready to fire up.`          
     https://mickdec.com || https://github.com/mickdec      
              Bluetooth Pentesting Version.                 
                                                            
                              ______________                
                          ,=:'.,            `-._            
                             `:.`---.__         `-._        
                               `:.     `--.         `.      
                                 \.        `.         `.    
        _______        ,,(,,(,    \.         `.   ____,-`   
      /         \ , _,'       `/   \.   ,--.___`.'          
     /           \`{<,  ,---.  `,   \.;'         `          
    (    (    )    /  ,,     \  :    \;                     
   ((   (      )  /;``       /  /    //                     
    (   (     )  /          /  ,' ,-//.    ,---.       ,    
     \          /          /  ,' /  _  \  /  _  \     ,'/   
      \ ______ /           \   `'  / \  `'  / \  `. ' /     
       @ @@                 `.___,'   `.__,'   `.__,'       
       @@                                                   
                                                            
      ________________________________________________      
                                                            
        ____________________________________________        
       |                      |                     |       
       |                      |                     |       
       |                      |                     |       
       |        START         |         STOP        |       
       |                      |                     |       
       |                      |                     |       
       |______________________|_____________________|       
                                                            
      ________________________________________________      
                                                            """[1:], end="")
    sleep(0.3)
    system("clear")
    print("""
                                                           
                                                            
                           |                 |    |         
   \ \  \   /  _` |   __|  __|   _ \    __|  __|  |   _ \   
    \ \  \ /  (   |  |     |    (   |  |     |    |   __/   
     \_/\_/  \__,_| _|    \__| \___/  _|    \__| _| \___|   
                                                            
         `Ion cannon loaded and ready to fire up.`          
     https://mickdec.com || https://github.com/mickdec      
              Bluetooth Pentesting Version.                 
                                                            
                              ______________                
                          ,=:'.,            `-._            
                             `:.`---.__         `-._        
                               `:.     `--.         `.      
                                 \.        `.         `.    
                       ,,(,,(,    \.         `.   ____,-`   
         _____    , _,'       `/   \.   ,--.___`.'          
       /       \  `{<,  ,---.  `,   \.;'         `          
      (            /  ,,     \  :    \;                     
     ((  (    )  / ;``       /  /    //                     
      (         /           /  ,' ,-//.    ,---.       ,    
       \ _____ /           /  ,' /  _  \  /  _  \    ,'/    
        xXXx               \   `'  / \  `'  / \  `.' /      
       x @@ x               `.___,'   `.__,'   `.__,'       
     xX@@  @@Xx                                             
                                                            
      ________________________________________________      
                                                            
        ____________________________________________        
       |                      |                     |       
       |                      |                     |       
       |                      |                     |       
       |        START         |         STOP        |       
       |                      |                     |       
       |                      |                     |       
       |______________________|_____________________|       
                                                            
      ________________________________________________      
                                                            """[1:], end="")
    sleep(0.3)
    system("clear")
    print("""
                                                           
                                                            
                           |                 |    |         
   \ \  \   /  _` |   __|  __|   _ \    __|  __|  |   _ \   
    \ \  \ /  (   |  |     |    (   |  |     |    |   __/   
     \_/\_/  \__,_| _|    \__| \___/  _|    \__| _| \___|   
                                                            
         `Ion cannon loaded and ready to fire up.`          
     https://mickdec.com || https://github.com/mickdec      
              Bluetooth Pentesting Version.                 
                                                            
                              ______________                
                          ,=:'.,            `-._            
                             `:.`---.__         `-._        
                               `:.     `--.         `.      
                                 \.        `.         `.    
                       ,,(,,(,    \.         `.   ____,-`   
                  , _,'       `/   \.   ,--.___`.'          
              __  `{<,  ,---.  `,   \.;'         `          
             /  \  /  ,,     \  :    \;                     
           ((  ) / ;``       /  /    //                     
             \__/           /  ,' ,-//.    ,---.      ,     
                           /  ,' /  _  \  /  _  \   ,'/     
                           \   `'  / \  `'  / \  `.' /      
       x XX x               `.___,'   `.__,'   `.__,'       
     xX@@XX@@Xx                                             
                                                            
      ________________________________________________      
                                                            
        ____________________________________________        
       |                      |                     |       
       |                      |                     |       
       |                      |                     |       
       |        START         |         STOP        |       
       |                      |                     |       
       |                      |                     |       
       |______________________|_____________________|       
                                                            
      ________________________________________________      
                                                            """[1:], end="")
    sleep(0.3)
    system("clear")
    print("""
                                                           
                                                            
                           |                 |    |         
   \ \  \   /  _` |   __|  __|   _ \    __|  __|  |   _ \   
    \ \  \ /  (   |  |     |    (   |  |     |    |   __/   
     \_/\_/  \__,_| _|    \__| \___/  _|    \__| _| \___|   
                                                            
         `Ion cannon loaded and ready to fire up.`          
     https://mickdec.com || https://github.com/mickdec      
              Bluetooth Pentesting Version.                 
                                                            
                              ______________                
                          ,=:'.,            `-._            
                             `:.`---.__         `-._        
                               `:.     `--.         `.      
                                 \.        `.         `.    
                       ,,(,,(,    \.         `.   ____,-`   
                  , _,'       `/   \.   ,--.___`.'          
                  `{<,  ,---.  `,   \.;'         `          
                   /  ,,     \  :    \;                     
            __     ;``       /  /    //                     
          (   )             /  ,' ,-//.    ,---.       ,    
        (     )            /  ,' /  _  \  /  _  \   ,'/     
        (   )              \   `'  / \  `'  / \  `.' /      
         ( )                `.___,'   `.__,'   `.__,'       
    xxxxXXXXXXxxx                                           
                                                            
      ________________________________________________      
                                                            
        ____________________________________________        
       |                      |                     |       
       |                      |                     |       
       |                      |                     |       
       |        START         |         STOP        |       
       |                      |                     |       
       |                      |                     |       
       |______________________|_____________________|       
                                                            
      ________________________________________________      
                                                            """[1:], end="")
    sleep(0.3)
    system("clear")
    print("""
                                                           
                                                            
                           |                 |    |         
   \ \  \   /  _` |   __|  __|   _ \    __|  __|  |   _ \   
    \ \  \ /  (   |  |     |    (   |  |     |    |   __/   
     \_/\_/  \__,_| _|    \__| \___/  _|    \__| _| \___|   
                                                            
         `Ion cannon loaded and ready to fire up.`          
     https://mickdec.com || https://github.com/mickdec      
              Bluetooth Pentesting Version.                 
                                                            
                              ______________                
                          ,=:'.,            `-._            
                             `:.`---.__         `-._        
                               `:.     `--.         `.      
                                 \.        `.         `.    
                         (,,(,    \.         `.   ____,-`   
                      (,'     `/   \.   ,--.___`.'          
                  ,  ,'  ,--.  `,   \.;'         `          
                  `{D, /    \  :    \;                      
                    V,,'     /  /    //                     
                    j;;     /  ,' ,-//.    ,---.      ,     
                    \;'    /  ,' /  _  \  /  _  \   ,'/     
           ()              \   `'  / \  `'  / \  `.' /      
         (  )               `.___,'   `.__,'   `.__,'       
    xxxxXXXXXXxxx                                           
                                                            
      ________________________________________________      
                                                            
        ____________________________________________        
       |                      |                     |       
       |                      |                     |       
       |                      |                     |       
       |        START         |         STOP        |       
       |                      |                     |       
       |                      |                     |       
       |______________________|_____________________|       
                                                            
      ________________________________________________      
                                                            """[1:], end="")
    sleep(0.3)
    system("clear")
    print("""
                                                           
                                                            
                           |                 |    |         
   \ \  \   /  _` |   __|  __|   _ \    __|  __|  |   _ \   
    \ \  \ /  (   |  |     |    (   |  |     |    |   __/   
     \_/\_/  \__,_| _|    \__| \___/  _|    \__| _| \___|   
                                                            
         `Ion cannon loaded and ready to fire up.`          
     https://mickdec.com || https://github.com/mickdec      
              Bluetooth Pentesting Version.                 
                                                            
                              ______________                
                          ,=:'.,            `-._            
                             `:.`---.__         `-._        
                               `:.     `--.         `.      
                                 \.        `.         `.    
                         (,,(,    \.         `.   ____,-`   
                      (,'     `/   \.   ,--.___`.'          
                  ,  ,'  ,--.  `,   \.;'         `          
                  `{D, /    \  :    \;                      
                    V,,'     /  /    //                     
                    j;;     /  ,' ,-//.    ,---.       ,    
                    \;'    /  ,' /  _  \  /  _  \   ,'/     
                           \   `'  / \  `'  / \  `.' /      
                            `.___,'   `.__,'   `.__,'       
    xxxxXXXXXXxxx                                           
                                                            
      ________________________________________________      
                                                            
        ____________________________________________        
       |                      |                     |       
       |                      |                     |       
       |                      |                     |       
       |        START         |         STOP        |       
       |                      |                     |       
       |                      |                     |       
       |______________________|_____________________|       
                                                            
      ________________________________________________      
                                                            """[1:], end="")
    sleep(1)
    system("clear")

class BLE_DATA():
  def __init__(self, recept):
    try:
      self.mac_src = re.findall(r'AdvA:  [a-z0-9:]{17}', recept)[0][7:]
    except:
      self.mac_src = "NOT FOUND"
    try:
      self.company = re.findall(r'Company: .*', recept)[0][9:]
    except:
      self.company = "NOT FOUND"
    try:
      self.data_adv = re.findall(r'AdvData: .*', recept)[0][9:]
    except:
      self.data_adv = "NOT FOUND"
    try:
      self.data_company = re.findall(r'           Data: .*', recept)[0][17:]
    except:
      self.data_company = "NOT FOUND"
    try:
      self.data = re.findall(r'    Data:  .*', recept)[0][11:]
    except:
      self.data = "NOT FOUND"
    try:
      self.CRC = re.findall(r'CRC:   .*', recept)[0][7:]
    except:
      self.CRC = "NOT FOUND"
    try:
      self.local_name = re.findall(r'Complete Local Name\).*      ', recept.replace('\n',''))[0][31:]
    except:
      self.local_name = "NOT FOUND"
  def printDATA(self):
    print("MAC : " + self.mac_src)
    print("Company : " + self.company)
    print("Company Data : " + self.data_company)
    # print("Full Data : " + self.data_adv)
    # print("CR Data : " + self.data)
    # print("CRC : " + self.CRC)
    print("Complete Local Name : " + self.local_name)
  def getDATA(self):
    ret = ""
    ret += "MAC : " + self.mac_src + "\n"
    ret += "Company : " + self.company + "\n"
    ret += "Full Data : " + self.data_adv + "\n"
    ret += "CR Data : " + self.data + "\n"
    ret += "CRC : " + self.CRC + "\n"
    ret += "Complete Local Name : " + self.local_name + "\n"
    return ret

#Script d'execution sur cl??
ps = subprocess.Popen("sudo mount /dev/sda1 /home/screen/LOOT 2>/tmp/error_start.log || sudo mount /dev/sdb1 /home/screen/LOOT 2>/tmp/error_start.log;sudo chmod 777 /home/screen/LOOT", shell=True)
system("sleep 10")
ps = subprocess.Popen("sudo python3 /home/screen/LOOT/.EXEC/exec.py", shell=True)

HOST = '0.0.0.0'
PORT = 2911
DATAS = []
stream = {}
MAX_LOOPS = 100
loops = 0

while 1:
  if loops >= MAX_LOOPS:
    break
  banner()
  print("Starting Ubertooth process..")
  print("Listening for "+str(MAX_LOOPS)+" loops..")
  ps = subprocess.Popen("sleep 6 | sudo ubertooth-btle -f | nc 127.0.0.1 2911", shell=True)
  with socket.socket(socket.AF_INET, socket.SOCK_STREAM) as s:
      s.bind((HOST, PORT))
      s.listen()
      conn, addr = s.accept()
      with conn:
          print('Connected by', addr)
          print('Receiving BLE clients..')
          while True:
              loops += 1
              data = conn.recv(1024)
              if not data:
                  break
              DATA = BLE_DATA(data.decode('utf-8'))
              try:
                if DATA.data != stream[DATA.mac_src]:
                  DATAS.append(DATA)
                  stream[DATA.mac_src] = DATA.data
              except:
                DATAS.append(DATA)
                stream[DATA.mac_src] = DATA.data
              if loops >= MAX_LOOPS:
                break

print("Scanning finished.")
clients_TMP = list()
clients = list()
for data in DATAS:
  if data.mac_src not in clients_TMP and data.mac_src != "NOT FOUND":
    clients_TMP.append(data.mac_src)
    clients.append(data)

print("Congrats, you got " + str(len(clients)) + " clients !")

for client in clients:
  print('\n')
  client.printDATA()

print("Writing loot...")
f = open("/home/screen/LOOT/Loot_WARTORTLE_" + str(date.today()), "w+")
for client in clients:
  f.write(client.getDATA())
  #insert information in BDD
  if(client.company != "NOT FOUND" or client.local_name != "NOT FOUND"):
    print("DANS IF <> client.company="+client.company+" <> client.local_name="+client.local_name)
    try: 
        cur.execute("INSERT INTO DEVICES (COMPANY,NAME,EXPLOITPATH) VALUES (?, ?, ?)", (client.company,client.local_name,"/etc/exploitpath/")) 
    except mariadb.Error as e: 
        print(f"Error: {e}")

    cur.execute("SELECT ID_DEVICES FROM DEVICES WHERE COMPANY=? AND NAME =?",(client.company,client.local_name))

    for (ID_DEVICES) in cur:
      ID=ID_DEVICES[0]
    try: 
        cur.execute("INSERT INTO MAC (MAC,ID_DEVICES) VALUES (?, ?)", (client.mac_src,ID)) 
    except mariadb.Error as e: 
        print(f"Error: {e}")

connDB.commit()       
connDB.close()
f.close()

# print("Trying to exploit...")

# cmd = "python3 exploit.py"
# for client in clients:
#   if client.local_name != "NOT FOUND":
#     cmd = cmd + " " + str(client.mac_src)

# system(cmd)


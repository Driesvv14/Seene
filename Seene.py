#import libraries
import firebase_admin
from firebase_admin import credentials
from firebase_admin import db
import socket
import psutil
import time

#Initialize
cred = credentials.Certificate("./YOUR-firebase-adminsdk-FILE.json")
firebase_admin.initialize_app(cred, {
    'databaseURL' : 'YOUR-DATABASE-URL'
})


def postData():
  
  #Read data
  getName = socket.gethostname()
  
  

  #Remove undesired charachters
  
  pcName = getName.translate(None, "(){}<>-.")

 
  cpu = psutil.cpu_percent(percpu=False, interval = 1)
  ram = psutil.virtual_memory()[2]
  disk_space_used = psutil.disk_usage('/')[3]

  #db root & push data
  root = db.reference()
  root.child('devices/' + pcName).update({
    'pc_name' : pcName,
    'cpu_usage' : str(cpu),
    'ram_usage' : str(ram),
    'disk_space_used' : str(disk_space_used)
  })

  #Wait 30 seconds and repeat
  time.sleep(30)
    

#Run function

try:
    while(True):
        postData()

except KeyboardInterrupt:
    print("Stopt by the user.")




   

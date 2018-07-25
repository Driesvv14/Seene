# Seene

This project is about to build a Python script running on a Raspberry Pi, to collect data from the device and post it to Firebase.
This script collects:
* CPU Percentage
* RAM Usage
* Disk Usage

## Requirements
- A Raspberry Pi or Windows or Mac
- Python installed (with the libraries which are imported in the Python script)
- A Firebase-project and the Firebase-admin.json file

## Installation Libraries

Firebase

pip install firebase-admin


Psutil

pip install psutil

## Step One
Create a Firebase-project and download the .json file from the console.

This can be done by navigating to the Project settings > Serviceaccounts > SDK for Firebasemanagement > Python > Generate new private key.

## Step Two
Copy the script and change the following lines with your credentials:

YOUR DOWNLOADED JSON FILE AND DATABASE URL

Your database url can be found in the Firebase console in the database tab. The link above in your database.

    cred = credentials.Certificate("./YOUR-firebase-adminsdk-FILE-NAME.json")
    firebase_admin.initialize_app(cred, {
        'databaseURL' : 'YOUR-DATABASE-URL'
    })

NOTICE: The .json file should be at the same directory level as the Python script.


NOTICE: When creating a database you have to select private or public. These rules determine who can write to your database.
        When private you won't be able to write to your database and with public everyone can write to it.
        
        Solution:
        
        These Firebase require authentication which is done by our .json file from the Firebase admin sdk.
        
        // These rules require authentication
        {
          "rules": {
            ".read": "auth != null",
            ".write": "auth != null"
          }
        }

On Windows:

    Change this lines:
    
    pcName = getName.translate(None, "(){}<>-.")
    
    
    To:
    
    pcName = socket.gethostname()
    
This because on Windows Python raises an error on the amount of translation arguments.
    

## Step Three
Run the script and the data collected on the device should appear in the Firebase database.
This with their own name under the parent DEVICE.


Run the script on the terminal by the following command:

    python Seene.py

## Step Four
Create a IOS or Android or Web Application which shows the statics for each device you are running the script on.

* Launch App
* Authentication (basic email Firebase)
* Select device
* Displays data


Android and Web App coming soon.



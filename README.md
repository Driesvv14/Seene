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


## Step Three
Run the script and the data collected on the device should appear in the Firebase database.
This with their own name under the parent DEVICE.
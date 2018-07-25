//
//  DevicesController.swift
//  Seene
//
//  Created by Dries Van Vaerenbergh on 19/06/18.
//  Copyright © 2018 Devhelpment. All rights reserved.
//

import Foundation
import UIKit
import FirebaseDatabase

class DevicesController: UITableViewController {
    
    var devices = [String]()
    let ref = FIRDatabase.database().reference()
    
    var selectedDevice = "";
    
    override func viewDidLoad() {
        super.viewDidLoad()
        ref.child("devices").observeSingleEvent(of: .value, with: { (snapshot) in
            // Get user value
            if snapshot.exists() {
                for a in ((snapshot.value as AnyObject).allKeys)!{
                    print(a)
                    self.devices.append(a as! String)
                }
                self.tableView.reloadData()
            }
        }) { (error) in
            print(error.localizedDescription)
        }
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return(devices.count)
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell")
        
        cell?.textLabel?.text = devices[indexPath.row]
        
        return cell!
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "segue_devices_data" {
            let DestViewController : DataController = segue.destination as! DataController
            DestViewController.device = self.selectedDevice
        }
        
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let indexPath = tableView.indexPathForSelectedRow //optional, to get from any UIButton for example
            
        let currentCell = tableView.cellForRow(at: indexPath!) as! UITableViewCell
            
        print(currentCell.textLabel!.text)
        
        self.selectedDevice = currentCell.textLabel!.text!;
        
       
        self.performSegue(withIdentifier: "segue_devices_data", sender: self)
        
       /* let myVC = storyboard?.instantiateViewController(withIdentifier: "DataController") as! DataController
        myVC.device = "test"
        navigationController?.pushViewController(myVC, animated: true)
       */
    }
    

    
}

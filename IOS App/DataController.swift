//
//  DataController.swift
//  Seene
//
//  Created by Dries Van Vaerenbergh on 19/06/18.
//  Copyright © 2018 Devhelpment. All rights reserved.
//



import Foundation
import UIKit
import FirebaseDatabase

class DataController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    @IBOutlet var btn_back: UIButton!
    @IBOutlet var tblv_data: UITableView!
    
    var device = "";
    let ref = FIRDatabase.database().reference()
    var dataKeys = [String]()
    var dataValues = [String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print(device)
        
        ref.child("devices").child(device).observeSingleEvent(of: .value, with: { (snapshot) in
            // Get user value
            if snapshot.exists() {
                for a in ((snapshot.value as AnyObject).allKeys)!{
                    print(a)
                    self.dataKeys.append(a as! String)
                    print(snapshot)
                }
                for a in ((snapshot.value as AnyObject).allValues)!{
                    print(a)
                    self.dataValues.append(a as! String)
                    print(snapshot)
                }
                
                print(self.dataKeys)
                print(self.dataValues)
               
                self.tblv_data.reloadData()
            }
        }) { (error) in
            print(error.localizedDescription)
        }
    }
    
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return(dataKeys.count)
    }
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
       
        let cell = UITableViewCell.init(style: UITableViewCellStyle.default, reuseIdentifier: "cell")
        
        cell.textLabel?.text = dataKeys[indexPath.row] + ": " + dataValues[indexPath.row] + " %"
        
        if dataKeys[indexPath.row] == "pc_name" {
            cell.textLabel?.text = dataKeys[indexPath.row] + ": " + dataValues[indexPath.row]
        }
        
        return cell
    }
    
  
    @IBAction func Back(_ sender: Any) {
        self.performSegue(withIdentifier: "segue_data_devices", sender: self)
        
    }
    
}


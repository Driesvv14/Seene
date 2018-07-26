//
//  ViewController.swift
//  Seene
//
//  Created by Dries Van Vaerenbergh on 19/06/18.
//  Copyright © 2018 Devhelpment. All rights reserved.
//

import UIKit
import FirebaseAuth

class ViewController: UIViewController {

    @IBOutlet var txt_email: UITextField!
    @IBOutlet var txt_wachtwoord: UITextField!
    @IBOutlet var btn_aanmelden: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func Aanmelden(_ sender: UIButton) {
        
        FIRAuth.auth()?.signIn(withEmail: txt_email.text!, password: txt_wachtwoord.text!) { (user, error) in
            if error == nil && user != nil {
                self.performSegue(withIdentifier: "segue_aanmelden_devices", sender: self)
            }
            else {
                let alert = UIAlertController(title: "Wrong credentials!", message: "The emailaddress or password is incorrect. Please try again.", preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
                
                self.present(alert, animated: true)
                self.txt_email.text = "";
                self.txt_wachtwoord.text = "";
            }
        }
    }
}


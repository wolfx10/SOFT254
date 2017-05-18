//
//  ViewController.swift
//  Assignment
//
//  Created by (s) Neil Cooke on 16/05/2017.
//  Copyright © 2017 (s) Neil Cooke. All rights reserved.
//

import UIKit
import Firebase
import FirebaseAuth

class ViewController: UIViewController, UIApplicationDelegate {
    
    //User Registration - Lecturer
    @IBOutlet weak var regLecUser: UITextField!
    @IBOutlet weak var regLecPass1: UITextField!
    @IBOutlet weak var regLecPass2: UITextField!
    
    //Log In - Lecturer
    @IBOutlet weak var logLecUser: UITextField!
    @IBOutlet weak var logLecPass: UITextField!
    
    //Logged In - Lecturer
    @IBOutlet weak var loggedInAs: UILabel!
    
    //Database References
    var refSessions : FIRDatabaseReference!
    var refUsers : FIRDatabaseReference!

    @IBOutlet weak var titleLabel: UILabel!
    
    //Initial Load
    override func viewDidLoad() {
        super.viewDidLoad()
        refSessions = FIRDatabase.database().reference(withPath: "Sessions")}

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    
    
    
    //Lecturer Log In
    @IBAction func logInButton(_ sender: Any) {
        
        let username = self.logLecUser.text
        let password = self.logLecPass.text

        FIRAuth.auth()?.signIn(withEmail: username!, password: password!, completion: { (user, error) in
            if (user != nil)
            {
                print ("Logged in as " + username!)
                
            }
            else
            {
                if let myError = error?.localizedDescription
                {
                    print(myError)
                }
                else
                {
                    print("Error")
                }
            }
        })
    }
    
    @IBAction func registerButton(_ sender: Any) {
        let username = self.regLecUser.text
        let password1 = self.regLecPass1.text
        let password2 = self.regLecPass2.text
        
        if(password1 == password2)
        {
            FIRAuth.auth()?.createUser(withEmail: username!, password: password1!, completion: { (user, error) in
                if (user != nil)
                {
                    print ("Account created with the email address: " + username!)
                }
                else
                {
                    if let myError = error?.localizedDescription
                    {
                        print(myError)
                    }
                    else
                    {
                        print("Error")
                    }
                }
            })
        }
        else
        {
            let alert = UIAlertController(title: "Registration Failed", message: "Passwords do not match", preferredStyle: UIAlertControllerStyle.alert)
            alert.addAction(UIAlertAction(title: "Click", style: UIAlertActionStyle.default, handler: nil))
            self.present(alert, animated: true, completion: nil)
        }
    }
    
    
    
}


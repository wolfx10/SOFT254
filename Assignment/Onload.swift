//
//  Onload.swift
//  Assignment
//
//  Created by (s) Neil Cooke on 17/05/2017.
//  Copyright © 2017 (s) Neil Cooke. All rights reserved.
//

import UIKit
import Firebase
import FirebaseAuth

class Onload: UIViewController, UIApplicationDelegate {
    
        //Database References
    var refSessions : FIRDatabaseReference!
    var refUsers : FIRDatabaseReference!
    
    //Logged In - Lecturer
    @IBOutlet weak var loggedInAs: UILabel!

    
    
    //current session
    @IBOutlet weak var sessionIdNotify: UILabel!
    
    
    
    
    //Initial Load
    override func viewDidLoad() {
        super.viewDidLoad()
        refSessions = FIRDatabase.database().reference(withPath: "Sessions")
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    @IBAction func createSession(_ sender: Any) {
        var count = 0
        refSessions.observeSingleEvent(of: .value, with: { snapshot  in
            count = Int(snapshot.childrenCount)
            count += 1
            let text = FIRAuth.auth()?.currentUser?.email
            self.refSessions.child("session\(count + 1)").setValue(["id" : count + 1, "Lecturer" : text!, "Total participants" : 0, "Orange" : 0, "Red" : 0])
            
        })
        
    }
    
    
    @IBAction func returnToLastSession(_ sender: Any) {
        
        
    }
    
    @IBAction func logOut(_ sender: Any) {
        try! FIRAuth.auth()!.signOut()
        print("\(FIRAuth.auth()?.currentUser?.email)")
    }
    
    
    
    
}


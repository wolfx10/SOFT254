//
//  lecturerSession.swift
//  Assignment
//
//  Created by (s) Drew Tulloch on 18/05/2017.
//  Copyright © 2017 (s) Neil Cooke. All rights reserved.
//

import UIKit
import Firebase
import FirebaseAuth
import FirebaseDatabase

class lecturerSession: UIViewController {
    
    var lecturerSessions = [String]()
    var refSessions1 : FIRDatabaseReference!
    var refSessions2 : FIRDatabaseReference!
    var refUsers : FIRDatabaseReference!
    var count = 0;
    var sessionIDs = [Int]()
    @IBOutlet weak var reds: UILabel!
    @IBOutlet weak var greens: UILabel!
    @IBOutlet weak var oranges: UILabel!
    @IBOutlet weak var totalParticipants: UILabel!
    @IBOutlet weak var currentSessionNotify: UILabel!
    
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        refSessions1 = FIRDatabase.database().reference()
        refSessions2 = FIRDatabase.database().reference()

        
        let query = refSessions1.child("Sessions").queryOrdered(byChild: "Lecturer").queryEqual(toValue: FIRAuth.auth()?.currentUser?.email)
        query.observe(.childAdded, with: { (snapshot) in
            if let sess =  snapshot.value as? [String:AnyObject]{
                for child in sess{
                    if(child.key == "id"){
                        
                        self.sessionIDs.append(child.value as! Int)
                        
                        let maxSess = self.sessionIDs.max()!
                        
                        let sessionAmal = "session" + ("\(maxSess)") as String
                        
                        self.refSessions2.child("Sessions").child(sessionAmal).observeSingleEvent(of: .value, with: { snapshot in
                            print(snapshot)
                            let dict = snapshot.value as! Dictionary<String, AnyObject>
                            if let author = dict["Lecturer"] as? String, let id = dict["id"], let redUsers = dict["Red"], let orangeUsers = dict["Orange"], let totalParticipants = dict["Total participants"]{
                                
                                let redInt = redUsers as! NSNumber as Int
                                let orangeInt = orangeUsers as! NSNumber as Int
                                let totalInt = totalParticipants as! NSNumber as Int
                                
                                print("author \(author) has the session ID of \(id)")
                                self.reds.text = "Currently Red: \(redUsers)"
                                self.oranges.text = "Currently Orange: \(orangeUsers)"
                                self.greens.text = "Currently Green: \(totalInt - (redInt - orangeInt))"
                                self.totalParticipants.text = "Current Participants: \(totalParticipants)"
                                self.currentSessionNotify.text = "Current Session ID: \(id)"
                            }
                        })
                        
                }
            }
            }
        })
        

        


        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

}

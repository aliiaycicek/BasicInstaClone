//
//  SettingsViewController.swift
//  BasicInstaClone
//
//  Created by Ali Ayçiçek on 13.07.2024.
//

import UIKit
import FirebaseAuth
class SettingsViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

       
    }
    
    @IBAction func logoutClicked(_ sender: Any) {
        do {
           try Auth.auth().signOut()
            self.performSegue(withIdentifier: "toViewController", sender: nil)
        }
        catch {
            print("error")
        }
    }
    
    
   

    
    
    

}

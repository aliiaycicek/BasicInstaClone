//
//  ViewController.swift
//  BasicInstaClone
//
//  Created by Ali Ayçiçek on 12.07.2024.
//

import UIKit
import FirebaseCore
import FirebaseAuth
class ViewController: UIViewController {

    @IBOutlet weak var emailText: UITextField!
    
    @IBOutlet weak var passwordText: UITextField!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
    
    }

    @IBAction func signInClicked(_ sender: Any) {
        
        if emailText.text != "" && passwordText.text != "" {
            
            Auth.auth().signIn(withEmail: emailText.text!, password: passwordText.text!)  { (authdata, error) in
                
                if error != nil {
                    self.makeAlert(titleInput: "Error", massageInput: error?.localizedDescription ?? "Error")
                }
                else
                {
                    self.performSegue(withIdentifier: "toFeedVC", sender: nil)
                }
            }
            }
            else
            {
                makeAlert(titleInput: "Error", massageInput: "Username/Password?")
            }
        
        
        
        
    }
    
    @IBAction func signUpClicked(_ sender: Any) {
        
        if emailText.text != "" && passwordText.text != "" {
            
            Auth.auth().createUser(withEmail: emailText.text!, password: passwordText.text!)  { (authdata, error) in
                
                if error != nil {
                    self.makeAlert(titleInput: "Error", massageInput: error?.localizedDescription ?? "Error")
                }
                else {
                    self.performSegue(withIdentifier: "toFeedVC", sender: nil)
                }
            }
        }
        else {
            
          makeAlert(titleInput: "Error", massageInput: "Username/Password?")
        }
       
               
    }
    func makeAlert(titleInput: String, massageInput: String ) {
        
        let alert = UIAlertController(title: titleInput, message: massageInput, preferredStyle: UIAlertController.Style.alert)
        let okButton = UIAlertAction(title: "OK", style: UIAlertAction.Style.cancel )
        
        alert.addAction(okButton)
        self.present(alert, animated: true, completion: nil)
    }
    
}


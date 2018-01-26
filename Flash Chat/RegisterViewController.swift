//
//  RegisterViewController.swift
//  Flash Chat
//
//  This is the View Controller which registers new users with Firebase
//

import UIKit
import FirebaseAuth
import SVProgressHUD

class RegisterViewController: UIViewController {
    
    
    //Pre-linked IBOutlets
    
    @IBOutlet var emailTextfield: UITextField!
    @IBOutlet var passwordTextfield: UITextField!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    
    
    @IBAction func registerPressed(_ sender: AnyObject) {
        let user = Auth.auth().currentUser;
        if (user == nil ) {
            print ("ok to register")
            let email = emailTextfield.text?.trimmingCharacters(in: .whitespacesAndNewlines)
            let password = passwordTextfield.text?.trimmingCharacters(in: .whitespacesAndNewlines)
            if (!email!.isEmpty && !password!.isEmpty) {
                
                Auth.auth().createUser(withEmail: email!, password: password!, completion: { (user, error) in
                    
                    
                    if let error = error {
                        let status = error.localizedDescription
                        SVProgressHUD.showError(withStatus: status )
                    }
                    else {
                        SVProgressHUD.showInfo(withStatus: "Registration successful")
                        self.performSegue(withIdentifier: "goToChat", sender:self)
                    }
                    
                })
                
            }
            else {
                //show user error
                SVProgressHUD.showError(withStatus: "Invalid Username/Password  ")
            }
            
            
            
        }
        else {
            print ("User already signed in debug\(user!.debugDescription)")
            self.performSegue(withIdentifier: "goToChat", sender: self)
        }
        
        
        
        
        
        
        
        
        
    } 
    
    
}

//
//  LogInViewController.swift
//  Flash Chat
//
//  This is the view controller where users login


import UIKit
import FirebaseAuth
import SVProgressHUD

class LogInViewController: UIViewController {

    //Textfields pre-linked with IBOutlets
    @IBOutlet var emailTextfield: UITextField!
    @IBOutlet var passwordTextfield: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

   
    @IBAction func logInPressed(_ sender: AnyObject) {

        
        if (!emailTextfield.text!.isEmpty && !passwordTextfield.text!.isEmpty){
            
            Auth.auth().signIn(withEmail: emailTextfield.text!, password: passwordTextfield.text!, completion: { (user, error) in
                if let error = error {
                    
                    let localErr =  "Error logging in \(error.localizedDescription)"
                    SVProgressHUD.showError(withStatus: localErr)
                }
                else {
                    self.performSegue(withIdentifier: "goToChat", sender: self)
                }
            })
            
        }
        
        
    }
    


    
}  

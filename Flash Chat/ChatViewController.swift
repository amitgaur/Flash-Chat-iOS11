//
//  ViewController.swift
//  Flash Chat
//
//  Created by Angela Yu on 29/08/2015.
//  Copyright (c) 2015 London App Brewery. All rights reserved.
//

import UIKit
import FirebaseAuth
import FirebaseDatabase
import SVProgressHUD

class ChatViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, UITextFieldDelegate {
    var messages : [Message] = [Message]()
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return messages.count;
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "customMessageCell", for: indexPath) as! CustomMessageCell
        cell.messageBody.text = messages[indexPath.row].body
        let imageView = UIImage(named: "egg", in: nil, compatibleWith: nil)
        cell.avatarImageView.image = imageView
        cell.senderUsername.text = messages[indexPath.row].sender
        return cell
        
    }
    
    
    
    // Declare instance variables here

    
    
    // We've pre-linked the IBOutlets
    @IBOutlet var heightConstraint: NSLayoutConstraint!
    @IBOutlet var sendButton: UIButton!
    @IBOutlet var messageTextfield: UITextField!
    @IBOutlet var messageTableView: UITableView!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        messageTableView.delegate = self;
        messageTableView.dataSource = self
        messageTextfield.delegate  = self
        
        
        //TODO: Set yourself as the delegate of the text field here:

        
        
        //TODO: Set the tapGesture here:
        
        

        //TODO: Register your MessageCell.xib file here:
        messageTableView.register(UINib(nibName : "MessageCell", bundle : nil), forCellReuseIdentifier: "customMessageCell")
        configureTableView()
        retreiveMessages()
        
    }

  
    
    
    //TODO: Declare tableViewTapped here:
    
    @IBAction func tapped(recognizer : UITapGestureRecognizer ){
        print ("tapped")
        messageTextfield.endEditing(true)   
    }
    
    //TODO: Declare configureTableView here:
    
    func configureTableView(){
        messageTableView.rowHeight = UITableViewAutomaticDimension
        messageTableView.estimatedRowHeight = 100
        messageTableView.separatorStyle = .none
    }
    
    ///////////////////////////////////////////
    
    //MARK:- TextField Delegate Methods
    
    

    
   
    
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
       
        UIView.animate(withDuration: 1.0, animations: {
            self.heightConstraint.constant = 310
            self.view.layoutIfNeeded()
        })
    }
    func textFieldDidEndEditing(_ textField: UITextField) {
        print("Ended editing")
        UIView.animate(withDuration: 1.0, animations: {
            self.heightConstraint.constant = 50
            self.view.layoutIfNeeded()
        })
    }
    
    
    

    
    ///////////////////////////////////////////
    
    
    //MARK: - Send & Recieve from Firebase
    
    
    
    
    
    @IBAction func sendPressed(_ sender: AnyObject) {
        messageTextfield.endEditing(true)
        messageTextfield.isEnabled = false
        sendButton.isEnabled = false
        let message = messageTextfield.text!
        let sender = Auth.auth().currentUser?.email!
        
        let dictionary : [String:String] = ["MessageBody"  : message, "Sender" : sender!]
     
        let db = Database.database().reference().child("Messages")
        db.childByAutoId().setValue(dictionary){
            (error,reference) in
            if (error != nil){
                SVProgressHUD.showError(withStatus: error.debugDescription)
            }
            else {
                self.messageTextfield.isEnabled = true
                self.sendButton.isEnabled = true
                self.messageTextfield.text = ""
                
            }
        }
       
        //messageTextfield.isEnabled = true
        
    }
    
    //TODO: Create the retrieveMessages method here:
    
    
    func saveToDb(_ message : Message) {
        
    }
    
    func retreiveMessages(){
        Database.database().reference().child("Messages").observe(.childAdded){
            (snapshot) in
            print ("\(snapshot.value.debugDescription)")
            let messageDict = snapshot.value as! Dictionary<String,String>
            let message = Message();
            message.sender = messageDict["Sender"]!
            message.body = messageDict["MessageBody"]!
            self.messages.append(message)
            self.messageTableView.reloadData()
        }
    }
    
    
    @IBAction func logOutPressed(_ sender: AnyObject) {
        do {
            try Auth.auth().signOut()
            print ("Signed user out" )
            guard (navigationController?.popToRootViewController(animated: true)) != nil
                
            else {
                return
            }
            
        }catch {
            print ("Error signing out ")
            SVProgressHUD.showError(withStatus: "We were unable to sign you out, please try again later")
        }
        
       
        
        
    }
    


}

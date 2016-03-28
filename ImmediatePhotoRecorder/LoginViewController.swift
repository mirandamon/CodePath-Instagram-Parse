//
//  LoginViewController.swift
//  Parstagram
//
//  Created by Nathan Miranda on 3/1/16.
//  Copyright © 2016 Miraen. All rights reserved.
//

import UIKit
import Parse

class LoginViewController: UIViewController, UITextFieldDelegate {
    @IBOutlet weak var usernameField: UITextField!
    @IBOutlet weak var passwordField: UITextField!
    @IBOutlet weak var signinButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        usernameField.delegate = self
        passwordField.delegate = self
        
        signinButton.layer.cornerRadius = signinButton.frame.width/5
        
        usernameField.becomeFirstResponder()
        
        // Do any additional setup after loading the view.
    }
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        if textField == usernameField {
            passwordField.becomeFirstResponder()
        }
        if textField == passwordField{
            onSignIn(UIButton)
        }
        return true
    }
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    @IBAction func onSignIn(sender: AnyObject) {
        
        
        let username = usernameField.text ?? ""
        let password = passwordField.text ?? ""
        
        PFUser.logInWithUsernameInBackground(username, password: password) { (user: PFUser?, error: NSError?) -> Void in
            if let error = error {
                if error.code == 101{
                    print(">>> Alert: error 101")
                    let alertController = UIAlertController(title: "Invalid Username \n or Password", message: "", preferredStyle: .Alert)
                    let OKAction = UIAlertAction(title: "OK", style: .Default) { (action) in
                    }
                    alertController.addAction(OKAction)
                    self.presentViewController(alertController, animated: true) {
                    }
                }else if error.code == 200{
                    print(">>> Alert: error 200")
                    let alertController = UIAlertController(title: "Username is required", message: "", preferredStyle: .Alert)
                    let OKAction = UIAlertAction(title: "OK", style: .Default) { (action) in
                        self.usernameField.becomeFirstResponder()
                    }
                    alertController.addAction(OKAction)
                    self.presentViewController(alertController, animated: true) {
                    }
                }else if error.code == 201{
                    print(">>> Alert: error 201")
                    let alertController = UIAlertController(title: "Password is required", message: "", preferredStyle: .Alert)
                    let OKAction = UIAlertAction(title: "OK", style: .Default) { (action) in
                        self.passwordField.becomeFirstResponder()
                    }
                    alertController.addAction(OKAction)
                    self.presentViewController(alertController, animated: true) {
                    }
                }else{
                    print(error.localizedDescription)
                }
            }else{
                print("User \"\(username)\" logged in successfully")
                self.performSegueWithIdentifier("loginSegue", sender: nil)
            }
        }
        
    }
    
    @IBAction func onSignUp(sender: AnyObject) {
        let newUser = PFUser()
        let username = usernameField.text ?? ""
        let password = passwordField.text ?? ""
        
        if username.isWhitespace() == true || password.isWhitespace() == true {
            if username.isWhitespace(){
                let alertController = UIAlertController(title: "Username cannot be blank", message: "", preferredStyle: .Alert)
                let OKAction = UIAlertAction(title: "OK", style: .Default) { (action) in
                    self.usernameField.becomeFirstResponder()
                }
                alertController.addAction(OKAction)
                self.presentViewController(alertController, animated: true) {
                }
            }else if password.isWhitespace(){
                let alertController = UIAlertController(title: "Password cannot be blank", message: "", preferredStyle: .Alert)
                let OKAction = UIAlertAction(title: "OK", style: .Default) { (action) in
                    self.passwordField.becomeFirstResponder()
                }
                alertController.addAction(OKAction)
                self.presentViewController(alertController, animated: true) {
                }
            }
            
        }else{
            newUser.username = username
            newUser.password = password
            newUser.signUpInBackgroundWithBlock { (success:Bool, error:NSError?) -> Void in
                if success {
                    print("User \(newUser.username!) created")
                    let alertController = UIAlertController(title: "Account Created", message: "Welcome \"\(newUser.username!)\" \nyou will now be signed in", preferredStyle: .Alert)
                    let OKAction = UIAlertAction(title: "OK", style: .Default) { (action) in
                        self.onSignIn(UIButton)
                    }
                    alertController.addAction(OKAction)
                    self.presentViewController(alertController, animated: true) {
                    }
                    
                }else{
                    print(error?.localizedDescription)
                    if error?.code == 202{
                        print(">>> Alert: error 202")
                        let alertController = UIAlertController(title: "Account already exists", message: "The name \"\(self.usernameField.text!)\" \nis already taken", preferredStyle: .Alert)
                        let OKAction = UIAlertAction(title: "OK", style: .Default) { (action) in
                            self.usernameField.becomeFirstResponder()
                        }
                        alertController.addAction(OKAction)
                        self.presentViewController(alertController, animated: true) {
                        }
                    }
                }
            }
        }
        
        
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    /*
    // MARK: - Navigation
    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
    // Get the new view controller using segue.destinationViewController.
    // Pass the selected object to the new view controller.
    }
    */
    
}

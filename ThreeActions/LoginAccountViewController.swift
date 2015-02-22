//
//  LoginAccountViewController.swift
//  ThreeActions
//
//  Created by Jason Martin on 2/21/15.
//  Copyright (c) 2015 Revolvity LLC. All rights reserved.
//

import UIKit

class LoginAccountViewController: UIViewController, UITextFieldDelegate {
    
    @IBOutlet weak var errorMessage: UILabel!
    @IBOutlet weak var exitButton: UIButton!
    @IBOutlet weak var createButton: UIButton!
    @IBOutlet weak var errorPanel: UIView!
    @IBOutlet weak var errorPanelButton: UIButton!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var usernameTextField: UITextField!
    @IBOutlet weak var progressSpinner: UIActivityIndicatorView!
    
    
    //import parseErrorDictionary
    let parseErrorDictionary = ParseErrorDictionary
    
   
    override func viewDidLoad() {
        //customize buttons
        UIViewController.buttonCreatorDismiss(errorPanelButton)
        UIViewController.buttonCreatorDismiss(exitButton)
        UIViewController.buttonCreatorAction(createButton)
        
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        self.passwordTextField.delegate = self;
        self.usernameTextField.delegate = self;
        errorPanelControl(false)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func removeModal(sender: AnyObject) {
        self.dismissViewControllerAnimated(true, completion: nil)
        
    }
    
    func textFieldShouldReturn(textField: UITextField!) -> Bool {
        self.view.endEditing(true);
        return false;
    }
    
    
    @IBAction func closeErrorPanel(sender: AnyObject) {
        errorPanelControl(false)

    }
    
    @IBAction func loginAccount(sender: AnyObject) {
        //set initial message
        errorMessage.text = "Attempting to log into your account.\n\n Accessing . . ."
        errorPanelControl(true)
        
        
        
        
        var user = PFUser()
        user.username = "JAM2015"
        user.password = "@@JAMwwwip1JAM@@"
        user.email = "revolvity@live.com"
        
        user.signUpInBackgroundWithBlock {
            (succeeded: Bool!, error: NSError!) -> Void in
            if error == nil {
                // Hooray! Let them use the app now.
                println( "User Signed Up")
            } else {
                // There's an error, so let's grab the error code and look in the ErrorDictionary
                //Optional is returned
                
                if let signinError = self.parseErrorDictionary[error.code] {
                    println("Error:\n")
                    println(signinError)
                    self.progressSpinner.stopAnimating()
                    self.errorMessage.text = signinError
                    
                } else {
                    //optional is NIL, so my error isn't defined. Return response 909090
                    if let unknownError = self.parseErrorDictionary[909090] {
                        println(unknownError)
                        self.progressSpinner.stopAnimating()
                        self.errorMessage.text = unknownError

                    }
                    
                }
            }
        }
        
        
        
        
    }
    
    func errorPanelControl(state:Bool){
        //true = show, false = hide
        if(state){
            //show things
            progressSpinner.startAnimating()
            errorPanel.hidden = false
            errorPanelButton.hidden = false
            errorMessage.hidden = false
            
        } else {
            //hide things
            progressSpinner.stopAnimating()
            errorPanel.hidden = true
            errorPanelButton.hidden = true
            errorMessage.hidden = true
        }
    }
    
    
}


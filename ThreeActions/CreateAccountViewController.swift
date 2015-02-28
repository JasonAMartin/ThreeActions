//
//  CreateAccountViewController.swift
//  ThreeActions
//
//  Created by Jason Martin on 2/21/15.
//  Copyright (c) 2015 Revolvity LLC. All rights reserved.
//

import UIKit

class CreateAccountViewController: UIViewController, UITextFieldDelegate {
    
    @IBOutlet weak var exitButton: UIButton!
    @IBOutlet weak var createButton: UIButton!
    @IBOutlet weak var errorPanel: UIView!

    @IBOutlet weak var accountCreatedContinueButton: UIButton!
    @IBOutlet weak var progressSpinner: UIActivityIndicatorView!
    @IBOutlet weak var errorPanelButton: UIButton!
    @IBOutlet weak var errorMessage: UILabel!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var usernameTextField: UITextField!
    
    //receive data from login controller :: it's either login or create
    var vcPurpose = String()
    
    //import parseErrorDictionary
    let parseErrorDictionary = ParseErrorDictionary
    let appResponseDictionary = AppResponseDictionary
    
    override func viewDidLoad() {
        //customize buttons
        //UIViewController.buttonCreatorDismiss(exitButton)
        
        exitButton.setTitleColor(UIColor.appShadyGhost(), forState: UIControlState.Normal)
        exitButton.setTitleColor(UIColor.appMidnight(), forState: UIControlState.Highlighted)
        
        UIViewController.buttonCreatorAction(createButton)
        UIViewController.buttonCreator(errorPanelButton)
        
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        self.emailTextField.delegate = self
        self.passwordTextField.delegate = self
        self.usernameTextField.delegate = self
        
        if(vcPurpose != "login") {
            vcPurpose = "create"
        }
        if(vcPurpose=="login"){
            //this view is being used to login, so hide email text field and change text on button
            self.emailTextField.hidden=true
            self.createButton.setTitle("LOGIN", forState: UIControlState.Normal)
        }
        
        //make sure response panel is hidden
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
    
    
    @IBAction func closeResponsePanel(sender: AnyObject) {
        errorPanelControl(false)
    }
    
    func loginDisplay(){
       self.emailTextField.text="ddd"
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
    
    func userSignUpValid(){
        
        errorPanelButton.hidden = true
        progressSpinner.stopAnimating()
       
        if(vcPurpose=="login"){
             errorMessage.text = appResponseDictionary["loginAccountSuccess"]
        } else {
             errorMessage.text = appResponseDictionary["createAccountSuccess"]
        }
        
        
        UIViewController.buttonCreatorAction(accountCreatedContinueButton)
        accountCreatedContinueButton.hidden = false
        
    }
    
    func createUserAccount(#username:String, #password: String, #email:String){
        
        //setup user
        var user = PFUser()
        user.username = username
        user.password = password
        user.email = email
        
        //attempt signup
        
        user.signUpInBackgroundWithBlock {
            (succeeded: Bool!, error: NSError!) -> Void in
            if error == nil {
                // Hooray! Let them use the app now.
                self.userSignUpValid()
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
    
    
    
    
    func loginUserAccount(#username:String, #password: String){
        
        //attempt signup
        
        PFUser.logInWithUsernameInBackground(username, password:password) {
            (user: PFUser!, error: NSError!) -> Void in
            if user != nil {
                // Do stuff after successful login.
                self.userSignUpValid()
            } else {
                // The login failed. 
                
                
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
    
    
    
    
    @IBAction func loginAccount(sender: AnyObject) {

        
        
        
        
        //if username,password and email are NOT empty, allow function to continue
        //deault bg for text fields is appLightBase
        
        //make sure all text fields go back to default incase this is button press 2x.
        //also make this cleaner by looking into switching BG to default when key is entered in field. 
        
        self.usernameTextField.backgroundColor = UIColor.appLightBase()
        self.passwordTextField.backgroundColor = UIColor.appLightBase()
        self.emailTextField.backgroundColor = UIColor.appLightBase()
        
        //get all values and strip spaces for counting and submitting
        
        let myUsername = self.usernameTextField.text.stringByTrimmingCharactersInSet(NSCharacterSet.whitespaceCharacterSet())
        let myPassword = self.passwordTextField.text.stringByTrimmingCharactersInSet(NSCharacterSet.whitespaceCharacterSet())
        let myEmail = self.emailTextField.text.stringByTrimmingCharactersInSet(NSCharacterSet.whitespaceCharacterSet())

        //setup continue check variable
        var canContinue = true
        
        if(countElements(myUsername)==0){
            canContinue = false
            self.usernameTextField.backgroundColor = UIColor.appGold()
            self.usernameTextField.text=""
            self.usernameTextField.placeholder = "must enter username"
        }
        
        if(countElements(myPassword)==0){
            canContinue = false
            self.passwordTextField.backgroundColor = UIColor.appGold()
            self.passwordTextField.text=""
            self.passwordTextField.placeholder = "must enter password"
        }
       
        if(countElements(myEmail)==0 && vcPurpose=="create") {
            canContinue = false
            self.emailTextField.backgroundColor = UIColor.appGold()
            self.emailTextField.text=""
            self.emailTextField.placeholder = "must enter email"
        }
        
        if(!canContinue){
            return
        }
        
        //ALL NORMAL ACTION AFTER THIS POINT
        
        //set initial message & make call to bring up error panel (should be renamed to response panel!)
        
        if(vcPurpose=="login"){
            errorMessage.text = "Attempting to log into your account.\n\n"
        }else {
            errorMessage.text = "Attempting to create your account.\n\n"
        }
        
        errorPanelControl(true)
        
        if(vcPurpose=="create"){
        createUserAccount(username: myUsername, password: myPassword, email: myEmail)
        }
        
        if(vcPurpose=="login"){
            loginUserAccount(username: myUsername, password: myPassword)
        }
        
    }

    @IBAction func continueToMainApp(sender: AnyObject) {
       let threeActionsMainAppController = storyboard?.instantiateViewControllerWithIdentifier("ThreeActionsMainApp") as ThreeActionsViewController
        
        presentViewController(threeActionsMainAppController, animated: true, completion: nil)
        
        

        
        
    }
}


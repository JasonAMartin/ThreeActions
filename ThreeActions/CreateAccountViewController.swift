//
//  CreateAccountViewController.swift
//  ThreeActions
//
//  Created by Jason Martin on 2/21/15.
//  Copyright (c) 2015 Revolvity LLC. All rights reserved.
//

import UIKit

class CreateAccountViewController: UIViewController, UITextFieldDelegate {
    
    @IBOutlet weak var errorPanel: UIView!
    @IBOutlet weak var accountCreatedContinueButton: UIButton!
    @IBOutlet weak var progressSpinner: UIActivityIndicatorView!
    @IBOutlet weak var errorPanelButton: UIButton!
    @IBOutlet weak var errorMessage: UILabel!
    
    
    
    //receive data from login controller :: it's either login or create
    var vcPurpose = String()
    
    //import parseErrorDictionary
    let parseErrorDictionary = ParseErrorDictionary
    let appResponseDictionary = AppResponseDictionary
    
    
    //making elements
    let exitButton:UIButton = UIButton(frame: CGRectMake(100, 400, 100, 50))
    let createButton:UIButton = UIButton(frame: CGRectMake(100, 400, 100, 50))
    
    var emailTextField: UITextField = UITextField(frame: CGRect(x: 0, y: 0, width: 200.00, height: 40.00));
     var passwordTextField: UITextField = UITextField(frame: CGRect(x: 0, y: 0, width: 200.00, height: 40.00));
     var usernameTextField: UITextField = UITextField(frame: CGRect(x: 0, y: 0, width: 200.00, height: 40.00));

    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        //icon for done action
        let logoFile = "3Actions02"
        let logoImage = UIImage(named: logoFile)
        let logo = UIImageView(image: logoImage!)
        
        
        exitButton.setTitle("GO BACK", forState: .Normal)
        exitButton.titleLabel!.font =  UIFont(name: "HelveticaNeue", size: 14)
        exitButton.setTitleColor(UIColor.appGhostWhite(), forState: .Normal)
        exitButton.contentHorizontalAlignment = UIControlContentHorizontalAlignment.Left
        
        createButton.titleLabel!.font =  UIFont(name: "HelveticaNeue", size: 18)
        
        view.backgroundColor = UIColor.appColorBackground()
        
        
        
        
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
        } else {
            self.createButton.setTitle("CREATE ACCOUNT", forState: UIControlState.Normal)

        }
        
        //make sure response panel is hidden
        errorPanelControl(false)

        
        emailTextField.backgroundColor = UIColor.appActionTwo()
        emailTextField.placeholder = "enter your email"
        emailTextField.layer.cornerRadius = 5.0
        emailTextField.textAlignment = .Center
        
        passwordTextField.backgroundColor = UIColor.appActionTwo()
        passwordTextField.placeholder = "enter password"
        passwordTextField.layer.cornerRadius = 5.0
        passwordTextField.textAlignment = .Center
        
        usernameTextField.backgroundColor = UIColor.appActionTwo()
        usernameTextField.placeholder = "enter username"
        usernameTextField.layer.cornerRadius = 5.0
        usernameTextField.textAlignment = .Center
        
        //add views
        
        self.view.addSubview(logo)
        self.view.addSubview(exitButton)
        self.view.addSubview(createButton)
        self.view.addSubview(emailTextField)
        self.view.addSubview(usernameTextField)
        self.view.addSubview(passwordTextField)
        
        //button funcs
        
        exitButton.addTarget(self, action: "removeModal:", forControlEvents: UIControlEvents.TouchUpInside)
        createButton.addTarget(self, action: "startUserAccountProcess:", forControlEvents: UIControlEvents.TouchUpInside)
        
        //layout

        layout(logo,view) {logo, view in
            logo.width == (view.width - 40)
            logo.height == (view.height / 3)
            logo.top == view.top + 60
            logo.left == view.left + 20
            logo.right == view.right - 20
        }
        
        layout(exitButton, view) { exitButton, view in
            exitButton.left == view.left + 30
            exitButton.bottom == view.bottom - 20
            exitButton.width == view.width
        
        }
        
        layout(createButton, view) { createButton, view in
            createButton.centerX == view.centerX
            createButton.height == 40
            createButton.width == 200
            createButton.bottom == view.bottom - 60
        }

        layout(emailTextField, logo, view) {emailTextField, logo, view in
            emailTextField.centerX == view.centerX
          //  emailTextField.centerY == view.centerY
            emailTextField.width == view.width - 80
            emailTextField.top == logo.bottom + 160
            emailTextField.height == 40
        }
        
        layout(usernameTextField, logo, view) {usernameTextField, logo, view in
            usernameTextField.centerX == view.centerX
            //  emailTextField.centerY == view.centerY
            usernameTextField.width == view.width - 80
            usernameTextField.top == logo.bottom + 40
            usernameTextField.height == 40
        }
        
        layout(passwordTextField, logo, view) {passwordTextField, logo, view in
            passwordTextField.centerX == view.centerX
            //  emailTextField.centerY == view.centerY
            passwordTextField.width == view.width - 80
            passwordTextField.top == logo.bottom + 100
            passwordTextField.height == 40
        }

    }
    
    override func viewDidLoad() {
        //customize buttons
        //UIViewController.buttonCreatorDismiss(exitButton)
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
   func removeModal(sender: AnyObject) {
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
       self.emailTextField.text="Easter Egg!"
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
            //show elements
            showHideElements(state: "show")
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
    
    
    
    
    func startUserAccountProcess(sender: AnyObject) {

        
        
        
        
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
            self.usernameTextField.backgroundColor = UIColor.appActionTwo()
            self.usernameTextField.text=""
            self.usernameTextField.placeholder = "must enter username"
        }
        
        if(countElements(myPassword)==0){
            canContinue = false
            self.passwordTextField.backgroundColor = UIColor.appActionTwo()
            self.passwordTextField.text=""
            self.passwordTextField.placeholder = "must enter password"
        }
       
        if(countElements(myEmail)==0 && vcPurpose=="create") {
            canContinue = false
            self.emailTextField.backgroundColor = UIColor.appActionTwo()
            self.emailTextField.text=""
            self.emailTextField.placeholder = "must enter email"
        }
        
        if(!canContinue){
            return
        }
        
        //ALL NORMAL ACTION AFTER THIS POINT
        
        //set initial message & make call to bring up error panel (should be renamed to response panel!)
        
        
        //hide elements
        showHideElements(state: "hide")
        
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
    
    func showHideElements(#state:String){
        
        
        if(state=="hide"){
            usernameTextField.hidden = true
            passwordTextField.hidden = true
            emailTextField.hidden = true
            createButton.hidden  = true
            exitButton.hidden = true
        }
        
        if(state=="show"){
            usernameTextField.hidden = false
            passwordTextField.hidden = false
            createButton.hidden  = false
            exitButton.hidden = false
            if(vcPurpose=="create"){
                emailTextField.hidden = false
            }
        }
    }

    @IBAction func continueToMainApp(sender: AnyObject) {
       
        let threeActionsViewControler = storyboard?.instantiateViewControllerWithIdentifier("ThreeActionsMainApp") as UITabBarController
        
        presentViewController(threeActionsViewControler, animated: true, completion: nil)
        

        
    }
}


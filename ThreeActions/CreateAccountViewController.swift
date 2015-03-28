//
//  CreateAccountViewController.swift
//  ThreeActions
//
//  Created by Jason Martin on 2/21/15.
//  Copyright (c) 2015 Revolvity LLC. All rights reserved.
//

import UIKit

class CreateAccountViewController: UIViewController, UITextFieldDelegate {
    
    @IBOutlet weak var accountCreatedContinueButton: UIButton!
    
    
    
    //receive data from login controller :: it's either login or create
    var vcPurpose = String()
    
    //import parseErrorDictionary
    let parseErrorDictionary = ParseErrorDictionary
    let appResponseDictionary = AppResponseDictionary
    
    
    //making elements
    let exitButton:UIButton = UIButton(frame: CGRectMake(100, 400, 100, 50))
    let createButton:UIButton = UIButton(frame: CGRectMake(100, 400, 100, 50))
    let errorPanel=UIView(frame: CGRectMake(100, 200, 100, 100))
    let errorPanelButton:UIButton = UIButton(frame: CGRectMake(100, 400, 100, 50))
    var errorMessage = UILabel(frame: CGRectMake(0, 0, 200, 21))
    let closeNoticeButton:UIButton = UIButton(frame: CGRectMake(100, 400, 100, 50))
    var accountSpinner : UIActivityIndicatorView = UIActivityIndicatorView(frame: CGRectMake(0,0, 50, 50)) as UIActivityIndicatorView
    let continueButton:UIButton = UIButton(frame: CGRectMake(100, 400, 100, 50))
    
    let emailTextField = UIViewController.textInput(placeholder: "Please enter a email", bgColor: UIColor.appLightBase())
    let passwordTextField = UIViewController.textInput(placeholder: "Please enter a password", bgColor: UIColor.appLightBase())
    let usernameTextField = UIViewController.textInput(placeholder: "Please enter a username", bgColor: UIColor.appLightBase())
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        //logo
        let logo = UIViewController.logo()

        
        
        exitButton.setTitle("GO BACK", forState: .Normal)
        exitButton.titleLabel!.font =  UIFont(name: "HelveticaNeue", size: 14)
        exitButton.setTitleColor(UIColor.appGhostWhite(), forState: .Normal)
        exitButton.contentHorizontalAlignment = UIControlContentHorizontalAlignment.Left
        
        
        closeNoticeButton.setTitle("GO BACK", forState: .Normal)
        closeNoticeButton.titleLabel!.font =  UIFont(name: "HelveticaNeue", size: 14)
        closeNoticeButton.setTitleColor(UIColor.appGhostWhite(), forState: .Normal)
        closeNoticeButton.contentHorizontalAlignment = UIControlContentHorizontalAlignment.Left
        closeNoticeButton.hidden = true
        
        
        createButton.titleLabel!.font =  UIFont(name: "HelveticaNeue", size: 18)
        
        continueButton.setTitle("CONTINUE", forState: .Normal)
        continueButton.titleLabel!.font =  UIFont(name: "HelveticaNeue", size: 18)
        continueButton.contentHorizontalAlignment = UIControlContentHorizontalAlignment.Center
        continueButton.hidden = true

        
        view.backgroundColor = UIColor.appColorBackground()
        
        accountSpinner.center = self.view.center
        accountSpinner.hidesWhenStopped = true
        accountSpinner.activityIndicatorViewStyle = UIActivityIndicatorViewStyle.WhiteLarge
        accountSpinner.stopAnimating()
        
        
        
        errorMessage.hidden = true
        errorMessage.textAlignment = .Center
        errorMessage.textColor = UIColor.appMidnight()
        errorMessage.numberOfLines = 6
        
        
//        exitButton.setTitleColor(UIColor.appMidnight(), forState: UIControlState.Highlighted)
        
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

        
        errorPanel.hidden = true
        errorPanel.layer.cornerRadius = 5.0
        errorPanel.backgroundColor = UIColor.appActionThree()
        errorPanel.alpha = 0.4
        
        //add views
        
        self.view.addSubview(logo)
        self.view.addSubview(exitButton)
        self.view.addSubview(createButton)
        self.view.addSubview(emailTextField)
        self.view.addSubview(usernameTextField)
        self.view.addSubview(passwordTextField)
        self.view.addSubview(errorPanel)
        self.view.addSubview(errorMessage)
        self.view.addSubview(closeNoticeButton)
        self.view.addSubview(accountSpinner)
        self.view.addSubview(continueButton)

        
        //button funcs
        
        exitButton.addTarget(self, action: "removeModal:", forControlEvents: UIControlEvents.TouchUpInside)
        createButton.addTarget(self, action: "startUserAccountProcess:", forControlEvents: UIControlEvents.TouchUpInside)
        closeNoticeButton.addTarget(self, action: "closeNotice:", forControlEvents: UIControlEvents.TouchUpInside)
        continueButton.addTarget(self, action: "continueToMainApp:", forControlEvents: UIControlEvents.TouchUpInside)
        
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
        
        layout(accountSpinner, logo, view) {accountSpinner, logo, view in
            accountSpinner.top == logo.bottom + 50
            accountSpinner.centerX == view.centerX
        }
        
        layout(closeNoticeButton, view) { closeNoticeButton, view in
            closeNoticeButton.left == view.left + 30
            closeNoticeButton.bottom == view.bottom - 20
            closeNoticeButton.width == view.width
            
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
        
        layout(errorPanel, logo, view) {errorPanel, logo, view in
            errorPanel.centerX == view.centerX
            errorPanel.width == view.width - 80
            errorPanel.top == logo.bottom + 40
            errorPanel.height == (logo.height)
        }
        
        layout(continueButton, view) { continueButton, view in
            continueButton.centerX == view.centerX
            continueButton.height == 40
            continueButton.width == 200
            continueButton.bottom == view.bottom - 100
        }
        
        
        layout(errorMessage, logo, view) {errorMessage, logo, view in
            errorMessage.top == logo.bottom + 80
            errorMessage.width == view.width - 110
            errorMessage.centerX == view.centerX
            errorMessage.height == 100
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


    
    func closeNotice(sender: AnyObject) {
        errorPanelControl(false)
    }
    
    func loginDisplay(){
       self.emailTextField.text="Easter Egg!"
    }
    
    func errorPanelControl(state:Bool){
        //true = show, false = hide
        if(state){
            //show things
            accountSpinner.startAnimating()
            errorPanel.hidden = false
            errorPanelButton.hidden = false
            errorMessage.hidden = false
            
        } else {
            //hide things
            accountSpinner.stopAnimating()
            errorPanel.hidden = true
            errorPanelButton.hidden = true
            errorMessage.hidden = true
            //show elements
            showHideElements(state: "show")
        }
    }
    
    func userSignUpValid(){
        
        errorPanelButton.hidden = true
        accountSpinner.stopAnimating()
       
        if(vcPurpose=="login"){
             errorMessage.text = appResponseDictionary["loginAccountSuccess"]
        } else {
             errorMessage.text = appResponseDictionary["createAccountSuccess"]
        }
        
        
        UIViewController.buttonCreatorAction(continueButton)
        continueButton.hidden = false
        closeNoticeButton.hidden = true
        
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
                    self.accountSpinner.stopAnimating()
                    self.errorMessage.text = signinError
                    
                } else {
                    //optional is NIL, so my error isn't defined. Return response 909090
                    if let unknownError = self.parseErrorDictionary[909090] {
                        println(unknownError)
                        self.accountSpinner.stopAnimating()
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
                var person = TAUsers()
                person.taNewSyncAll(self.userSignUpValid)
               // self.userSignUpValid()
            } else {
                // The login failed. 
                
                
                if let signinError = self.parseErrorDictionary[error.code] {
                    println("Error:\n")
                    println(signinError)
                    self.accountSpinner.stopAnimating()
                    self.errorMessage.text = signinError
                    
                } else {
                    //optional is NIL, so my error isn't defined. Return response 909090
                    if let unknownError = self.parseErrorDictionary[909090] {
                        println(unknownError)
                        self.accountSpinner.stopAnimating()
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
         //   errorMessage.text = "Attempting to log into your account.\n\n"
        }else {
          //  errorMessage.text = "Attempting to create your account.\n\n"
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
            closeNoticeButton.hidden = false
        }
        
        if(state=="show"){
            usernameTextField.hidden = false
            passwordTextField.hidden = false
            createButton.hidden  = false
            exitButton.hidden = false
            closeNoticeButton.hidden = true
            if(vcPurpose=="create"){
                emailTextField.hidden = false
            }
        }
    }

   func continueToMainApp(sender: AnyObject) {
       
        let threeActionsViewControler = storyboard?.instantiateViewControllerWithIdentifier("ThreeActionsMainApp") as UITabBarController
        
        presentViewController(threeActionsViewControler, animated: true, completion: nil)
        

        
    }
}


//
//  ViewController.swift
//  ThreeActions
//
//  Created by Jason Martin on 2/21/15.
//  Copyright (c) 2015 Revolvity LLC. All rights reserved.
//

import UIKit
import QuartzCore

class ViewController: UIViewController {


    
    //making elements
    let signupButton:UIButton = UIButton(frame: CGRectMake(100, 400, 100, 50))
    let loginButton:UIButton = UIButton(frame: CGRectMake(100, 400, 100, 50))
    
    var syncSpinner : UIActivityIndicatorView = UIActivityIndicatorView(frame: CGRectMake(0,0, 50, 50)) as UIActivityIndicatorView
    var syncNotice = UILabel(frame: CGRectMake(0, 0, 200, 21))
    
    
   //--> @IBOutlet weak var syncNotice: UILabel!
    
    func userDataSyncComplete(){
        //this is callback when the user data is synced.
        //stop & hide sync elements
       
        syncSpinner.stopAnimating()
        syncSpinner.hidden = true
        syncNotice.hidden = true
        
        //change login button to continue and show it
        loginButton.setTitle("CONTINUE", forState: UIControlState.Normal)
        loginButton.hidden = false
    }
    
    func syncUserData() {
        //check for logged in user. If so, go right to app.
        var currentUser = PFUser.currentUser()
        if currentUser != nil {
            signupButton.hidden = true
            loginButton.hidden = true
            //this is where sync should take place
            
            //show that syncing is taking place
            syncSpinner.startAnimating()
            syncSpinner.hidden = false
            syncNotice.hidden = false
            
            //sync
            var userData = TAUsers()
            let vc = ActionsTodayViewController.self
            userData.taNewSyncAll(userDataSyncComplete)
            //end sync
        }
        
    }

    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        //icon for done action
        let logoFile = "3Actions02"
        let logoImage = UIImage(named: logoFile)
        let logo = UIImageView(image: logoImage!)

        
        
        UIViewController.buttonCreatorAction(signupButton)
        UIViewController.buttonCreatorAction(loginButton)
        view.backgroundColor = UIColor.appColorBackground()
        
        loginButton.addTarget(self, action: "loginUser:", forControlEvents: UIControlEvents.TouchUpInside)
        signupButton.addTarget(self, action: "createAccount:", forControlEvents: UIControlEvents.TouchUpInside)

        loginButton.setTitle("LOGIN", forState: .Normal)
        signupButton.setTitle("CREATE ACCOUNT", forState: .Normal)
        
        loginButton.titleLabel!.font =  UIFont(name: "HelveticaNeue", size: 18)
        signupButton.titleLabel!.font =  UIFont(name: "HelveticaNeue", size: 18)
        
        syncNotice.text = "Syncing your data . . "
        syncNotice.textAlignment = .Center
        syncNotice.textColor = UIColor.appGhostWhite()
        syncNotice.hidden = true
    
        
        syncSpinner.center = self.view.center
        syncSpinner.hidesWhenStopped = true
        syncSpinner.activityIndicatorViewStyle = UIActivityIndicatorViewStyle.WhiteLarge
        syncSpinner.stopAnimating()
        
        
        self.view.addSubview(signupButton)
        self.view.addSubview(loginButton)
        self.view.addSubview(logo)
        self.view.addSubview(syncSpinner)
        self.view.addSubview(syncNotice)
        
        
        //layout
        
        layout(logo,view) {logo, view in
            logo.width == (view.width - 40)
            logo.height == (view.height / 3)
            logo.top == view.top + 60
            logo.left == view.left + 20
            logo.right == view.right - 20
        }
        
        layout(loginButton, view) { loginButton, view in
            loginButton.top == view.centerY + 80
            loginButton.width == 200
            loginButton.height == 40
            loginButton.centerX == view.centerX
        }
        
        layout(signupButton, view) { signupButton, view in
            signupButton.top == view.centerY + 140
            signupButton.width == 200
            signupButton.height == 40
            signupButton.centerX == view.centerX
        }
        
        layout(syncNotice, logo, view) {syncNotice, logo, view in
            syncNotice.top == logo.bottom + 80
            syncNotice.width == view.width
        }
        
        layout(syncSpinner, logo, view) {syncSpinner, logo, view in
            syncSpinner.top == logo.bottom + 40
            syncSpinner.centerX == view.centerX
        }
  
        
        
        syncUserData()
    }

    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        
        //set formatting for tab bar
        UITabBar.appearance().tintColor = UIColor.appActionTwo()
        UITabBar.appearance().backgroundColor = UIColor.whiteColor()
        UITabBar.appearance().barTintColor = UIColor.appColorButtonNormal()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    func loginUser(sender: AnyObject) {
        
        var currentUser = PFUser.currentUser()
       if currentUser != nil {
        
            //user is logged in, so go to main app
            
            let threeActionsViewControler = storyboard?.instantiateViewControllerWithIdentifier("ThreeActionsMainApp") as UITabBarController
            
            presentViewController(threeActionsViewControler, animated: true, completion: nil)
            
        } else {
            
        
        //user needs to login so go to login VC
            
        let createAccountViewController = storyboard?.instantiateViewControllerWithIdentifier("loginController") as CreateAccountViewController
        
        createAccountViewController.vcPurpose = "login"
         
        presentViewController(createAccountViewController, animated: true, completion: nil)
        
        
    }
    }
    
    func createAccount(sender: AnyObject){
        let createAccountViewController = storyboard?.instantiateViewControllerWithIdentifier("loginController") as CreateAccountViewController
        
        createAccountViewController.vcPurpose = "createaccount"
        
        presentViewController(createAccountViewController, animated: true, completion: nil)

    }


}


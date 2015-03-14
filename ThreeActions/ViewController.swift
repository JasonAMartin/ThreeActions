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

    @IBOutlet weak var syncSpinner: UIActivityIndicatorView!
    @IBOutlet weak var signUpButton: UIButton!
    @IBOutlet weak var loginButton: UIButton!
    
    @IBOutlet weak var syncNotice: UILabel!
    @IBOutlet weak var logoCon: NSLayoutConstraint!
    
    @IBOutlet weak var logoTop: NSLayoutConstraint!
    
    @IBOutlet weak var buttonsCon: NSLayoutConstraint!
    
    
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
            signUpButton.hidden = true
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
        
        syncUserData()


       // logoCon.constant -= view.bounds.width
        //buttonsCon.constant -= view.bounds.height


    }

    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        
       /*
UIView.animateWithDuration(0.5, delay: 0.3, options: .CurveEaseOut, animations: {
            self.logoCon.constant += self.view.bounds.width
            self.view.layoutIfNeeded()
            
            }, completion: nil)
        
        UIView.animateWithDuration(0.7, animations: {
            self.buttonsCon.constant += self.view.bounds.height
            self.view.layoutIfNeeded()
            
            }, completion: nil)
        */
      
    }
    
    override func viewDidLoad() {
        //detele test code
        
      //  var userdata = UserData(userAccount: currentUser.username)
        
       //let processData = userdata.saveData(title: "My Fun Title Goes Right HERE!", description: "This is a longer description of a bunch of stuff for this action or perhaps not at all. Who knows.", status: 0, colornumber: 1, task: "newtask")

        
        
        
      //userdata.getData(userid: currentUser.username)
        
        //end delete
        
        
        //create button look.
        //I've extended UIViewController with custom methods in UIExtentions.swift
        
        UIViewController.buttonCreatorAction(signUpButton)
        UIViewController.buttonCreatorAction(loginButton)
        
        
        
        
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    @IBAction func loginUser(sender: AnyObject) {
        
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


}


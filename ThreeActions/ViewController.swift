//
//  ViewController.swift
//  ThreeActions
//
//  Created by Jason Martin on 2/21/15.
//  Copyright (c) 2015 Revolvity LLC. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var signUpButton: UIButton!
    @IBOutlet weak var loginButton: UIButton!
     
    override func viewDidLoad() {
        
        //check for logged in user. If so, go right to app.
        var currentUser = PFUser.currentUser()
        if currentUser != nil {
            signUpButton.hidden=true
            loginButton.setTitle("CONTINUE", forState: UIControlState.Normal)
        }

        
        
        //detele test code
        
        var userdata = UserData()
        
        userdata.saveData(title: "My Fun Title Goes Right HERE!", description: "This is a longer description of a bunch of stuff for this action or perhaps not at all. Who knows.", status: 0, colornumber: 2, task: "newtask", owner: currentUser.username)
        
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


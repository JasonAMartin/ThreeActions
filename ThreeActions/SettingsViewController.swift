//
//  SettingsViewController.swift
//  ThreeActions
//
//  Created by Jason Martin on 3/21/15.
//  Copyright (c) 2015 Revolvity LLC. All rights reserved.
//

import UIKit

class SettingsViewController: UIViewController {
    
    
    //make elements
    
    let logoutButton:UIButton = UIButton(frame: CGRectMake(100, 400, 100, 50))
    var logoutLabel = UILabel(frame: CGRectMake(0, 0, 200, 21))
    
    
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
       view.backgroundColor = UIColor.appDustyWall()
        
        
        logoutButton.setTitle("LOGOUT", forState: .Normal)
        logoutButton.titleLabel!.font =  UIFont(name: "HelveticaNeue", size: 14)
        logoutButton.addTarget(self, action: "logoutUser:", forControlEvents: UIControlEvents.TouchUpInside)
        UIViewController.buttonCreatorAction(logoutButton)
        
        
        logoutLabel.text = "Logout of your account"
        logoutLabel.textAlignment = .Left
        logoutLabel.textColor = UIColor.appMidnight()
        logoutLabel.numberOfLines = 1
        
        
        
        self.view.addSubview(logoutLabel)
        self.view.addSubview(logoutButton)
        
        
        //layout
        
        layout(logoutButton, view) {logoutButton, view in
            logoutButton.right == view.right - 20
            logoutButton.top == view.top + 60
            logoutButton.width == view.width/4
        }
        
        layout(logoutLabel, logoutButton, view) {logoutLabel, logoutButton, view in
            logoutLabel.top == view.top + 60
            logoutLabel.width == (view.width/4) * 3
            logoutLabel.left == view.left + 10
            logoutLabel.centerY == logoutButton.centerY
        }
        
        
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func hideDisplay(sender:AnyObject){
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
    func logoutUser(sender:AnyObject) {
        PFUser.logOut()
        
        let loader = storyboard?.instantiateViewControllerWithIdentifier("Loader") as ViewController
        
        presentViewController(loader, animated: true, completion: nil)
    }
    
    
}


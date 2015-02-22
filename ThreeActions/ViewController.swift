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
        
        //create button look.
        //I've extended UIViewController with custom methods in UIExtentions.swift
        
        UIViewController.buttonCreatorAction(signUpButton)
        UIViewController.buttonCreatorAction(loginButton)
        
        
        //make sure Parse cached user!
        
        var currentUser = PFUser.currentUser()
        if currentUser != nil {
            println("user is here!")
            println("\n \(currentUser)")
        } else {
            println("lol come on")
        }
        
        
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}


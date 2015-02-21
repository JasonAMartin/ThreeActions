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
    
    //import parseErrorDictionary
    let parseErrorDictionary = ParseErrorDictionary
    let appColors = ColorWheel()
    
    override func viewDidLoad() {
        signUpButton.layer.cornerRadius = 5
        signUpButton.layer.borderColor = UIColor.appDarkPlum().CGColor
        signUpButton.layer.borderWidth = 0.5
        signUpButton.backgroundColor = UIColor.appPlum()
        signUpButton.setTitleColor(UIColor.appGhostWhite(), forState: UIControlState.Normal)
        signUpButton.setTitleColor(UIColor.appLightBase(), forState: UIControlState.Highlighted)


        
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        
        
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
                } else {
                    //optional is NIL, so my error isn't defined. Return response 909090
                    if let unknownError = self.parseErrorDictionary[909090] {
                        println(unknownError)
                    }
                    
                }
            }
        }
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}


//
//  LoginAccountViewController.swift
//  ThreeActions
//
//  Created by Jason Martin on 2/21/15.
//  Copyright (c) 2015 Revolvity LLC. All rights reserved.
//

import UIKit

class LoginAccountViewController: UIViewController, UITextFieldDelegate {
    
    @IBOutlet weak var exitButton: UIButton!
    @IBOutlet weak var createButton: UIButton!
    
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var usernameTextField: UITextField!
    override func viewDidLoad() {
        //customize buttons
        UIViewController.buttonCreatorDismiss(exitButton)
        UIViewController.buttonCreatorAction(createButton)
        
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        self.passwordTextField.delegate = self;
        self.usernameTextField.delegate = self;
        
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
}


//
//  NetworkViewController.swift
//  ThreeActions
//
//  Created by Jason Martin on 2/28/15.
//  Copyright (c) 2015 Revolvity LLC. All rights reserved.
//


class NetworkViewController: UIViewController {
    
    
    enum NetworkAction {
        case CreateAction, DeleteAction, Sync, Pending
    }
    
    var aDate = String()
    var aTitle = String()
    var aDescription = String()
    var aColor = Int()
    var networkingPurpose = NetworkAction.Pending
    
    
    @IBOutlet weak var networkStatusLabel: UILabel!
    @IBOutlet weak var exitButton: UIButton!
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(true)
        
        /*STEPS:
        
        1. Make sure we have all required data
        2. Do a query to see if the user has already set something for that day AND color.
        A. If so, display an error msg
        B. If not, send data and look for completion. When done, tell user and go back show continue button.
        
        */
        
        networkStatusLabel.text = "Preparing to check for item."
        
        
        //setup network call & try to save action
        var person = TAUsers()
        println("-----------\(aDate)-------")
        person.saveAction(title: aTitle, description: aDescription, status: aColor, colornumber: aColor, task: aDescription, date: aDate, responseLabel: networkStatusLabel)
                
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    @IBAction func exitModal(sender: AnyObject) {
     self.dismissViewControllerAnimated(true, completion: {});
        
    }
}

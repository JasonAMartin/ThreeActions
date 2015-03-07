//
//  NetworkViewController.swift
//  ThreeActions
//
//  Created by Jason Martin on 2/28/15.
//  Copyright (c) 2015 Revolvity LLC. All rights reserved.
//


class NetworkViewController: UIViewController {
    
    var aDate = String()
    var aTitle = String()
    var aDescription = String()
    var aColor = Int()
    
    
    @IBOutlet weak var networkStatusLabel: UILabel!
    @IBOutlet weak var exitButton: UIButton!
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(true)
        
        networkStatusLabel.text = "Preparing to check for item."
        
        
        //setup network call
        var person = TAUsers()
        println("About to check network for existance of item....\n\n")
        
     /*
if(person.checkAction(colornumber: aColor, date: aDate)) {
            networkStatusLabel.text = "Item found."
        } else {
            networkStatusLabel.text = "No item found."
        }
        */
        
        person.saveAction(title: aTitle, description: aDescription, status: aColor, colornumber: aColor, task: aDescription, date: aDate, responseLabel: networkStatusLabel)
                
    }
    
    override func viewDidLoad() {
        
        
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        exitButton.setTitle(aTitle, forState: .Normal)
        println("Date: \(aDate) \n Title: \(aTitle)\nDescription: \(aDescription)\nColor: \(aColor)")
        
        /*STEPS:
       
        1. Make sure we have all required data
        2. Do a query to see if the user has already set something for that day AND color.
            A. If so, display an error msg
            B. If not, send data and look for completion. When done, tell user and go back show continue button.
        
        */
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    @IBAction func exitModal(sender: AnyObject) {
     self.dismissViewControllerAnimated(true, completion: {});
        
    }
}

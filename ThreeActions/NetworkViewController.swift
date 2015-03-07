//
//  NetworkViewController.swift
//  ThreeActions
//
//  Created by Jason Martin on 2/28/15.
//  Copyright (c) 2015 Revolvity LLC. All rights reserved.
//


class NetworkViewController: UIViewController {
    
    let aData = String()
    var aTitle = String()
    let aDescrition = String()
    
    
    
    @IBOutlet weak var exitButton: UIButton!
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        exitButton.setTitle(aTitle, forState: .Normal)
        println(aTitle)
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    @IBAction func exitModal(sender: AnyObject) {
     self.dismissViewControllerAnimated(true, completion: {});
        
    }
}

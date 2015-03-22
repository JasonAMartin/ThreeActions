//
//  NetworkViewController.swift
//  ThreeActions
//
//  Created by Jason Martin on 2/28/15.
//  Copyright (c) 2015 Revolvity LLC. All rights reserved.
//

import UIKit
import QuartzCore

class NetworkViewController: UIViewController {
    
    
    enum NetworkAction {
        case CreateAction, DeleteAction, ModifyAction, CompleteAction, Sync, Pending
    }
    
    var aDate = String()
    var aTitle = String()
    var aDescription = String()
    var aColor = Int()
    var networkingPurpose = NetworkAction.Pending
    var callingVC = AddActionViewController()
    var objectID = ""
    
    
    //creating elements
    let exitButton:UIButton = UIButton(frame: CGRectMake(100, 400, 100, 50))
    let networkStatusLabel:UILabel = UILabel(frame: CGRectMake(100, 400, 100, 50))

    var accountSpinner : UIActivityIndicatorView = UIActivityIndicatorView(frame: CGRectMake(0,0, 50, 50)) as UIActivityIndicatorView
    
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(true)
        view.backgroundColor = UIColor.appColorBackground()
        exitButton.hidden = true
        
        //style
        ViewController.roundedButton(exitButton)
        exitButton.addTarget(self, action: "exitModal:", forControlEvents: UIControlEvents.TouchUpInside)
        
        accountSpinner.center = self.view.center
        accountSpinner.hidesWhenStopped = true
        accountSpinner.activityIndicatorViewStyle = UIActivityIndicatorViewStyle.WhiteLarge
        accountSpinner.startAnimating()
      
        
        networkStatusLabel.textColor = UIColor.appGhostWhite()
        networkStatusLabel.numberOfLines = 8
        networkStatusLabel.layer.cornerRadius = 5.0
       // networkStatusLabel.backgroundColor = UIColor.appDustyWall()
        networkStatusLabel.textAlignment = .Center
        networkStatusLabel.text = "Processing . . . "
        
        
        //logo
        let logoFile = "3Actions02"
        let logoImage = UIImage(named: logoFile)
        let logo = UIImageView(image: logoImage!)
        
        
        
        //layout
        
        self.view.addSubview(logo)
        self.view.addSubview(accountSpinner)
        self.view.addSubview(exitButton)
        self.view.addSubview(networkStatusLabel)
        
        
        layout(logo,view) {logo, view in
            logo.width == (view.width - 40)
            logo.height == (view.height / 3)
            logo.top == view.top + 60
            logo.left == view.left + 20
            logo.right == view.right - 20
        }

        layout(accountSpinner, logo, view) {accountSpinner, logo, view in
            accountSpinner.top == logo.bottom + 20
            accountSpinner.centerX == view.centerX
        }
        
        layout(networkStatusLabel, accountSpinner, view) {networkStatusLabel, accountSpinner, view in
            networkStatusLabel.top == accountSpinner.bottom + 20
            networkStatusLabel.centerX == view.centerX
            networkStatusLabel.width == view.width - 80
        }

        
        layout(exitButton,view) {exitButton, view in
            exitButton.width == 120
            exitButton.height == 30
            exitButton.bottom == view.bottom - 40
            exitButton.centerX == view.centerX
        }
        
        
        /*STEPS:
        
        1. Make sure we have all required data
        2. Do a query to see if the user has already set something for that day AND color.
        A. If so, display an error msg
        B. If not, send data and look for completion. When done, tell user and go back show continue button.
        
        */
        
        networkStatusLabel.text = "Preparing to check for item."
        
        
        //setup network call & try to save action
        var person = TAUsers()
        
        var myKey:String = aDate + "-" + toString(aColor)
    println("passing in key: \(myKey)")
        if(networkingPurpose == .CreateAction) {
            person.saveAction(title: aTitle, description: aDescription, status: 0, colornumber: aColor, task: aDescription, date: aDate, responseLabel: networkStatusLabel, complete: networkUpdateComplete)
        }else if networkingPurpose == .ModifyAction {
            person.modifyAction(objectID: objectID, title: "My New Title", description: "Some New desc right here", status: 0, colornumber: aColor, task: aDescription, date: aDate, responseLabel: networkStatusLabel, complete: networkUpdateComplete)
        }else if networkingPurpose == .DeleteAction {
            person.deleteAction(key: myKey, objectID: objectID, date: aDate, responseLabel: networkStatusLabel, complete: networkUpdateComplete)
        } else if networkingPurpose == .CompleteAction {
            person.completeAction(objectID: objectID, status: 1, date: aDate, responseLabel: networkStatusLabel, complete: networkUpdateComplete)
        }
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func networkUpdateComplete(){
        networkStatusLabel.layer.cornerRadius = 5.0
        exitButton.backgroundColor = UIColor.appDustyWall()
        exitButton.setTitle("GO BACK", forState: .Normal)
        exitButton.hidden = false
        accountSpinner.stopAnimating()
    }
    
    func networkUpdateComplete(state:Int){
        println("I totally got ovrloaded")
    }
    
   func exitModal(sender: AnyObject) {
        
      // self.parentViewController?.dismissViewControllerAnimated(true, completion: {})
        
      // self.parentViewController!.tabBarController!.selectedIndex = 2
      //  self.callingVC.tabBarController!.selectedIndex=2
        
       // self.callingVC.navigationController?.popToRootViewControllerAnimated(false)

    self.dismissViewControllerAnimated(true, completion: {})
    }
    
}

//
//  SingleActionViewController.swift
//  ThreeActions
//
//  Created by Jason Martin on 3/20/15.
//  Copyright (c) 2015 Revolvity LLC. All rights reserved.
//

import UIKit
import QuartzCore

class SingleActionViewController: UIViewController {
    
    var actionColor = 0
    var actionTitle = ""
    var actionDescription = ""
    var actionStatus = 0
    var actionDate = ""
    var deleteConfirm = 0
    var objectID = ""
    
    //make elements
    
    let exitButton:UIButton = UIButton(frame: CGRectMake(100, 400, 100, 50))
    var actionTitleLabel = UILabel(frame: CGRectMake(0, 0, 200, 21))
    var actionDescriptionLabel = UILabel(frame: CGRectMake(0, 0, 200, 21))
    var actionDateLabel = UILabel(frame: CGRectMake(0, 0, 200, 21))
    let completeButton:UIButton = UIButton(frame: CGRectMake(100, 400, 100, 50))
    let deleteButton:UIButton = UIButton(frame: CGRectMake(100, 400, 100, 50))

    
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)

        //set BG color
        if(actionColor==1) {
            view.backgroundColor = UIColor.appActionOne()
        }
        
        if(actionColor==2) {
            view.backgroundColor = UIColor.appActionTwo()
        }
        
        if(actionColor==3) {
            view.backgroundColor = UIColor.appActionThree()
        }
        
        
        //logo
        let logoFile = "3Actions02"
        let logoImage = UIImage(named: logoFile)
        let logo = UIImageView(image: logoImage!)
        
        
        exitButton.setTitle("GO BACK", forState: .Normal)
        exitButton.titleLabel!.font =  UIFont(name: "HelveticaNeue", size: 18)
        exitButton.addTarget(self, action: "hideDisplay:", forControlEvents: UIControlEvents.TouchUpInside)
        
        
        deleteButton.setTitle("DELETE ACTION", forState: .Normal)
        deleteButton.backgroundColor = UIColor.appErrorRed()
        deleteButton.addTarget(self, action: "deleteAction:", forControlEvents: UIControlEvents.TouchUpInside)
        UIViewController.roundedButton(deleteButton)
        
        actionTitleLabel.text = actionTitle
        actionTitleLabel.textAlignment = .Center
        actionTitleLabel.textColor = UIColor.appMidnight()
        actionTitleLabel.numberOfLines = 3
        

        actionDateLabel.text = actionDate
        actionDateLabel.textAlignment = .Center
        actionDateLabel.textColor = UIColor.appMidnight()
        actionDateLabel.numberOfLines = 1
        
        actionDescriptionLabel.text = actionDescription
        actionDescriptionLabel.textAlignment = .Center
        actionDescriptionLabel.textColor = UIColor.appMidnight()
        actionDescriptionLabel.numberOfLines = 6
        
        completeButton.setTitle("MARK AS COMPLETED", forState: UIControlState.Normal)
        completeButton.backgroundColor = UIColor.appDustyWall()
        UIViewController.roundedButton(completeButton)
        completeButton.addTarget(self, action: "completeAction:", forControlEvents: UIControlEvents.TouchUpInside)

        if(actionStatus != 0) {
            completeButton.hidden = true
        }
        println(actionStatus)
        
        self.view.addSubview(logo)
        self.view.addSubview(exitButton)
        self.view.addSubview(actionDescriptionLabel)
        self.view.addSubview(actionTitleLabel)
        self.view.addSubview(actionDateLabel)
        self.view.addSubview(completeButton)
        self.view.addSubview(deleteButton)
        
        
        //layout
        
        
        layout(logo,view) {logo, view in
            logo.width == (view.width - 40)
            logo.height == (view.height / 3)
            logo.top == view.top + 30
            logo.left == view.left + 20
            logo.right == view.right - 20
        }

        
        
        layout(exitButton, view) {exitButton, view in
            exitButton.bottom == view.bottom - 20
            exitButton.width == view.width
        }
        
        layout(completeButton, deleteButton, view) {completeButton, deleteButton, view in
            completeButton.bottom == deleteButton.top - 40
            completeButton.width == 200
            completeButton.height == 40
            completeButton.centerX == view.centerX
        }
        
        layout(deleteButton, view) {completeButton, view in
            completeButton.bottom == view.bottom - 80
            completeButton.width == 200
            completeButton.height == 40
            completeButton.centerX == view.centerX
        }
        
        layout(actionTitleLabel, logo, view) {actionTitleLabel, logo, view in
            actionTitleLabel.top == logo.bottom + 30
            actionTitleLabel.width == view.width
            actionTitleLabel.centerX == view.centerX
        }
        
        
        layout(actionDescriptionLabel, actionTitleLabel, view) {actionDescriptionLabel, actionTitleLabel, view in
            actionDescriptionLabel.top == actionTitleLabel.top + 40
            actionDescriptionLabel.width == view.width
            actionDescriptionLabel.centerX == view.centerX
        }
        
        
        layout(actionDateLabel, logo, view) {actionDateLabel, logo, view in
            actionDateLabel.top == logo.bottom + 10
            actionDateLabel.width == view.width
            actionDateLabel.centerX == view.centerX
        }
        
       
        
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
         println("my object: \(self.objectID)")
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
    
    func completeAction(sender:AnyObject) {
        //push data to UserData model and re-sync
        println("heythere")
    }
    
    
    func deleteAction(sender:AnyObject){
        if(self.deleteConfirm==0){
            deleteButton.setTitle("YOU SURE?", forState: .Normal)
            deleteButton.backgroundColor = UIColor.appDustyWall()
            deleteButton.setTitleColor(UIColor.appErrorRed(), forState: .Normal)
            self.deleteConfirm = 1
        } else if (self.deleteConfirm==1){
            //delete
            let networkVC = storyboard?.instantiateViewControllerWithIdentifier("networkViewController") as NetworkViewController
            networkVC.networkingPurpose = .DeleteAction
            networkVC.objectID = objectID
            networkVC.aDate = actionDate
            networkVC.aColor = actionColor
            deleteButton.hidden = true //hiding so if user goes back these are gone
            completeButton.hidden = true //hiding so if user goes back, these are gone.
            actionTitleLabel.hidden = true //same
            actionDescriptionLabel.hidden = true //same
            presentViewController(networkVC, animated: true, completion: nil)

        }
        
    }
    
}


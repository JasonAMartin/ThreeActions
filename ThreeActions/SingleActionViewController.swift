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
    
    enum CallingVC {
        case Today, Calendar
    }
    
    var callingViewController = CallingVC.Today //set default to Today actions VC

    
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

        if callingViewController == .Calendar {
                println("CALENDAR CALLED ME !!!!")
        }
        
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
        let logo = UIViewController.logo()

        
        
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
        actionTitleLabel.font = UIFont(name: "HelveticaNeue", size: 28)
        actionTitleLabel.adjustsFontSizeToFitWidth = true
        

        actionDateLabel.text = actionDate
        actionDateLabel.textAlignment = .Center
        actionDateLabel.textColor = UIColor.appMidnight()
        actionDateLabel.numberOfLines = 1
        actionDateLabel.font = UIFont(name: "HelveticaNeue", size: 12)
        
        actionDescriptionLabel.text = actionDescription
        actionDescriptionLabel.textAlignment = .Center
        actionDescriptionLabel.textColor = UIColor.appMidnight()
        actionDescriptionLabel.numberOfLines = 6
        actionDescriptionLabel.font = UIFont(name: "HelveticaNeue", size: 12)
        
        completeButton.setTitle("MARK AS COMPLETED", forState: UIControlState.Normal)
        completeButton.backgroundColor = UIColor.appDustyWall()
        UIViewController.roundedButton(completeButton)
        completeButton.addTarget(self, action: "completeAction:", forControlEvents: UIControlEvents.TouchUpInside)

        if(actionStatus != 0) {
            println("I'm seeing status of: \(actionStatus)")
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
            logo.width == (view.width / 2)
            logo.height == (view.height / 6)
            logo.top == view.top + 26
            logo.centerX == view.centerX
        }

        
        
        layout(exitButton, view) {exitButton, view in
            exitButton.bottom == view.bottom - 12
            exitButton.width == view.width
        }
        
        layout(completeButton, deleteButton, view) {completeButton, deleteButton, view in
            completeButton.bottom == deleteButton.top - 30
            completeButton.width == 200
            completeButton.height == 40
            completeButton.centerX == view.centerX
        }
        
        layout(deleteButton, view) {completeButton, view in
            completeButton.bottom == view.bottom - 60
            completeButton.width == 200
            completeButton.height == 40
            completeButton.centerX == view.centerX
        }
        
        layout(actionTitleLabel, logo, view) {actionTitleLabel, logo, view in
            actionTitleLabel.top == logo.bottom + 30
            actionTitleLabel.width == view.width - 40
            actionTitleLabel.centerX == view.centerX
        }
        
        
        layout(actionDescriptionLabel, actionTitleLabel, view) {actionDescriptionLabel, actionTitleLabel, view in
            actionDescriptionLabel.top == actionTitleLabel.bottom + 25
            actionDescriptionLabel.width == view.width - 40
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
        let networkVC = storyboard?.instantiateViewControllerWithIdentifier("networkViewController") as NetworkViewController
        networkVC.networkingPurpose = .CompleteAction
        networkVC.objectID = objectID
        networkVC.aDate = actionDate
        networkVC.aColor = actionColor
        deleteButton.hidden = true //hiding so if user goes back these are gone
        completeButton.hidden = true //hiding so if user goes back, these are gone.
        presentViewController(networkVC, animated: true, completion: nil)
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


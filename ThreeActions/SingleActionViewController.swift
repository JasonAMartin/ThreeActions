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
    
    //make elements
    
    let exitButton:UIButton = UIButton(frame: CGRectMake(100, 400, 100, 50))
    var actionTitleLabel = UILabel(frame: CGRectMake(0, 0, 200, 21))
    var actionDescriptionLabel = UILabel(frame: CGRectMake(0, 0, 200, 21))
    var actionDateLabel = UILabel(frame: CGRectMake(0, 0, 200, 21))
    let completeButton:UIButton = UIButton(frame: CGRectMake(100, 400, 100, 50))
    

    
    
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
        
        
        exitButton.setTitle("GO BACK", forState: .Normal)
        exitButton.titleLabel!.font =  UIFont(name: "HelveticaNeue", size: 18)
        exitButton.addTarget(self, action: "hideDisplay:", forControlEvents: UIControlEvents.TouchUpInside)
        
        
        
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
        completeButton.hidden = false
        UIViewController.actionSectionButton(completeButton)

        if(actionStatus != 0) {
            completeButton.hidden = true
        }
        
        
        self.view.addSubview(exitButton)
        self.view.addSubview(actionDescriptionLabel)
        self.view.addSubview(actionTitleLabel)
        self.view.addSubview(actionDateLabel)
        self.view.addSubview(completeButton)
        
        
        //layout
        
        layout(exitButton, view) {exitButton, view in
            exitButton.bottom == view.bottom - 20
            exitButton.width == view.width
        }
        
        layout(completeButton, view) {completeButton, view in
            completeButton.bottom == view.bottom - 120
            completeButton.width == 200
            completeButton.height == 40
        }
        
        
        
        layout(actionTitleLabel, view) {actionTitleLabel, view in
            actionTitleLabel.top == view.top + 20
            actionTitleLabel.width == view.width
            actionTitleLabel.centerX == view.centerX
        }
        
        
        layout(actionDescriptionLabel, view) {actionDescriptionLabel, view in
            actionDescriptionLabel.top == view.top + 80
            actionDescriptionLabel.width == view.width
            actionDescriptionLabel.centerX == view.centerX
        }
        
        
        layout(actionDateLabel, view) {actionDateLabel, view in
            actionDateLabel.top == view.top + 200
            actionDateLabel.width == view.width
            actionDateLabel.centerX == view.centerX
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
    
    
}


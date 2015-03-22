//
//  ActionsTodayViewController.swift
//  ThreeActions
//
//  Created by Jason Martin on 2/27/15.
//  Copyright (c) 2015 Revolvity LLC. All rights reserved.
//

import UIKit
import Snap

class ActionsTodayViewController: UIViewController {
    
    enum ActionState {
        case First, Second, Third
        init() {
            self = .First
        }
    }
    
    var currentState = ActionState()
    var viewingDate = ""

    //keys for DB lookup
    var dbKey1 = ""
    var dbKey2 = ""
    var dbKey3 = ""
    
    //state of actions
    var actionOneState = 0
    var actionTwoState = 0
    var actionThreeState = 0
    

    //create action labels
    
    
    //title labels
    var actionLabelOne = UILabel(frame: CGRectMake(0, 0, 200, 21))
    var actionLabelTwo = UILabel(frame: CGRectMake(0, 0, 200, 21))
    var actionLabelThree = UILabel(frame: CGRectMake(0, 0, 200, 21))
    var actionLabelDate = UILabel(frame: CGRectMake(0, 0, 200, 21))
    var hBarLabel = UILabel(frame: CGRectMake(0, 0, 200, 21))
    var quoteLabel = UILabel(frame: CGRectMake(0, 0, 200, 21))


    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(true)
        let view = self.view
        
        
        cleanData()
        viewActions()
        changeData()
          

        //style
        
        let actionButtonOne:UIButton = UIButton(frame: CGRectMake(100, 400, 100, 50))
        actionButtonOne.backgroundColor = UIColor.appActionOne()
        actionButtonOne.addTarget(self, action: "showSingleAction:", forControlEvents: UIControlEvents.TouchUpInside)
        actionButtonOne.tag = 10;
        
 
        let actionButtonTwo:UIButton = UIButton(frame: CGRectMake(100, 400, 100, 50))
        actionButtonTwo.backgroundColor = UIColor.appActionTwo()
        actionButtonTwo.addTarget(self, action: "showSingleAction:", forControlEvents: UIControlEvents.TouchUpInside)
        actionButtonTwo.tag = 11;
        
        
        let actionButtonThree:UIButton = UIButton(frame: CGRectMake(100, 400, 100, 50))
        actionButtonThree.backgroundColor = UIColor.appActionThree()
        actionButtonThree.addTarget(self, action: "showSingleAction:", forControlEvents: UIControlEvents.TouchUpInside)
        actionButtonThree.tag = 12;
        
        
        //icon for done action
        let actionImageDoneFile = "icon-star-80"
        let actionImageDone = UIImage(named: actionImageDoneFile)
        
        //icon for not done action
        let actionImageNotDoneFile = "icon-undone-80-fade"
        let actionImageNotDone = UIImage(named: actionImageNotDoneFile)
        
        
        
        //icon for forward action
        let actionViewFile = "icon-arrow"
        let actionViewImage = UIImage(named: actionViewFile)
        
        
        
        //action labels
        actionLabelOne.center = CGPointMake(160, 284)
        actionLabelOne.textAlignment = NSTextAlignment.Justified
        actionLabelOne.font = UIFont (name: "HelveticaNeue", size: 20)
        actionLabelOne.numberOfLines = 2
        
        actionLabelTwo.center = CGPointMake(160, 284)
        actionLabelTwo.textAlignment = NSTextAlignment.Justified
        actionLabelTwo.font = UIFont (name: "HelveticaNeue", size: 20)
        actionLabelTwo.numberOfLines = 2
        
        actionLabelThree.center = CGPointMake(160, 284)
        actionLabelThree.textAlignment = NSTextAlignment.Justified
        actionLabelThree.font = UIFont (name: "HelveticaNeue", size: 20)
        actionLabelThree.numberOfLines = 2
        
        actionLabelDate.center = CGPointMake(160, 284)
        actionLabelDate.textAlignment = NSTextAlignment.Center
        actionLabelDate.backgroundColor = UIColor.appColorBackground()
        actionLabelDate.textColor = UIColor.appGhostWhite()
        
        hBarLabel.backgroundColor = UIColor.appGrayFade()
        
        quoteLabel.backgroundColor = UIColor.appGrayFade()
        quoteLabel.textAlignment = NSTextAlignment.Center
        quoteLabel.textColor = UIColor.appDustyWall()
        quoteLabel.numberOfLines = 6
        quoteLabel.adjustsFontSizeToFitWidth = true
        quoteLabel.font = UIFont (name: "HelveticaNeue", size: 14)
        quoteLabel.text = randomQuote()
        
        
        let actionOneStatusIcon = setIcon(actionOneState, done: actionImageDone!, notDone: actionImageNotDone!)
        let actionTwoStatusIcon = setIcon(actionTwoState, done: actionImageDone!, notDone: actionImageNotDone!)
        let actionThreeStatusIcon = setIcon(actionThreeState, done: actionImageDone!, notDone: actionImageNotDone!)
    
        let actionIconOne = UIImageView(image: actionOneStatusIcon)
        let actionIconTwo = UIImageView(image: actionTwoStatusIcon)
        let actionIconThree = UIImageView(image: actionThreeStatusIcon)
        
        let actionViewOne = UIImageView(image: actionViewImage!)
        let actionViewTwo = UIImageView(image: actionViewImage!)
        let actionViewThree = UIImageView(image: actionViewImage!)
        
        actionIconOne.frame = CGRect(x: 0, y: 0, width: 100, height: 200)
        actionIconOne.contentMode = UIViewContentMode.ScaleToFill
        actionIconTwo.frame = CGRect(x: 0, y: 0, width: 100, height: 200)
        actionIconTwo.contentMode = UIViewContentMode.ScaleToFill
        actionIconThree.frame = CGRect(x: 0, y: 0, width: 100, height: 200)
        actionIconThree.contentMode = UIViewContentMode.ScaleToFill
        
        
        actionViewOne.frame = CGRect(x: 0, y: 0, width: 100, height: 200)
        actionViewOne.contentMode = UIViewContentMode.ScaleToFill
        actionViewOne.alpha = 0.6
        actionViewTwo.frame = CGRect(x: 0, y: 0, width: 100, height: 200)
        actionViewTwo.contentMode = UIViewContentMode.ScaleToFill
        actionViewTwo.alpha = 0.6
        actionViewThree.frame = CGRect(x: 0, y: 0, width: 100, height: 200)
        actionViewThree.contentMode = UIViewContentMode.ScaleToFill
        actionViewThree.alpha = 0.6
        
        //create 3 icons spaces
        
        
        
//put these in layer order
        
        self.view.addSubview(actionButtonOne)
        self.view.addSubview(actionButtonTwo)
        self.view.addSubview(actionButtonThree)

        self.view.addSubview(actionIconOne)
        self.view.addSubview(actionIconTwo)
        self.view.addSubview(actionIconThree)
        self.view.addSubview(actionLabelOne)
        self.view.addSubview(actionLabelTwo)
        self.view.addSubview(actionLabelThree)
        self.view.addSubview(actionLabelDate)
        self.view.addSubview(hBarLabel)
    
        self.view.addSubview(actionViewOne)
        self.view.addSubview(actionViewTwo)
        self.view.addSubview(actionViewThree)
        self.view.addSubview(quoteLabel)
        
        
        layout(actionButtonOne, view) { actionButtonOne, view in
            actionButtonOne.top == view.top
            actionButtonOne.left == view.left
            actionButtonOne.width == view.width
            actionButtonOne.height == (view.height/4)
        }
        
        layout(actionLabelDate, view) { actionLabelDate, view in
            actionLabelDate.width == view.width
            actionLabelDate.height == 20
            actionLabelDate.top == view.bottom - 20
        }
        
    
        layout(actionIconOne, actionButtonOne) { imageView, actionButtonOne in
            imageView.width  == 40
            imageView.height == 40
            imageView.top == actionButtonOne.centerY - 20
            imageView.left == imageView.superview!.left + 10
        }
        
        layout(actionViewOne, actionButtonOne) { imageView, actionButtonOne in
            imageView.width  == 20
            imageView.height == 20
            imageView.top == actionButtonOne.centerY - 10
            imageView.right == imageView.superview!.right - 10
        }
        
        
        layout(actionViewTwo, actionButtonTwo) { imageView, actionButtonTwo in
            imageView.width  == 20
            imageView.height == 20
            imageView.top == actionButtonTwo.centerY - 10
            imageView.right == imageView.superview!.right - 10
        }
        
        layout(actionViewThree, actionButtonThree) { imageView, actionButtonThree in
            imageView.width  == 20
            imageView.height == 20
            imageView.top == actionButtonThree.centerY - 10
            imageView.right == imageView.superview!.right - 10
        }
        
        
        layout(hBarLabel, view) { hBarLabel, view in
            hBarLabel.width == 1
            hBarLabel.height == (view.height/4) * 3
            hBarLabel.left == view.left + 60
        }
      
        
        layout(actionButtonTwo, actionButtonOne, view) { actionButtonTwo, actionButtonOne, view in
            actionButtonTwo.top == actionButtonOne.bottom
            actionButtonTwo.left == view.left
            actionButtonTwo.width == view.width
            actionButtonTwo.height == (view.height/4)
        }
        
        
        layout(actionButtonThree, actionButtonTwo, view) { actionButtonThree, actionButtonTwo, view in
            actionButtonThree.top == actionButtonTwo.bottom
            actionButtonThree.left == view.left
            actionButtonThree.width == view.width
            actionButtonThree.height == (view.height/4)
        }
        
        layout(quoteLabel, actionButtonThree, view) { quoteLabel, actionButtonThree, view in
            quoteLabel.top == actionButtonThree.bottom
            quoteLabel.left == view.left
            quoteLabel.width == view.width
            quoteLabel.height == (view.height/4) - 20
        }
        
        
        layout(actionIconTwo, actionButtonTwo) { imageView, actionButtonTwo in
            imageView.width  == 40
            imageView.height == 40
            imageView.top == actionButtonTwo.centerY - 20
            imageView.left == imageView.superview!.left + 10
        }
        
        layout(actionIconThree, actionButtonThree) { imageView, actionButtonThree in
            imageView.width  == 40
            imageView.height == 40
            imageView.top == actionButtonThree.centerY - 20
            imageView.left == imageView.superview!.left + 10
        }
        
        layout(actionLabelOne, actionButtonOne, view) {actionLabelOne, actionButtonOne, view in
            actionLabelOne.top == actionButtonOne.centerY - 10
            actionLabelOne.left == view.left + 80
            actionLabelOne.width == (view.width / 6) * 3.8
        }
        
        layout(actionLabelTwo, actionButtonTwo, view) {actionLabelTwo, actionButtonTwo, view in
            actionLabelTwo.top == actionButtonTwo.centerY - 10
            actionLabelTwo.left == view.left + 80
            actionLabelTwo.width == (view.width / 6) * 3.8
        }
        
        layout(actionLabelThree, actionButtonThree, view) {actionLabelThree, actionButtonThree, view in
            actionLabelThree.top == actionButtonThree.centerY - 10
            actionLabelThree.left == view.left + 80
            actionLabelThree.width == (view.width / 6) * 3.8
        }
        
        
        //END CARTOGRAPHY
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    func showSingleAction(sender: AnyObject){
        
        var state = false
        var actionColor = 0
        var actionTitle = ""
        var actionDescription = ""
        var actionStatus = 44
        var actionDate = ""
        var myDBKey = self.dbKey1
        var objectID = ""
        
        if let tag = sender.tag {
            state = true
            if(tag == 10) {
                actionColor = 1
                myDBKey = self.dbKey1
            }
            if(tag == 11) {
                actionColor = 2
                myDBKey = self.dbKey2
            }
            if(tag == 12) {
                actionColor = 3
                myDBKey = self.dbKey3
            }
        }
        
        
        if let cdActionTitle = TAUsers.sharedInstance.actionDB[myDBKey]?.valueForKey("actionTitle") {
            actionTitle = toString(cdActionTitle)
        }
        
        if let cdActionDescription = TAUsers.sharedInstance.actionDB[myDBKey]?.valueForKey("actionDescription") {
            actionDescription = toString(cdActionDescription)
        }
        
        
        if let cdActionStatus = TAUsers.sharedInstance.actionDB[myDBKey]?.valueForKey("actionStatus") {
            actionStatus = cdActionStatus.integerValue
        }
        
        if let cdActionDate = TAUsers.sharedInstance.actionDB[myDBKey]?.valueForKey("actionDate") {
            actionDate = toString(cdActionDate)
        }
        
        if let cdObjectID = TAUsers.sharedInstance.actionDB[myDBKey]?.objectId {
            objectID = toString(cdObjectID)
        }
        
        if(state && actionTitle != "" && actionDescription != "") {
            let singleActionVC = storyboard?.instantiateViewControllerWithIdentifier("SingleActionViewController") as SingleActionViewController
            singleActionVC.actionColor = actionColor
            
            singleActionVC.actionTitle = actionTitle
            singleActionVC.actionDescription = actionDescription
            singleActionVC.actionStatus = actionStatus
            singleActionVC.actionDate = actionDate
            singleActionVC.actionColor = actionColor
            singleActionVC.objectID = objectID
            
            presentViewController(singleActionVC, animated: true, completion: nil)
        } else {
            
            //noting is here so go to add actions vc!
            
            //let addActionVC = storyboard?.instantiateViewControllerWithIdentifier("AddAction") as AddActionViewController
            
           // addActionVC.passActionColor = actionColor
           let vc = AddActionViewController()
            vc.passActionColor = actionColor
            
            tabBarController?.selectedIndex = 1
        
          //  addActionVC.modalTransitionStyle = UIModalTransitionStyle.FlipHorizontal
            
          //  presentViewController(addActionVC, animated: true, completion: nil)

        }
    }
    
    
    func changeData(){
        var myKey = ""
        
        for index in 1...3 {
            
            if(index==1){
                myKey = self.dbKey1
                
                if let cdActionTitle = TAUsers.sharedInstance.actionDB[myKey]?.valueForKey("actionTitle") {
                    println("inside 1 -- \(cdActionTitle)")
                    self.actionLabelOne.text = toString(cdActionTitle)
                }
                
                if let cdActionStatus = TAUsers.sharedInstance.actionDB[myKey]?.valueForKey("actionStatus") {
                    actionOneState = cdActionStatus as Int
                }
                

            } else if (index==2){
                myKey = self.dbKey2
                
                if let cdActionTitle = TAUsers.sharedInstance.actionDB[myKey]?.valueForKey("actionTitle") {
                    println("inside 2 -- \(cdActionTitle)")

                    self.actionLabelTwo.text = toString(cdActionTitle)
                }
                if let cdActionStatus = TAUsers.sharedInstance.actionDB[myKey]?.valueForKey("actionStatus") {
                    actionTwoState = cdActionStatus as Int
                }
                
                
            } else if (index==3){
                myKey = self.dbKey3
                if let cdActionTitle = TAUsers.sharedInstance.actionDB[myKey]?.valueForKey("actionTitle") {
                    println("inside 3 -- \(cdActionTitle)")

                    self.actionLabelThree.text = toString(cdActionTitle)
                }
                if let cdActionStatus = TAUsers.sharedInstance.actionDB[myKey]?.valueForKey("actionStatus") {
                    actionThreeState = cdActionStatus as Int
                }
                
            }
            
        }
        

    
    //   println( TAUsers.sharedInstance.actionDB[myKey]?.valueForKey("actionTitle") as String)
        
    }
    
    func setIcon(status: Int, done: UIImage, notDone: UIImage) -> UIImage {
        
        if(status==0){
            return notDone
        } else if (status==1){
            return done
        } else {
            return notDone
        }
        
    }
    
    func cleanData(){
        // setting all items to empty on load to prevent deleted items from re-showing
        actionLabelOne.text = ""
        actionLabelTwo.text = ""
        actionLabelThree.text = ""
        actionLabelDate.text = ""
    }
    
    func viewActions(){
        
        var queryDate = self.viewingDate
        var labelDate = queryDate
        
        if(queryDate == ""){
            let today = NSDate()
            let customFormat = NSDateFormatter()
            //formatter.timeStyle = .ShortStyle
            customFormat.dateStyle = .ShortStyle
            queryDate = customFormat.stringFromDate(today)
        }
        
        //get 3 actions for today
        self.dbKey1 = queryDate+"-1"
        self.dbKey2 = queryDate+"-2"
        self.dbKey3 = queryDate+"-3"
        
        //set label date
        
        let todayLabel = NSDate()
        let customFormat = NSDateFormatter()
        customFormat.dateStyle = .ShortStyle
        queryDate = customFormat.stringFromDate(todayLabel)
        
        if(todayLabel == queryDate){
            labelDate = "TODAY"
        } else {
            labelDate = queryDate
        }
        
        
        self.actionLabelDate.text = labelDate
        
    }
    
    func randomQuote() -> String {
        let quoteCount = QuoteDictionary.count
        let randomNumber = Int(arc4random_uniform(UInt32(quoteCount)))
        var key : String = Array(QuoteDictionary.keys)[randomNumber]
        var speaker = QuoteDictionary[key]
        var masterQuote = key
        
        if let quoteSpeaker = speaker? {
            masterQuote = key + "\n" + quoteSpeaker
        }
        return masterQuote
    }
    
}

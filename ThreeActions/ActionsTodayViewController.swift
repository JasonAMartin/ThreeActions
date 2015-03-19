//
//  ActionsTodayViewController.swift
//  ThreeActions
//
//  Created by Jason Martin on 2/27/15.
//  Copyright (c) 2015 Revolvity LLC. All rights reserved.
//

//TODO: I'd like to make it so the default action that shows is either action 1 OR the next action not done. So if action 1 is done, then action 2 is shown. If action 2 done then 3 and if all 3 are done, just show default.

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
    
    @IBOutlet weak var actionThreeButton: UIButton!
    @IBOutlet weak var actionDateLabel: UILabel!
    @IBOutlet weak var actionOneButton: UIButton!
    @IBOutlet weak var actionTwoButton: UIButton!
    @IBOutlet weak var actionOneTitle: UILabel!
    @IBOutlet weak var actionTwoTitle: UILabel!
    @IBOutlet weak var actionThreeTitle: UILabel!
    
    @IBOutlet weak var actionOneImage: UIImageView!
    @IBOutlet weak var actionTwoImage: UIImageView!
    @IBOutlet weak var actionThreeImage: UIImageView!
    
    
    @IBOutlet weak var actionOneArrow: UIImageView!
    @IBOutlet weak var actionTwoArrow: UIImageView!
    @IBOutlet weak var actionThreeArrow: UIImageView!
    
    
    //create action labels
    
    
    
    //title labels
    var actionLabelOne = UILabel(frame: CGRectMake(0, 0, 200, 21))
    var actionLabelTwo = UILabel(frame: CGRectMake(0, 0, 200, 21))
    var actionLabelThree = UILabel(frame: CGRectMake(0, 0, 200, 21))
    var actionLabelDate = UILabel(frame: CGRectMake(0, 0, 200, 21))

    
    
    
    
    
    
    
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
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(true)
        
        let view = self.view
        
        //CARTOGRAPHY
        
        let actionButtonOne:UIButton = UIButton(frame: CGRectMake(100, 400, 100, 50))
        actionButtonOne.backgroundColor = UIColor.appActionOne()
        actionButtonOne.addTarget(self, action: "buttonAction:", forControlEvents: UIControlEvents.TouchUpInside)
        actionButtonOne.tag = 10;
        
 
        let actionButtonTwo:UIButton = UIButton(frame: CGRectMake(100, 400, 100, 50))
        actionButtonTwo.backgroundColor = UIColor.appActionTwo()
        actionButtonTwo.addTarget(self, action: "buttonAction:", forControlEvents: UIControlEvents.TouchUpInside)
        actionButtonTwo.tag = 11;
        
        
        let actionButtonThree:UIButton = UIButton(frame: CGRectMake(100, 400, 100, 50))
        actionButtonThree.backgroundColor = UIColor.appActionThree()
        actionButtonThree.addTarget(self, action: "buttonAction:", forControlEvents: UIControlEvents.TouchUpInside)
        actionButtonThree.tag = 12;
        
        
        //icon for done action
        let actionImageDoneFile = "icon-star-80"
        let actionImageDone = UIImage(named: actionImageDoneFile)
        
        //action labels
        actionLabelOne.center = CGPointMake(160, 284)
        actionLabelOne.textAlignment = NSTextAlignment.Center
        actionLabelTwo.center = CGPointMake(160, 284)
        actionLabelTwo.textAlignment = NSTextAlignment.Center
        actionLabelThree.center = CGPointMake(160, 284)
        actionLabelThree.textAlignment = NSTextAlignment.Center
        actionLabelDate.center = CGPointMake(160, 284)
        actionLabelDate.textAlignment = NSTextAlignment.Center
        actionLabelDate.backgroundColor = UIColor.appColorBackground()
        actionLabelDate.textColor = UIColor.appGhostWhite()
        
    
        let actionIconOne = UIImageView(image: actionImageDone!)
        let actionIconTwo = UIImageView(image: actionImageDone!)
        let actionIconThree = UIImageView(image: actionImageDone!)
        
        actionIconOne.frame = CGRect(x: 0, y: 0, width: 100, height: 200)
        actionIconOne.contentMode = UIViewContentMode.ScaleToFill
        actionIconTwo.frame = CGRect(x: 0, y: 0, width: 100, height: 200)
        actionIconTwo.contentMode = UIViewContentMode.ScaleToFill
        actionIconThree.frame = CGRect(x: 0, y: 0, width: 100, height: 200)
        actionIconThree.contentMode = UIViewContentMode.ScaleToFill
        
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

        
        layout(actionButtonOne, view) { actionButtonOne, view in
            actionButtonOne.top == view.top
            actionButtonOne.left == view.left
            actionButtonOne.width == view.width
            actionButtonOne.height == (view.height/3)
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
        
      
        
        layout(actionButtonTwo, actionButtonOne, view) { actionButtonTwo, actionButtonOne, view in
            actionButtonTwo.top == actionButtonOne.bottom
            actionButtonTwo.left == view.left
            actionButtonTwo.width == view.width
            actionButtonTwo.height == (view.height/3)
        }
        
        
        layout(actionButtonThree, actionButtonTwo, view) { actionButtonThree, actionButtonTwo, view in
            actionButtonThree.top == actionButtonTwo.bottom
            actionButtonThree.left == view.left
            actionButtonThree.width == view.width
            actionButtonThree.height == (view.height/3)
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
            actionLabelOne.left == view.left + 60
            actionLabelOne.width == 180
        }
        
        layout(actionLabelTwo, actionButtonTwo, view) {actionLabelTwo, actionButtonTwo, view in
            actionLabelTwo.top == actionButtonTwo.centerY - 10
            actionLabelTwo.left == view.left + 60
            actionLabelTwo.width == 180
        }
        
        layout(actionLabelThree, actionButtonThree, view) {actionLabelThree, actionButtonThree, view in
            actionLabelThree.top == actionButtonThree.centerY - 10
            actionLabelThree.left == view.left + 60
            actionLabelThree.width == 180
        }
        
        /*
        layout(actionOneButton, actionOneImage, view){ actionOneButton, actionOneImage, view in
            actionOneButton.top == view.top + 20
            actionOneButton.width == view.width
            actionOneButton.height == (view.height-40)/3
            actionOneImage.top == view.top
        }
        
        layout(actionOneImage, view) { actionOneImage, view in
            actionOneImage.top == view.top + 200
            actionOneImage.left == view.left + 50
            
        }
        
        layout(imageView, actionOneButton, view) { imageView, actionOneButton, view in
            var demo = actionOneButton.top
                imageView.top == demo
            imageView.left == view.left + 80
        }
        
        layout(actionOneButton, actionTwoButton) { actionOneButton, actionTwoButton in
            
            actionTwoButton.top == actionOneButton.bottom
            actionTwoButton.width == actionOneButton.width
            actionTwoButton.height == actionOneButton.height
            
        }
        
        layout(actionTwoButton, actionThreeButton) { actionTwoButton, actionThreeButton in
            
            actionThreeButton.width == actionTwoButton.width
            actionThreeButton.height == actionTwoButton.height
            actionThreeButton.top == actionTwoButton.bottom
            
        }
        
        layout(actionThreeButton, actionDateLabel) { actionThreeButton, actionDateLabel in
            
            actionDateLabel.width == actionThreeButton.width
            actionDateLabel.height == 20
            actionDateLabel.top == actionThreeButton.bottom
            
        }
    
        
        layout(actionTwoImage, actionThreeImage) {actionTwoImage, actionThreeImage in
            
            actionThreeImage.top == actionTwoImage.bottom + 100
            actionThreeImage.left == actionTwoImage.left
            
        }
*/

        
        //END CARTOGRAPHY
        
        
       /*
//formatting
        actionOneTitle.textColor = UIColor.appColorBackground()
         actionTwoTitle.textColor = UIColor.blackColor()
         actionThreeTitle.textColor = UIColor.blackColor()
        actionOneButton.backgroundColor = UIColor.appActionOne()
        actionTwoButton.backgroundColor = UIColor.appActionTwo()
        actionThreeButton.backgroundColor = UIColor.appActionThree()
        
        actionOneTitle.text = actionOneTitle.text?.uppercaseString
        actionTwoTitle.text = actionTwoTitle.text?.uppercaseString
        actionThreeTitle.text = actionThreeTitle.text?.uppercaseString
        
        actionOneImage.image = UIImage(named: "icon-star-80")
        actionTwoImage.image = UIImage(named: "icon-undone-80-fade")
        actionThreeImage.image = UIImage(named: "icon-star-80")
       */
        viewActions()
        swapActions()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    @IBAction func goNext(sender: AnyObject) {
        
        //switch state
            switch currentState {
            case .First:
               currentState = .Second
            case .Second:
                currentState = .Third
            case .Third:
                currentState = .First
            default:
                currentState = .Second
            }
        
        swapActions()
    }
    
    @IBAction func goPrevious(sender: AnyObject) {
        switch currentState {
        case .First:
            currentState = .Third
        case .Second:
            currentState = .First
        case .Third:
            currentState = .Second
        default:
            currentState = .Third
        }
        swapActions()
    }
    
    
    func changeData(slot:Int){
        var myKey = ""
        
        for index in 1...3 {
            
            if(index==1){
                println("first item")
                myKey = self.dbKey1
                println("key: \(myKey)")
                
                if let cdActionTitle = TAUsers.sharedInstance.actionDB[myKey]?.valueForKey("actionTitle") {
                    println("I am inside")
                    self.actionLabelOne.text = toString(cdActionTitle)
                    println(toString(cdActionTitle))
                }
                
                if let cdActionStatus = TAUsers.sharedInstance.actionDB[myKey]?.valueForKey("actionStatus") {
                    //println(actionTitle)
                }
                

            } else if (index==2){
                myKey = self.dbKey2
                
                if let cdActionTitle = TAUsers.sharedInstance.actionDB[myKey]?.valueForKey("actionTitle") {
                    self.actionLabelTwo.text = toString(cdActionTitle)
                }
                if let cdActionStatus = TAUsers.sharedInstance.actionDB[myKey]?.valueForKey("actionStatus") {
                    //println(actionTitle)
                }
                
                
            } else if (index==3){
                myKey = self.dbKey3
                if let cdActionTitle = TAUsers.sharedInstance.actionDB[myKey]?.valueForKey("actionTitle") {
                    self.actionLabelThree.text = toString(cdActionTitle)
                }
                if let cdActionStatus = TAUsers.sharedInstance.actionDB[myKey]?.valueForKey("actionStatus") {
                    //println(actionTitle)
                }
                
            }
            
        }
        

    
    //   println( TAUsers.sharedInstance.actionDB[myKey]?.valueForKey("actionTitle") as String)
        
    }
    
    
    func swapActions(){
        //this function is handling display and formatting as the user views actions 1,2,3
        
        switch currentState {
        case .First:
            changeData(1)
        case .Second:
            changeData(2)
        case .Third:
            changeData(3)
        default:
            changeData(1)
        
        }
    }
    
}

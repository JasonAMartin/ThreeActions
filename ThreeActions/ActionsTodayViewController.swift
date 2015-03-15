//
//  ActionsTodayViewController.swift
//  ThreeActions
//
//  Created by Jason Martin on 2/27/15.
//  Copyright (c) 2015 Revolvity LLC. All rights reserved.
//

//TODO: I'd like to make it so the default action that shows is either action 1 OR the next action not done. So if action 1 is done, then action 2 is shown. If action 2 done then 3 and if all 3 are done, just show default.

import UIKit

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
    
    @IBOutlet weak var actionTitle: UILabel!
    @IBOutlet weak var nextButton: UIButton!
    @IBOutlet weak var previousButton: UIButton!
    
    @IBOutlet weak var actionDetails: UITextView!

    
    func viewActions(){
        
        var queryDate = self.viewingDate
        
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
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(true)
        //formatting
        actionTitle.textColor = UIColor.appColorBackground()
        actionDetails.textColor = UIColor.appColorBackground()
        
        viewActions()
        swapActions()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //formatting
        actionTitle.text = actionTitle.text?.uppercaseString
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
        
        if(slot==1){
            myKey = self.dbKey1
            view.backgroundColor = UIColor.appActionOne()
            actionDetails.backgroundColor = UIColor.appActionOne()
            nextButton.setTitleColor(UIColor.appActionTwo(), forState: UIControlState.Normal)
            previousButton.setTitleColor(UIColor.appActionThree(), forState: UIControlState.Normal)
            nextButton.backgroundColor = UIColor.appActionTwo()
            previousButton.backgroundColor = UIColor.appActionThree()
        } else if (slot==2){
            myKey = self.dbKey2
            view.backgroundColor = UIColor.appActionTwo()
            actionDetails.backgroundColor = UIColor.appActionTwo()
            nextButton.setTitleColor(UIColor.appActionThree(), forState: UIControlState.Normal)
            previousButton.setTitleColor(UIColor.appActionOne(), forState: UIControlState.Normal)
            nextButton.backgroundColor = UIColor.appActionThree()
            previousButton.backgroundColor = UIColor.appActionOne()

        } else if (slot==3){
            myKey = self.dbKey3
            view.backgroundColor = UIColor.appActionThree()
            actionDetails.backgroundColor = UIColor.appActionThree()
            nextButton.setTitleColor(UIColor.appActionOne(), forState: UIControlState.Normal)
            previousButton.setTitleColor(UIColor.appActionTwo(), forState: UIControlState.Normal)
            nextButton.backgroundColor = UIColor.appActionOne()
            previousButton.backgroundColor = UIColor.appActionTwo()

        }
        
        
        
        if let cdActionTitle = TAUsers.sharedInstance.actionDB[myKey]?.valueForKey("actionTitle") {
            self.actionTitle.text = toString(cdActionTitle)
        }
        
        if let cdActionColor = TAUsers.sharedInstance.actionDB[myKey]?.valueForKey("actionColor") {
            //self.actionTitle.text = toString(cdActionTitle)
        }
        
        if let cdActionDescription = TAUsers.sharedInstance.actionDB[myKey]?.valueForKey("actionDescription") {
            self.actionDetails.text = toString(cdActionDescription)
        }
        
        if let cdActionStatus = TAUsers.sharedInstance.actionDB[myKey]?.valueForKey("actionStatus") {
            println(actionTitle)
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

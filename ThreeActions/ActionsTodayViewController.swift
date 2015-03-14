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
    
    //creating 3 dictionaries, which will hold each color's action in whatever order needed
    var actionOne = [String:String]()
    var actionTwo = [String:String]()
    var actionThree = [String:String]()
    
    var currentState = ActionState()
    var viewingDate = ""
    
    @IBOutlet weak var actionTitle: UILabel!
    @IBOutlet weak var nextButton: UIButton!
    @IBOutlet weak var previousButton: UIButton!
    
    @IBOutlet weak var actionDetails: UITextView!
    
    
    func actionData(#actionDate:String){
        //get the 3 actions for the date specified
        var queryDate = actionDate
        if(actionDate==""){
            //actionDate wasn't passed, so show today
            let now = NSDate()
            let formatMyDate = NSDateFormatter()
            formatMyDate.dateStyle = .ShortStyle
            queryDate = formatMyDate.stringFromDate(now)
        }
        
        //remove
        queryDate = "3/22/15"
        var userData = TAUsers()
        var query = PFQuery(className:"UserActions")
        query.fromLocalDatastore()
        query.whereKey("owner", equalTo:userData.userAccount)
        query.whereKey("actionDate", equalTo: queryDate)
        query.findObjectsInBackgroundWithBlock {
            (objects: [AnyObject]!, error: NSError!) -> Void in
            if error == nil {
                // The find succeeded.
                NSLog("Daddy retrieved \(objects.count) actions.")
                // Do something with the found objects
                for object in objects {
                    //object(s) found so set it up.
                    
                }
                
                //if objects = 0, hide stuff, change display
                if(objects.count<=0){
                    
                    self.actionTitle.text = "No actions for today!"
                    self.nextButton.hidden = true
                    self.previousButton.hidden = true
                    self.actionDetails.hidden = true
                    
                }
                
                
            }
        }
    }
    
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(true)
        
        actionData(actionDate: viewingDate)
        
        /*
        STEPS
            1. Grab data for today
            2. Display first undone action in order of 1,2,3
                A. If no undone action exists, display 1.
        */
        
        //pass in actionTitle, nextButton, previousButton, actionDetails
        
     //  var actionData = TAUsers()
        //actionData.taPullLocal()
      // var todayInfo = actionData.getActionsData(date: "3/14/15", actionTitle: actionTitle, nextButton: nextButton, previousButton: previousButton, actionDetails: actionDetails)
              //actionData.taNewSyncAll()
    }
    
    
    
    override func viewDidLoad() {
        
        actionTitle.text = actionTitle.text?.uppercaseString
        
        //set button colors for today view to app colors
        
        view.backgroundColor = UIColor.appActionOne()
        
        actionDetails.backgroundColor = UIColor.appActionOne()
        
        nextButton.setTitleColor(UIColor.appActionTwo(), forState: UIControlState.Normal)
        previousButton.setTitleColor(UIColor.appActionThree(), forState: UIControlState.Normal)
        
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
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
                currentState = .First
            }
        
        swapActions()
    }
    
    @IBAction func goPrevious(sender: AnyObject) {
        switch currentState {
        case .First:
            currentState = .Second
        case .Second:
            currentState = .Third
        case .Third:
            currentState = .First
        default:
            currentState = .First
        }
        swapActions()
    }
    
    func swapActions(){
        switch currentState {
        case .First:
            view.backgroundColor = UIColor.appActionOne()
            actionDetails.backgroundColor = UIColor.appActionOne()
            nextButton.setTitleColor(UIColor.appActionTwo(), forState: UIControlState.Normal)
            previousButton.setTitleColor(UIColor.appActionThree(), forState: UIControlState.Normal)
        case .Second:
            view.backgroundColor = UIColor.appActionTwo()
            actionDetails.backgroundColor = UIColor.appActionTwo()
            nextButton.setTitleColor(UIColor.appActionThree(), forState: UIControlState.Normal)
            previousButton.setTitleColor(UIColor.appActionOne(), forState: UIControlState.Normal)
        case .Third:
            view.backgroundColor = UIColor.appActionThree()
             actionDetails.backgroundColor = UIColor.appActionThree()
            nextButton.setTitleColor(UIColor.appActionOne(), forState: UIControlState.Normal)
            previousButton.setTitleColor(UIColor.appActionTwo(), forState: UIControlState.Normal)
        default:
            view.backgroundColor = UIColor.appActionOne()
            actionDetails.backgroundColor = UIColor.appActionOne()
            nextButton.setTitleColor(UIColor.appActionTwo(), forState: UIControlState.Normal)
            previousButton.setTitleColor(UIColor.appActionThree(), forState: UIControlState.Normal)
        
        }
    }
    
}

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
    
    @IBOutlet weak var actionTitle: UILabel!
    @IBOutlet weak var nextButton: UIButton!
    @IBOutlet weak var previousButton: UIButton!
    
    @IBOutlet weak var actionDetails: UITextView!
    
    
    override func viewDidLoad() {
        var blah = "ddd"
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

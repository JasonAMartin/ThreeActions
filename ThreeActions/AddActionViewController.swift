//
//  AddActionViewController.swift
//  ThreeActions
//
//  Created by Jason Martin on 2/28/15.
//  Copyright (c) 2015 Revolvity LLC. All rights reserved.
//


import UIKit

class AddActionViewController: UIViewController {
    
    var actionColor:Int = 0
    var actionDate:String = ""
    
    @IBOutlet weak var actionTitle: UITextField!
    
    @IBOutlet weak var actionDescription: UITextView!
    
    @IBOutlet weak var actionColorButton1: UIButton!
    
    @IBOutlet weak var actionColorButton2: UIButton!
    
    @IBOutlet weak var actionColorButton3: UIButton!
    
    @IBOutlet weak var createActionButton: UIButton!
    
    @IBOutlet weak var actionDatePicker: UIDatePicker!
    
    
    
    override func viewDidLoad() {
        
        //setup date picker to allow for date 7 days in past or 1 year in future
        let now = NSDate()
        actionDatePicker.minimumDate = now
        let currentCalendar = NSCalendar.currentCalendar()
        let dateComponents = NSDateComponents()
        dateComponents.day = 365
        let pastDateComponents = NSDateComponents()
        pastDateComponents.day = -7
        let yearFromNow = currentCalendar.dateByAddingComponents(dateComponents, toDate: now, options: nil)
        let sevenDaysAgo = currentCalendar.dateByAddingComponents(pastDateComponents, toDate: now, options: nil)
        actionDatePicker.maximumDate = yearFromNow
        actionDatePicker.minimumDate = sevenDaysAgo
        //end date picker setup
        
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    
    
    @IBAction func actionDateSelected(sender: AnyObject) {
        
        if let currentDate = sender.date {
            let formatter = NSDateFormatter()
            formatter.dateStyle = .ShortStyle
            actionDate = formatter.stringFromDate(currentDate!)
            let me = formatter.stringFromDate(currentDate!)
            self.actionDate = formatter.stringFromDate(currentDate!)
            
             self.actionDescription.text = actionDate
        }
        
    }
    
    
    
    
    @IBAction func chooseActionColor1(sender: AnyObject) {
        actionColor = 1
    }

    @IBAction func chooseActionColor2(sender: AnyObject) {
        actionColor = 2
    }
    
    @IBAction func chooseActionColor3(sender: AnyObject) {
        actionColor = 3
    }
    
    @IBAction func createAction(sender: AnyObject) {
        
        if(actionColor==0){
            self.actionDescription.text = "meh"
        } else {
            
            
            self.actionDescription.text = toString(actionDate)
        }
    }
    
    
}

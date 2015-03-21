//
//  AddActionViewController.swift
//  ThreeActions
//
//  Created by Jason Martin on 2/28/15.
//  Copyright (c) 2015 Revolvity LLC. All rights reserved.
//


import UIKit

class AddActionViewController: UIViewController, UITextFieldDelegate, UITextViewDelegate {
    
    var aColor:Int = 0
    var aDate:String = ""
    var aTitle:String = ""
    var aDescription:String = ""
    var passActionColor = 0
    
    
    @IBOutlet weak var actionTitle: UITextField!
   
    @IBOutlet weak var actionColorButton1: UIButton!
    
    @IBOutlet weak var actionColorButton2: UIButton!
    
    @IBOutlet weak var actionColorButton3: UIButton!
    
    @IBOutlet weak var createActionButton: UIButton!
    
    @IBOutlet weak var preButtonWarning: UILabel!
    
    @IBOutlet weak var actionDatePicker: UIDatePicker!
    
    @IBOutlet weak var actionDescription: UITextView!

    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        if(passActionColor == 1){
            actionColorButton1.backgroundColor = UIColor.appErrorRed()
        }
        
        if(passActionColor == 2){
            actionColorButton2.backgroundColor = UIColor.appErrorRed()
        }
        
        if(passActionColor == 3){
            actionColorButton3.backgroundColor = UIColor.appErrorRed()
        }
        
    }
    
    override func viewDidLoad() {
        
        actionTitle.delegate = self
        actionDescription.delegate = self
        
        //setup date picker to allow for date 7 days in past or 1 year in future
        let now = NSDate()
        
        //setting aDate to today by default
        let formatMyDate = NSDateFormatter()
        formatMyDate.dateStyle = .ShortStyle
        aDate = formatMyDate.stringFromDate(now)
        
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
            aDate = formatter.stringFromDate(currentDate!)
            let me = formatter.stringFromDate(currentDate!)
            self.aDate = formatter.stringFromDate(currentDate!)
            
             displayButton()
        }
        
    }
    
    
    func textFieldshouldChangeCharactersInRange(textField: UITextField!) {    //delegate method
        
    }
    
    @IBAction func chooseActionColor1(sender: AnyObject) {
        aColor = 1
        displayButton()
    }

    @IBAction func chooseActionColor2(sender: AnyObject) {
        aColor = 2
        displayButton()
    }
    
    @IBAction func chooseActionColor3(sender: AnyObject) {
        aColor = 3
        displayButton()
    }
    
    @IBAction func createAction(sender: AnyObject) {
        
    }
    
    @IBAction func fieldEntry(sender: AnyObject) {
        let myField = actionTitle.text.stringByTrimmingCharactersInSet(NSCharacterSet.whitespaceCharacterSet())
      
        if(countElements(myField)>0){
            self.aTitle = myField
            displayButton()
        }
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        
        println("Oh noes---- title: \(aColor) date: \(aDate)")
        if(segue.identifier == "networkSegue") {
            if let networkViewController = segue.destinationViewController as? NetworkViewController{
                networkViewController.aTitle = aTitle
                networkViewController.aColor = aColor
                networkViewController.aDate = aDate
                networkViewController.aDescription = aDescription
            }
        }
    }
    
    func textViewDidChange(textView: UITextView!) { //Handle the text changes here
        let myField = textView.text.stringByTrimmingCharactersInSet(NSCharacterSet.whitespaceCharacterSet())
        
        if(countElements(myField)>0){
            self.aDescription = myField
            displayButton()
        }
    }
    
    
    func displayButton(){
        //if all conditions for adding an action look to be met, show the button that let's the user go to networking modal
        if(aColor != 0 && aTitle != "" && aDescription != ""){
            preButtonWarning.hidden = true
            createActionButton.hidden = false
        }
    }
    
}

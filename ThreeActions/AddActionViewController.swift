//
//  AddActionViewController.swift
//  ThreeActions
//
//  Created by Jason Martin on 2/28/15.
//  Copyright (c) 2015 Revolvity LLC. All rights reserved.
//


import UIKit

class AddActionViewController: UIViewController, UITextFieldDelegate, UITextViewDelegate, UINavigationControllerDelegate {
    
    var aColor:Int = 0
    var aDate:String = ""
    var aTitle:String = ""
    var aDescription:String = ""
    var passActionColor = 0
    
    
    
   // @IBOutlet weak var actionDatePicker: UIDatePicker!
    
    
    //make elements
    let actionColorButton1:UIButton = UIButton(frame: CGRectMake(100, 400, 100, 50))
    let actionColorButton2:UIButton = UIButton(frame: CGRectMake(100, 400, 100, 50))
    let actionColorButton3:UIButton = UIButton(frame: CGRectMake(100, 400, 100, 50))
    let createActionButton:UIButton = UIButton(frame: CGRectMake(100, 400, 100, 50))
    let actionTitleTextField: UITextField = UITextField(frame: CGRect(x: 0, y: 0, width: 200.00, height: 40.00));
    let actionDescriptionTextField = UITextView(frame: CGRectMake(20.0, 30.0, 300.0, 30.0))
    let preButtonWarning = UILabel(frame: CGRectMake(0, 0, 200, 21))
    let actionDatePicker = UIDatePicker(frame: CGRectMake(0, 0, 200, 21))


    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        if(passActionColor == 1){
            view.backgroundColor = UIColor.appActionOne()
            aColor = 1
        }
        
        if(passActionColor == 2){
            view.backgroundColor = UIColor.appActionTwo()
            aColor = 2
        }
        
        if(passActionColor == 3){
            view.backgroundColor = UIColor.appActionThree()
            aColor = 3
        }
        
        //style items
        
        actionDatePicker.datePickerMode = UIDatePickerMode.Date
        
        actionColorButton1.backgroundColor = UIColor.appActionOne()
        actionColorButton1.setTitle("ACTION ONE", forState: .Normal)
        actionColorButton1.addTarget(self, action: "chooseActionColor1:", forControlEvents: UIControlEvents.TouchUpInside)
        actionColorButton1.titleLabel!.font =  UIFont(name: "HelveticaNeue", size: 14)
        UIViewController.roundedButton(actionColorButton1)
        
        actionColorButton2.backgroundColor = UIColor.appActionTwo()
        actionColorButton2.setTitle("ACTION TWO", forState: .Normal)
        actionColorButton2.addTarget(self, action: "chooseActionColor2:", forControlEvents: UIControlEvents.TouchUpInside)
        actionColorButton2.titleLabel!.font =  UIFont(name: "HelveticaNeue", size: 14)
        UIViewController.roundedButton(actionColorButton2)
        
        actionColorButton3.backgroundColor = UIColor.appActionThree()
        actionColorButton3.setTitle("ACTION THREE", forState: .Normal)
        actionColorButton3.addTarget(self, action: "chooseActionColor3:", forControlEvents: UIControlEvents.TouchUpInside)
        actionColorButton3.titleLabel!.font =  UIFont(name: "HelveticaNeue", size: 14)
        UIViewController.roundedButton(actionColorButton3)
        
        createActionButton.backgroundColor = UIColor.appColorButtonNormal()
        createActionButton.setTitle("CREATE ACTION", forState: .Normal)
        createActionButton.hidden = true
        UIViewController.buttonCreatorAction(createActionButton)
        
        actionTitleTextField.backgroundColor = UIColor.appActionTwo()
        actionTitleTextField.placeholder = "Enter action title"
        actionTitleTextField.layer.cornerRadius = 5.0
        actionTitleTextField.textAlignment = .Center
        
        actionDescriptionTextField.backgroundColor = UIColor.appErrorRed()
        actionDescriptionTextField.layer.cornerRadius = 5.0
        actionDescriptionTextField.textAlignment = .Left
        
        preButtonWarning.text = "Complete required options . . ."
        preButtonWarning.font =  UIFont(name: "HelveticaNeue", size: 16)
        preButtonWarning.textColor = UIColor.appMidnight()
        preButtonWarning.textAlignment = .Center

        
        //add items to view chooseActionColor1
        
        self.view.addSubview(actionColorButton1)
        self.view.addSubview(actionColorButton2)
        self.view.addSubview(actionColorButton3)
        self.view.addSubview(createActionButton)
        self.view.addSubview(actionTitleTextField)
        self.view.addSubview(actionDescriptionTextField)
        self.view.addSubview(preButtonWarning)
        self.view.addSubview(actionDatePicker)
        
        //layout items
        
        layout(preButtonWarning, view) { preButtonWarning, view in
            preButtonWarning.width == view.width
            preButtonWarning.height == 40
            preButtonWarning.centerX == view.centerX
            preButtonWarning.bottom == view.bottom - 30
        }
        
        
        layout(actionTitleTextField, view) { actionTitleTextField, view in
            actionTitleTextField.width == view.width - 80
            actionTitleTextField.height == 40
            actionTitleTextField.centerX == view.centerX
            actionTitleTextField.top == view.top + 30
        }
        
        layout(actionDescriptionTextField, view) { actionDescriptionTextField, view in
            actionDescriptionTextField.width == view.width - 80
            actionDescriptionTextField.top == view.top + 80
            actionDescriptionTextField.height == 100
            actionDescriptionTextField.centerX == view.centerX
        }
        
        layout(createActionButton, view) { createActionButton, view in
            createActionButton.width == 200
            createActionButton.height == 40
            createActionButton.bottom == view.bottom - 30
            createActionButton.centerX == view.centerX
        }
        
        layout(actionColorButton1, actionDescriptionTextField, view) { actionColorButton1, actionDescriptionTextField, view in
            actionColorButton1.width ==  (view.width - 100) / 3
            actionColorButton1.height == 30
            actionColorButton1.left == view.left + 40
            actionColorButton1.top == actionDescriptionTextField.bottom + 10
        }
        
        layout(actionColorButton2, actionColorButton1, view) { actionColorButton2, actionColorButton1, view in
            actionColorButton2.width ==  (view.width - 100) / 3
            actionColorButton2.height == 30
            actionColorButton2.left == actionColorButton1.right + 10
            actionColorButton2.top == actionColorButton1.top
        }
        
        layout(actionColorButton3, actionColorButton2, view) { actionColorButton3, actionColorButton2, view in
            actionColorButton3.width ==  (view.width - 100) / 3
            actionColorButton3.height == 30
            actionColorButton3.left == actionColorButton2.right + 10
            actionColorButton3.top == actionColorButton2.top
        }
        
        layout(actionDatePicker, actionColorButton2, view) { actionDatePicker, actionColorButton1, view in
            actionDatePicker.width ==  view.width - 80
            actionDatePicker.centerX == view.centerX
            actionDatePicker.top == actionColorButton1.bottom + 20
        }
        
    }
    
    override func viewDidLoad() {
        
        actionTitleTextField.delegate = self
        actionDescriptionTextField.delegate = self
        
        
        //setup date picker to allow for date 0 days in past or 1 year in future
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
        pastDateComponents.day = 0 //-7
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
        //println("hey")
        
    }
    
    func textFieldDidBeginEditing(textField: UITextField) {
        fieldEntry(self)
    }
    
    func textFieldShouldEndEditing(textField: UITextField){
        fieldEntry(self)
        view.endEditing(true)
    }
    
    func textViewShouldEndEditing(textView: UITextView) {
        view.endEditing(true)
        fieldEntry(self)
    }
    
    
    func chooseActionColor1(sender: AnyObject) {
        aColor = 1
        view.backgroundColor = UIColor.appActionOne()
        displayButton()
    }

    func chooseActionColor2(sender: AnyObject) {
        aColor = 2
        view.backgroundColor = UIColor.appActionTwo()
        displayButton()
    }
    
    func chooseActionColor3(sender: AnyObject) {
        aColor = 3
        view.backgroundColor = UIColor.appActionThree()
        displayButton()
    }
    
    func createAction(sender: AnyObject) {
        
        //call network VC and rock it
        
    }
    
    func fieldEntry(sender: AnyObject) {
        let myField = actionTitleTextField.text.stringByTrimmingCharactersInSet(NSCharacterSet.whitespaceCharacterSet())
      
        if(countElements(myField)>0){
            self.aTitle = myField
            displayButton()
        }
    }
    
    
    func textField(textField: UITextField!, shouldChangeCharactersInRange range: NSRange, replacementString string: String!) -> Bool {
        var txtAfterUpdate:NSString = self.actionTitleTextField.text as NSString
        txtAfterUpdate = txtAfterUpdate.stringByReplacingCharactersInRange(range, withString: string)
        
        let myField = actionTitleTextField.text.stringByTrimmingCharactersInSet(NSCharacterSet.whitespaceCharacterSet())
        
        if(countElements(myField)>0){
            self.aTitle = myField
            displayButton()
        }

        //self.callMyMethod(txtAfterUpdate)
        return true
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
        println("calling display button")
        //if all conditions for adding an action look to be met, show the button that let's the user go to networking modal
        
        //NOTE: removed && aDescription != "" as I decided description should be optional.
        if(aColor != 0 && aTitle != ""){
            preButtonWarning.hidden = true
            createActionButton.hidden = false
        }
    }
    
}

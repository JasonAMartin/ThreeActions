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
        
        
        //tap for keyboard
        let tapRecognizer = UITapGestureRecognizer()
        tapRecognizer.addTarget(self, action: "didTapView")
        self.view.addGestureRecognizer(tapRecognizer)
        //end tap for keyboard
        
        view.backgroundColor = UIColor.appShadyGhost()

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
        actionDatePicker.addTarget(self, action: Selector("actionDateSelected:"), forControlEvents: UIControlEvents.ValueChanged)
        actionDatePicker.tintColor = UIColor.appGhostWhite()

        
        actionColorButton1.backgroundColor = UIColor.appActionOne()
        actionColorButton1.setTitle("ACTION 1", forState: .Normal)
        actionColorButton1.addTarget(self, action: "chooseActionColor1:", forControlEvents: UIControlEvents.TouchUpInside)
        actionColorButton1.titleLabel!.font =  UIFont(name: "HelveticaNeue", size: 12)
        UIViewController.roundedButton(actionColorButton1)
        
        actionColorButton2.backgroundColor = UIColor.appActionTwo()
        actionColorButton2.setTitle("ACTION 2", forState: .Normal)
        actionColorButton2.addTarget(self, action: "chooseActionColor2:", forControlEvents: UIControlEvents.TouchUpInside)
        actionColorButton2.titleLabel!.font =  UIFont(name: "HelveticaNeue", size: 12)
        UIViewController.roundedButton(actionColorButton2)
        
        actionColorButton3.backgroundColor = UIColor.appActionThree()
        actionColorButton3.setTitle("ACTION 3", forState: .Normal)
        actionColorButton3.addTarget(self, action: "chooseActionColor3:", forControlEvents: UIControlEvents.TouchUpInside)
        actionColorButton3.titleLabel!.font =  UIFont(name: "HelveticaNeue", size: 12)
        UIViewController.roundedButton(actionColorButton3)
        
        createActionButton.backgroundColor = UIColor.appColorButtonNormal()
        createActionButton.setTitle("CREATE ACTION", forState: .Normal)
        createActionButton.hidden = true
        UIViewController.buttonCreatorAction(createActionButton)
        createActionButton.addTarget(self, action: "createAction:", forControlEvents: UIControlEvents.TouchUpInside)

        
        actionTitleTextField.backgroundColor = UIColor.appGhostWhiteFade()
        actionTitleTextField.placeholder = "Enter action title"
        actionTitleTextField.layer.cornerRadius = 5.0
        actionTitleTextField.textAlignment = .Center
        
        actionDescriptionTextField.backgroundColor = UIColor.appGhostWhiteFade()
        actionDescriptionTextField.layer.cornerRadius = 5.0
        actionDescriptionTextField.textAlignment = .Left
        
        preButtonWarning.text = "Complete required options . . ."
        preButtonWarning.font =  UIFont(name: "HelveticaNeue", size: 16)
        preButtonWarning.textColor = UIColor.appMidnight()
        preButtonWarning.textAlignment = .Center

    
        actionDescriptionTextField.text = "Optional: enter a description"
        actionDescriptionTextField.textColor = UIColor.lightGrayColor()
        
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
            preButtonWarning.bottom == view.bottom - 20
        }
        
        
        layout(actionTitleTextField, actionColorButton1, view) { actionTitleTextField, actionColorButton1, view in
            actionTitleTextField.width == view.width - 80
            actionTitleTextField.height == 40
            actionTitleTextField.centerX == view.centerX
            actionTitleTextField.top == actionColorButton1.bottom + 20
        }
        
        layout(actionDescriptionTextField, actionTitleTextField, view) { actionDescriptionTextField, actionTitleTextField, view in
            actionDescriptionTextField.width == view.width - 80
            actionDescriptionTextField.top == actionTitleTextField.bottom + 20
            actionDescriptionTextField.height == 100
            actionDescriptionTextField.centerX == view.centerX
        }
        
        layout(createActionButton, view) { createActionButton, view in
            createActionButton.width == 200
            createActionButton.height == 40
            createActionButton.bottom == view.bottom - 20
            createActionButton.centerX == view.centerX
        }
        
        layout(actionColorButton1, actionDescriptionTextField, view) { actionColorButton1, actionDescriptionTextField, view in
            actionColorButton1.width ==  (view.width - 100) / 3
            actionColorButton1.height == 30
            actionColorButton1.left == view.left + 40
            actionColorButton1.top == view.top + 30
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
        
        layout(actionDatePicker, actionDescriptionTextField, view) { actionDatePicker, actionDescriptionTextField, view in
            actionDatePicker.width ==  view.width - 80
            actionDatePicker.centerX == view.centerX
            actionDatePicker.top == actionDescriptionTextField.bottom + 10
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
    
    func actionDateSelected(sender: AnyObject) {
        println("DATE PICK")
        
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
        self.view.endEditing(true)
        fieldEntry(self)
    }
    
    func textFieldShouldReturn(textField: UITextField!) -> Bool {
        self.view.endEditing(true)
        return false
    }
    
    func textViewDidEndEditing(textView: UITextView) -> Bool {
        if(actionDescriptionTextField.text == ""){
            actionDescriptionTextField.text = "Optional: enter a description"
        }
        
        self.view.endEditing(true)
        return false
    }
    
    func textViewShouldBeginEditing(textView: UITextView) {
        if(actionDescriptionTextField.text == "Optional: enter a description") {
            actionDescriptionTextField.text = nil
        }
    }
    
    func didTapView(){
        self.view.endEditing(true)
    }
    
    func chooseActionColor1(sender: AnyObject) {
        aColor = 1
        view.backgroundColor = UIColor.appActionOne()
        displayButton()
        
        actionTitleTextField.backgroundColor = UIColor.appGhostWhiteFade()
        actionDescriptionTextField.backgroundColor = UIColor.appGhostWhiteFade()
        preButtonWarning.textColor = UIColor.appGhostWhite()
    }

    func chooseActionColor2(sender: AnyObject) {
        aColor = 2
        view.backgroundColor = UIColor.appActionTwo()
        displayButton()
        
        actionTitleTextField.backgroundColor = UIColor.appGrayFade()
        actionDescriptionTextField.backgroundColor = UIColor.appGrayFade()
        preButtonWarning.textColor = UIColor.appMidnight()
    }
    
    func chooseActionColor3(sender: AnyObject) {
        aColor = 3
        view.backgroundColor = UIColor.appActionThree()
        displayButton()
        actionTitleTextField.backgroundColor = UIColor.appGrayFade()
        actionDescriptionTextField.backgroundColor = UIColor.appGrayFade()
        preButtonWarning.textColor = UIColor.appMidnight()
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
    
    func createAction(sender: AnyObject){
        //send action
        let networkVC = storyboard?.instantiateViewControllerWithIdentifier("networkViewController") as NetworkViewController
        
        networkVC.aTitle = aTitle
        networkVC.aColor = aColor
        networkVC.aDate = aDate
        networkVC.aDescription = aDescription
        networkVC.networkingPurpose = .CreateAction
        presentViewController(networkVC, animated: true, completion: nil)
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
        
        //NOTE: removed && aDescription != "" as I decided description should be optional.
        if(aColor != 0 && aTitle != ""){
            preButtonWarning.hidden = true
            createActionButton.hidden = false
        }
    }
    
    func removeThisModal() {
        self.dismissViewControllerAnimated(true, completion: nil)
    }
}

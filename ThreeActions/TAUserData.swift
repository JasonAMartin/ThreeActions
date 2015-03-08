//
//  TAUserData.swift
//  ThreeActions
//
//  Created by Jason Martin on 3/7/15.
//  Copyright (c) 2015 Revolvity LLC. All rights reserved.
//

/*
User data model

date : date for the action
actionTitle : action's title
actionDescription : longer text for the action
status : 0 for pending or 1 for complete
actionColor : 1,2 or 3 for color assignment
creationDate : the date the user created the object
lastModified : the date of last modification
*/


struct TAUsers {
    
    var userAccount: String
    
    //INIT
    init(){
        //setting username to PFUser so if user isn't logged in, this all fails.
        self.userAccount = PFUser.currentUser().username
    }
    //METHODS
    
    func taPullLocal(){
        let pull = PFQuery(className:"UserActions")
        pull.fromLocalDatastore()
        pull.whereKey("owner", equalTo:self.userAccount)
        pull.findObjectsInBackgroundWithBlock {
            (objects: [AnyObject]!, error: NSError!) -> Void in
            if error == nil {
                // The find succeeded.
                NSLog("LOCAL: Successfully retrieved \(objects.count) actions.")
                // Do something with the found objects
                //for object in objects {
                //  object.pinInBackground()
                //}
            }
            
            
            
        }
    }
    
    func taNewSyncAll(){
        
        
        
      
        
        //1. get all objects
        //2. dump local db
        //3. populate
        
        var query = PFQuery(className:"UserActions")
        query.whereKey("owner", equalTo:userAccount)
        query.findObjectsInBackgroundWithBlock {
            (objects: [AnyObject]!, error: NSError!) -> Void in
            if error == nil {
                // The find succeeded.
                NSLog("Successfully retrieved \(objects.count) actions.")
                // Do something with the found objects
                for object in objects {
                    object.pinInBackground()
                }
            }
            
        }
        
        
    }
    
    func checkAction (#colornumber actionColor:Int, #date actionDate:String) -> Bool {
        
        //This function will check if an action exists for the date & color specified and return either true or false. True = item exists.
        
        //Also note, this is using SYNC method. To go aSync, I need to use findObjectsInBackgroundWithBlock
        
        var foundItem = false
        
        println("\n----- QUERY\n owner: \(userAccount)\n date: \(actionDate)\n Color: \(actionColor)\n\n-------")
        
        var query = PFQuery(className:"UserActions")
        query.whereKey("owner", equalTo:userAccount)
        query.whereKey("date", equalTo: actionDate)
        query.whereKey("actionColor", equalTo: actionColor)
        query.findObjects()
        
        if(query.countObjects()>0) {
            println("I found stuff")
                foundItem = true
            return true
        }
        
        println ("no foundie stuff")
        return false
    }
    
    
    func saveAction (#title actionTitle:String, #description actionDescription:String, #status status:Int, #colornumber actionColor:Int, #task task:String, #date actionDate:String, #responseLabel:UILabel) {
        
        //date code
        
        let date = NSDate()
        let formatter = NSDateFormatter()
        //formatter.timeStyle = .ShortStyle
        formatter.dateStyle = .ShortStyle
        
        //do checkAction and if that returns ok, do rest otherwise we're done.
        
        if(!checkAction(colornumber: actionColor, date: actionDate)){
                var data = PFObject(className:"UserActions")
                data["actionTitle"] = actionTitle
                data["actionDescription"] = actionDescription
                data["status"] = status
                data["actionColor"] = actionColor
                data["date"] = actionDate
                data["creationDate"] = formatter.stringFromDate(date)
                data["lastModified"] = date
                data["owner"] = self.userAccount //userid
                
                data.saveInBackgroundWithBlock {
                    (success: Bool, error: NSError!) -> Void in
                    if (success) {
                        responseLabel.text = "boom goes the dyamite!"
                       //self.completedNetworkRequest(true)
                    } else {
                       responseLabel.text = "I just failed in data saving."
                        //self.completedNetworkRequest(false)
                    }
                }
        } else {
            responseLabel.text = "Cha Cha Cha I failed from the start"
        }
        
        //end saveAction
    }
    
    func completedNetworkRequest(status: Bool) -> Bool{
        //NOT BEING USED
        println("Completed Network Request with a value of: \(status)")
        return status
    }
    
    
    func getActionsData (#date actionDate:String, actionTitle:UILabel, nextButton:UIButton,previousButton:UIButton,actionDetails:UITextView) {
        
        var responseArray: [Dictionary<String, String>] = []
        var query = PFQuery(className:"UserActions")
        
        query.whereKey("owner", equalTo:userAccount)
        query.whereKey("date", equalTo: actionDate)
        query.findObjectsInBackgroundWithBlock {
            (objects: [AnyObject]!, error: NSError!) -> Void in
            if error == nil {
                // The find succeeded.
                NSLog("Successfully retrieved \(objects.count) actions.")
                // Do something with the found objects
                for object in objects {
                   //make a dictionary then push to responseArray
    
                    responseArray.append([
                        "actionTitle": object.valueForKey("actionTitle") as String,
                        "actionDescription": object.valueForKey("actionDescription") as String,
                        "actionDate": object.valueForKey("date") as String,
                        "objectId":object.valueForKey("objectId") as String,
                        "status":toString(object.valueForKey("status") as Int),
                        "actionColor":toString(object.valueForKey("actionColor") as Int)
                        ])
                }
                
                //response is complete. Send data to display method to display whatever
               let finalData =  self.displayTodayActions(responseArray)
                
                
                //if let hey = finalData[1]?["actionDescription"]{
               
            } else {
                // Log details of the failure
                NSLog("Error: %@ %@", error, error.userInfo!)
            }
        }
        
    }

    func displayTodayActions(responseData: [Dictionary<String,String>]) -> Dictionary<Int,Dictionary<String,String>>{
        
        
        //LOLZ. I'm doing dictionary of dictionaries. Weeee
        
        
        //create items in order (really need to revise this)
        //this whole method is versobe and drawn out as heck just to get the job done. I'd like to refactor this whole method.
        
        var firstAction = Dictionary<String, String>()
        var secondAction = Dictionary<String, String>()
        var thirdAction = Dictionary<String, String>()
        var firstStatus = 1
        var secondStatus = 1
        var thirdStatus = 1
        
        var actionOne = Dictionary<String, String>()
        var actionTwo = Dictionary<String, String>()
        var actionThree = Dictionary<String, String>()

        
     //iterate response Data
        
        for actionData in responseData {
            
            if(actionData["actionColor"]=="1"){
                firstAction = actionData
            }
            if(actionData["actionColor"]=="2"){
                secondAction = actionData
            }
            if(actionData["actionColor"]=="3"){
                thirdAction = actionData
            }
            
            
        }
        
        //dictionaries are in order.
        //unwrap optionals and put into temporary dictionaries in order
        
        if let firstActionStatus = firstAction["status"]?.toInt() {
                firstStatus = firstActionStatus
        }
        
        if let secondActionStatus = secondAction["status"]?.toInt() {
            secondStatus = secondActionStatus
        }
        
        if let thirdActionStatus = thirdAction["status"]?.toInt() {
            thirdStatus = thirdActionStatus
        }
        
        //sort the order out so first action is the 1st undone action and not color #1 unless it works out that way
        
        //NOTE Just look for combo then put dictionaries into array in the order needed like masterArray[0] = thisAction
        
        //default
        
        actionOne = firstAction
        actionTwo = secondAction
        actionThree = thirdAction
    
        //now do any combos where the above default wouldn't be correct
        
        
        if(firstStatus == 1 && secondStatus == 0 && thirdStatus == 0){
            //all three actions are undone
            actionOne = secondAction
            actionTwo = thirdAction
            actionThree = firstAction
        }
        
        if(firstStatus == 1 && secondStatus == 1 && thirdStatus == 0){
            //all three actions are undone
            actionOne = thirdAction
            actionTwo = firstAction
            actionThree = secondAction
        }
        
        if(firstStatus == 0 && secondStatus == 1 && thirdStatus == 0){
            //all three actions are undone
            actionOne = firstAction
            actionTwo = thirdAction
            actionThree = secondAction
        }
        
        if(firstStatus == 1 && secondStatus == 0 && thirdStatus == 1){
            //all three actions are undone
            actionOne = secondAction
            actionTwo = thirdAction
            actionThree = firstAction
        }
     
        let finalData = [1:actionOne, 2:actionTwo, 3:actionThree]
        return finalData
        
    }
    
    //end TAUserData
}
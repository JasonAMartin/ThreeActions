//
//  TAUserData.swift
//  ThreeActions
//
//  Created by Jason Martin on 3/7/15.
//  Copyright (c) 2015 Revolvity LLC. All rights reserved.
//

/*
User data model

actionDate : date for the action
actionTitle : action's title
actionDescription : longer text for the action
actionStatus : 0 for pending or 1 for complete
actionColor : 1,2 or 3 for color assignment
creationDate : the date the user created the object
lastModified : the date of last modification
*/


class TAUsers {
    
    //SINGLETON Weeeeee
    class var sharedInstance: TAUsers {
        //2
        struct Singleton {
            //3
            static let instance = TAUsers()
        }
        //4
        return Singleton.instance
    }
    
    var userAccount: String
    var actionDB = [String: AnyObject]()
    
    
    //INIT
    init(){
        //setting username to PFUser so if user isn't logged in, this all fails.
        self.userAccount = PFUser.currentUser().username
    }
    //METHODS
    
    func setInstanceDB(#data:AnyObject){
        //passing in each DB object for storing in the Singleton
        //key is date + action color int so: "3/14/15-2"
        
       var actionDate = data.valueForKey("actionDate") as String
       var actionColor = toString(data.valueForKey("actionColor") as Int)
        
        if(actionDate != "" && actionColor != ""){
            var newKey = actionDate+"-"+actionColor
                //put in dictionary
                ///TAUsers.sharedInstance.actionDB.updateValue(data, forKey: newKey)
            TAUsers.sharedInstance.actionDB[newKey] = data
        }
    
    }
    
    func removeInstanceDBItem(key: String){
        println("trying to delete")
        println("key: \(key)")
        TAUsers.sharedInstance.actionDB.removeValueForKey(key)
        println(TAUsers.sharedInstance.actionDB[key])
    }
    
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

    
    func taRemoveLocal(){
        //This method dumps ALL objects from UserActions
        let pull = PFQuery(className:"UserActions")
        pull.fromLocalDatastore()
        pull.whereKey("owner", equalTo:self.userAccount)
        pull.findObjectsInBackgroundWithBlock {
            (objects: [AnyObject]!, error: NSError!) -> Void in
            if error == nil {
                for object in objects {
                  object.unpinInBackground()
                }
            }
        }
    }
    
    func taNewSyncAll(completion: (() -> Void)!){
        
        
        
        //test msgs
        
        
        
        
        
        var msgQuery = PFQuery(className:"Messages")
        msgQuery.findObjectsInBackgroundWithBlock {
            (objects: [AnyObject]!, error: NSError!) -> Void in
            if error == nil {
                // The find succeeded.
                NSLog("SPECIAL: Successfully retrieved \(objects.count) actions.")
                // Do something with the found objects
                for object in objects {
                    println(object["Message"])
                    
                }
            }
        }
        
        

        
        //1. get all objects
        //2. dump local db
        //3. populate
        
        //remove local
        taRemoveLocal()
        
        //grab objects and populate new local
        var query = PFQuery(className:"UserActions")
        query.whereKey("owner", equalTo:userAccount)
        query.findObjectsInBackgroundWithBlock {
            (objects: [AnyObject]!, error: NSError!) -> Void in
            if error == nil {
                // The find succeeded.
                NSLog("Syncing..... [\(self.userAccount)] Successfully retrieved \(objects.count) actions.")
                // Do something with the found objects
                for object in objects {
                    object.pinInBackground()
                    
                    //add this for singleton
                    
                    self.setInstanceDB(data: object)
                 //   println(object.objectId)
                    
                }
                //callback after syncing data. This also works if there are 0 items
                completion()
            }
        }
    }
    
    
    func taSyncDay(responseLabel: UILabel, actionDate: String, completion: (() -> Void)!){
        
        //This method is for syncing while the app is running. We want to just sync whatever day and populate objects.
        
        //grab objects and populate new local
        var query = PFQuery(className:"UserActions")
        query.whereKey("owner", equalTo:userAccount)
        query.whereKey("actionDate", equalTo: actionDate)
        
        query.findObjectsInBackgroundWithBlock {
            (objects: [AnyObject]!, error: NSError!) -> Void in
            if error == nil {
                // The find succeeded.
                NSLog("Date syncing object(s)..... [\(self.userAccount)] Successfully retrieved \(objects.count) actions.")
                // Do something with the found objects
                for object in objects {
                    object.pinInBackground()
                    //add this for singleton
                    
                    self.setInstanceDB(data: object)
                    
                }
                //callback after syncing data. This also works if there are 0 items
                responseLabel.text = "Syncing complete."
                completion()
            }
        }
    }
    
    
    
    func checkAction (#colornumber actionColor:Int, #date actionDate:String) -> Bool {
        
        //This function will check if an action exists for the date & color specified and return either true or false. True = item exists.
        
        //Also note, this is using SYNC method. To go aSync, I need to use findObjectsInBackgroundWithBlock
        
        var foundItem = false
        var query = PFQuery(className:"UserActions")
        query.whereKey("owner", equalTo:userAccount)
        query.whereKey("actionDate", equalTo: actionDate)
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
    
    func checkDataObject (#objectID objectID:String) -> Bool {
        var foundItem = false
        var query = PFQuery(className:"UserActions")
        query.whereKey("owner", equalTo:userAccount)
        query.whereKey("objectId", equalTo: objectID)
        query.findObjects()
        
        if(query.countObjects()>0) {
            foundItem = true
            return true
        }
        return false
    }
    
  
    func saveAction (#title actionTitle:String, #description actionDescription:String, #status status:Int, #colornumber actionColor:Int, #task task:String, #date actionDate:String, #responseLabel:UILabel, #complete:()->Void) {
        
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
                data["actionStatus"] = status
                data["actionColor"] = actionColor
                data["actionDate"] = actionDate
                data["creationDate"] = formatter.stringFromDate(date)
                data["lastModified"] = date
                data["owner"] = self.userAccount //userid
                
                data.saveInBackgroundWithBlock {
                    (success: Bool, error: NSError!) -> Void in
                    if (success) {
                       //responseLabel.text = "boom goes the dyamite!"
                       //self.completedNetworkRequest(true)
                      //  self.taSyncDay(responseLabel: responseLabel, actionDate: actionDate, completion: complete)
                        
                        responseLabel.text = "New action created.\nSyncing Data . . ."
                        self.taSyncDay(responseLabel, actionDate: actionDate, completion: complete)

                        
                        } else {
                       responseLabel.text = "Looks like there was an error saving the data. Are you connected to a network? Please go back and try again."
                        complete()
                    }
                }
        } else {
            responseLabel.text = "Sorry, but it looks like you already have an action for this date and action slot setup already. Please go back and select a new date and/or action slot or delete/modify the one you already have."
            complete()
        }
        
        //end saveAction
    }
    
    func modifyAction (#objectID: String, #title actionTitle:String, #description actionDescription:String, #status status:Int, #colornumber actionColor:Int, #task task:String, #date actionDate:String, #responseLabel:UILabel, #complete:()->Void) {
        
        //1. lookup object ID
        //2. modify item
        //3. day sync
        
        var query = PFQuery(className:"UserActions")
        query.getObjectInBackgroundWithId(objectID) {
            (userActions: PFObject!, error: NSError!) -> Void in
            if error != nil {
                println(error)
            } else {
                userActions["actionTitle"] = actionTitle
                userActions["actionDescription"] = actionDescription
                userActions["actionColor"] = actionColor
                userActions["actionStatus"] = status
                userActions.saveInBackgroundWithBlock {
                    (success: Bool, error: NSError!) -> Void in
                    if (success) {
                        //responseLabel.text = "boom goes the dyamite!"
                        //self.completedNetworkRequest(true)
                        //  self.taSyncDay(responseLabel: responseLabel, actionDate: actionDate, completion: complete)
                        
                        responseLabel.text = "Action modified.\nSyncing Data . . ."
                        self.taSyncDay(responseLabel, actionDate: actionDate, completion: complete)
                    } else {
                        responseLabel.text = "Looks like there was an error saving the data. Are you connected to a network? Please go back and try again."
                        complete()
                    }
                }
            }
        }
        
        //end modify action
    }

    
    func completeAction (#objectID: String, #status status:Int, #date actionDate:String, #responseLabel:UILabel, #complete:()->Void) {
        
        
        var query = PFQuery(className:"UserActions")
        query.getObjectInBackgroundWithId(objectID) {
            (userActions: PFObject!, error: NSError!) -> Void in
            if error != nil {
                println("No object found.")
            } else {
                userActions["actionStatus"] = status
                userActions.saveInBackgroundWithBlock {
                    (success: Bool, error: NSError!) -> Void in
                    if (success) {
                        responseLabel.text = "Marked action as complete!\nSyncing Data . . ."
                        self.taSyncDay(responseLabel, actionDate: actionDate, completion: complete)
                    } else {
                        responseLabel.text = "Looks like there was an error saving the data. Are you connected to a network? Please go back and try again."
                        complete()
                    }
                }
            }
        }
        
        //end complete action
    }
    
    func deleteAction (#key: String, #objectID: String, #date actionDate:String, #responseLabel:UILabel, #complete:()->Void) {
        
        //1. lookup object ID
        //2. modify item
        //3. day sync
        
        var query = PFQuery(className:"UserActions")
        query.getObjectInBackgroundWithId(objectID) {
            (userActions: PFObject!, error: NSError!) -> Void in
            if error != nil {
                println(error)
            } else {
                
                userActions.deleteInBackgroundWithBlock {
                    (success: Bool, error: NSError!) -> Void in
                    if (success) {
                        //remove from singleton
                        println("stage two key: \(key)")
                        self.removeInstanceDBItem(key)
                        
                        responseLabel.text = "Action deleted.\nSyncing Data . . ."
                        //sync
                       self.taSyncDay(responseLabel, actionDate: actionDate, completion: complete)

                    } else {
                        responseLabel.text = "Looks like there was an error deleting/syncing the data. Are you connected to a network? Please go back and try again."
                        complete()
                    }
                }
            }
        }
        
        //end delete action
    }
    
    func completedNetworkRequest(status: Bool) -> Bool{
        //NOT BEING USED
        println("Completed Network Request with a value of: \(status)")
        return status
    }
    
    
    func getActionsData (#date actionDate:String, actionTitle:UILabel, nextButton:UIButton,previousButton:UIButton,actionDetails:UITextView)->Int {
        var myNumber = 0
        var responseArray: [Dictionary<String, String>] = []
        var query = PFQuery(className:"UserActions")
        query.fromLocalDatastore()
        query.whereKey("owner", equalTo:userAccount)
        query.whereKey("actionDate", equalTo: actionDate)
        query.findObjectsInBackgroundWithBlock {
            (objects: [AnyObject]!, error: NSError!) -> Void in
            if error == nil {
                // The find succeeded.
                NSLog("Successfully retrieved \(objects.count) actions for date: \(actionDate) and user: \(self.userAccount) .")
                // Do something with the found objects
                for object in objects {
                    println(object)
                   //make a dictionary then push to responseArray
    
                    responseArray.append([
                        "actionTitle": object.valueForKey("actionTitle") as String,
                        "actionDescription": object.valueForKey("actionDescription") as String,
                        "actionDate": object.valueForKey("actionDate") as String,
                        "objectId":object.valueForKey("objectId") as String,
                        "status":toString(object.valueForKey("status") as Int),
                        "actionColor":toString(object.valueForKey("actionColor") as Int)
                        ])
                }
                
                //response is complete. Send data to display method to display whatever
               let finalData =  self.displayTodayActions(responseArray)
                
                myNumber = 3
                //if let hey = finalData[1]?["actionDescription"]{
               
            } else {
                // Log details of the failure
                NSLog("Error: %@ %@", error, error.userInfo!)
                myNumber = 4
            }
        }
        return myNumber
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
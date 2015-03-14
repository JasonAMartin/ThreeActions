//
//  UserData.swift
//  ThreeActions
//
//  Created by Jason Martin on 2/28/15.
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
/*

import Foundation

class UserData {
    
    let parseErrorDictionary = ParseErrorDictionary
    
    var userAccount: String
    var progress = 0
    var progressText = ""
    
    
    init(userAccount:String){
        self.userAccount = userAccount
    }
    
    
    func saveData (#title actionTitle:String, #description actionDescription:String, #status status:Int, #colornumber actionColor:Int, #task task:String) -> Int {
        
       //date code
        
        let date = NSDate()
        let formatter = NSDateFormatter()
        //formatter.timeStyle = .ShortStyle
        formatter.dateStyle = .ShortStyle
        
        println(self.progress)

        
        //do query count to see if user already has a date and color set. If so, return error.
        
        var query = PFQuery(className:"UserActions")
        query.whereKey("owner", equalTo:userAccount)
        query.whereKey("actionColor", equalTo:actionColor)
        query.whereKey("date", equalTo:formatter.stringFromDate(date))
        query.countObjectsInBackgroundWithBlock {
            (count: Int32, error: NSError!) -> Void in
            if error == nil && count==0 {
               
            //procceed
                
                var data = PFObject(className:"UserActions")
                
                data["actionTitle"] = actionTitle
                data["actionDescription"] = actionDescription
                data["status"] = status
                data["actionColor"] = actionColor
                data["date"] = formatter.stringFromDate(date)
                data["creationDate"] = formatter.stringFromDate(date)
                data["lastModified"] = date
                data["owner"] = self.userAccount //userid
                
                data.saveInBackgroundWithBlock {
                    (success: Bool, error: NSError!) -> Void in
                    if (success) {
                        self.progress = 1
                         println(self.progress)
                    } else {
                        self.progressText = error.description
                        self.progress = 2
                         println(self.progress)
                    }
                }
                
            } else {
                
                self.progress = 2
                 println(self.progress)
                self.progressText = "The network request has resulted in an error"
              
                
            }
        }
        
         println(self.progress)
      return progress
        //end method
        
    }
    
    
    
    func getData (#userid id:String){
     
        
        let date = NSDate()
        let formatter = NSDateFormatter()
        //formatter.timeStyle = .ShortStyle
        formatter.dateStyle = .ShortStyle
        
        
        
        
        var query = PFQuery(className:"UserActions")
        query.whereKey("owner", equalTo:id)
        query.whereKey("date", equalTo: formatter.stringFromDate(date))
        query.findObjectsInBackgroundWithBlock {
            (objects: [AnyObject]!, error: NSError!) -> Void in
            if error == nil {
                // The find succeeded.
                NSLog("Successfully retrieved \(objects.count) actions.")
                // Do something with the found objects
                for object in objects {
                    NSLog("%@", object.objectId)
                }
            } else {
                // Log details of the failure
                NSLog("Error: %@ %@", error, error.userInfo!)
            }
        }
        
        
        
        
        
    }
    
    
    //end class
    
}

*/
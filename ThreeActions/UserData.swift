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


import Foundation

class UserData {
    
    func saveData (#title actionTitle:String, #description actionDescription:String, #status status:Int, #colornumber actionColor:Int, #task task:String, #owner owner:String) {
        
       //date code
        
        let date = NSDate()
        let formatter = NSDateFormatter()
        //formatter.timeStyle = .ShortStyle
        formatter.dateStyle = .ShortStyle

        
        //do query count to see if user already has a date and color set. If so, return error.
        
        var query = PFQuery(className:"UserActions")
        query.whereKey("owner", equalTo:owner)
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
                data["owner"] = owner //userid
                
                data.saveInBackgroundWithBlock {
                    (success: Bool, error: NSError!) -> Void in
                    if (success) {
                        println("I have succeeded")
                    } else {
                        println("More work to do.")
                        println(error.description)
                    }
                }
                
                
                
                
            } else {
                println("Sorry, this query exists")
            }
        }
       
        //proceed
        
       /*
        
        var data = PFObject(className:"UserActions")
        
        data["actionTitle"] = actionTitle
        data["actionDescription"] = actionDescription
        data["status"] = status
        data["actionColor"] = actionColor
        data["date"] = formatter.stringFromDate(date)
        data["creationDate"] = formatter.stringFromDate(date)
        data["lastModified"] = date
        data["owner"] = owner //userid
        
        data.saveInBackgroundWithBlock {
            (success: Bool, error: NSError!) -> Void in
            if (success) {
                println("I have succeeded")
            } else {
                println("More work to do.")
                println(error.description)
            }
        }
     
*/
        
        
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
//
//  TAUserData.swift
//  ThreeActions
//
//  Created by Jason Martin on 3/7/15.
//  Copyright (c) 2015 Revolvity LLC. All rights reserved.
//

import Foundation

struct TAUsers {
    
    var userAccount: String
    
    //INIT
    init(){
        //setting username to PFUser so if user isn't logged in, this all fails.
        self.userAccount = PFUser.currentUser().username
    }
    //METHODS
    
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
        println("Completed Network Request with a value of: \(status)")
        return status
    }
    
    //end TAUserData
}
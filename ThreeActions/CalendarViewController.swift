//
//  CalendarViewController.swift
//  ThreeActions
//
//  Created by Jason Martin on 3/24/15.
//  Copyright (c) 2015 Revolvity LLC. All rights reserved.
//

import UIKit

class CalendarViewController: UIViewController ,UITableViewDelegate, UITableViewDataSource {
    
    //create array of dictionaries to hold info
    
    var rowData = [Int]()
    var cleanSortData = [Int]()
    
    //Create Table View
   var tableView: UITableView  =   UITableView()
    
   override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
    
    
    view.backgroundColor = UIColor.appOffWhite()
    
    tableView.backgroundColor = UIColor.appOffWhite()
    tableView.tintColor = UIColor.appOffWhite()
    
    rowData.removeAll(keepCapacity: false)
    
    for key in TAUsers.sharedInstance.actionCalendarDB {
            rowData.append(key.0)
    }
    
    cleanSortData = sorted(rowData, {
        (str1: Int, str2: Int) -> Bool in
        return str1 < str2
    })
    
    
        tableView.frame         =   CGRectMake(0, 20, self.view.frame.size.width, self.view.frame.size.height);
        tableView.delegate      =   self
        tableView.dataSource    =   self
        
        tableView.registerClass(UITableViewCell.self, forCellReuseIdentifier: "cell")
       // view.backgroundColor = UIColor.appColorBackground()
        ///tableView.backgroundColor = UIColor.appDustyWall()
        //tableView.tintColor = UIColor.appDustyWall()
        
        self.view.addSubview(tableView)
    
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return cleanSortData.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: .Subtitle, reuseIdentifier: "MyTestCell")
        
        
        var raDate = ""
        var raColor = ""
        var raTitle = ""
        var raStatus = ""
        
        //get index #, key for dictionary and data
        if let cdActionDate = TAUsers.sharedInstance.actionCalendarDB[cleanSortData[indexPath.row]]?.valueForKey("actionDate") {
            raDate = toString(cdActionDate)
        }
        
        if let cdColor = TAUsers.sharedInstance.actionCalendarDB[cleanSortData[indexPath.row]]?.valueForKey("actionColor") {
            raColor = toString(cdColor)
        }
        
        if let cdTitle = TAUsers.sharedInstance.actionCalendarDB[cleanSortData[indexPath.row]]?.valueForKey("actionTitle") {
            raTitle = toString(cdTitle)
        }
        
        if let cdStatus = TAUsers.sharedInstance.actionCalendarDB[cleanSortData[indexPath.row]]?.valueForKey("actionStatus") {
            raStatus = toString(cdStatus)
        }
        
        
        
        cell.textLabel?.text = raTitle.uppercaseString
        cell.detailTextLabel?.text = raDate
        
        //color
        if(raColor == "1"){
            cell.backgroundColor = UIColor.appActionOne()
        }
        
        if(raColor == "2"){
            cell.backgroundColor = UIColor.appActionTwo()
        }
        
        if(raColor == "3"){
            cell.backgroundColor = UIColor.appActionThree()
        }
        
        //status
        
        if(raStatus == "1") {
            cell.textLabel?.text = raTitle.lowercaseString
            cell.backgroundColor = UIColor.appGhostWhiteFade()
            cell.textLabel?.textColor = UIColor.appDustyWallFade()
            cell.detailTextLabel?.textColor = UIColor.appDustyWallFade()
        }
        
        return cell
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
        
        //this is called when user clicks on a row
        
        let row = indexPath.row
        let dbKey = self.cleanSortData[row]
        
        var actionColor = 0
        var actionTitle = ""
        var actionDescription = ""
        var actionStatus = 44
        var actionDate = ""
        var objectID = ""

        
        if let cdActionTitle = TAUsers.sharedInstance.actionCalendarDB[dbKey]?.valueForKey("actionTitle") {
            actionTitle = toString(cdActionTitle).uppercaseString
        }
        
        if let cdActionDescription = TAUsers.sharedInstance.actionCalendarDB[dbKey]?.valueForKey("actionDescription") {
            actionDescription = toString(cdActionDescription)
        }
        
        
        if let cdActionStatus = TAUsers.sharedInstance.actionCalendarDB[dbKey]?.valueForKey("actionStatus") {
            actionStatus = cdActionStatus.integerValue
        }
        
        if let cdActionColor = TAUsers.sharedInstance.actionCalendarDB[dbKey]?.valueForKey("actionColor") {
            actionColor = cdActionColor.integerValue
        }
        
        if let cdActionDate = TAUsers.sharedInstance.actionCalendarDB[dbKey]?.valueForKey("actionDate") {
            actionDate = toString(cdActionDate)
        }
        
        if let cdObjectID = TAUsers.sharedInstance.actionCalendarDB[dbKey]?.objectId {
            objectID = toString(cdObjectID)
        }
        
        
        if(actionTitle != "" && actionDescription != "") {
            let singleActionVC = storyboard?.instantiateViewControllerWithIdentifier("SingleActionViewController") as SingleActionViewController
            
            singleActionVC.actionColor = actionColor
            singleActionVC.actionTitle = actionTitle
            singleActionVC.actionDescription = actionDescription
            singleActionVC.actionStatus = actionStatus
            singleActionVC.actionDate = actionDate
            singleActionVC.objectID = objectID
            singleActionVC.callingViewController = .Calendar
            
            presentViewController(singleActionVC, animated: true, completion: nil)
        }

        
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
}


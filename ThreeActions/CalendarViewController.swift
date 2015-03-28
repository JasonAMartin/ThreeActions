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
    
    var rowData = [String]()
    
    //Create Table View
   var tableView: UITableView  =   UITableView()
    
   override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
    
    view.backgroundColor = UIColor.appOffWhite()
    
    tableView.backgroundColor = UIColor.appOffWhite()
    tableView.tintColor = UIColor.appOffWhite()
    
    rowData.removeAll(keepCapacity: false)
    
    for key in TAUsers.sharedInstance.actionDB {
            rowData.append(key.0)
    }
    
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
        return rowData.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: .Subtitle, reuseIdentifier: "MyTestCell")
        
        
        var raDate = ""
        var raColor = ""
        var raTitle = ""
        var raStatus = ""
        
        //get index #, key for dictionary and data
        if let cdActionDate = TAUsers.sharedInstance.actionDB[rowData[indexPath.row]]?.valueForKey("actionDate") {
            raDate = toString(cdActionDate)
        }
        
        if let cdColor = TAUsers.sharedInstance.actionDB[rowData[indexPath.row]]?.valueForKey("actionColor") {
            raColor = toString(cdColor)
        }
        
        if let cdTitle = TAUsers.sharedInstance.actionDB[rowData[indexPath.row]]?.valueForKey("actionTitle") {
            raTitle = toString(cdTitle)
        }
        
        if let cdStatus = TAUsers.sharedInstance.actionDB[rowData[indexPath.row]]?.valueForKey("actionStatus") {
            raStatus = toString(cdStatus)
        }
        
        
        
        cell.textLabel?.text = raTitle
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
            cell.backgroundColor = UIColor.appOffWhite()
        }
        
        return cell
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


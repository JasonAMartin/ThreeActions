//
//  SingleActionViewController.swift
//  ThreeActions
//
//  Created by Jason Martin on 3/20/15.
//  Copyright (c) 2015 Revolvity LLC. All rights reserved.
//

import UIKit
import QuartzCore

class SingleActionViewController: UIViewController {
    
    var actionColor = 0
    var actionTitle = ""
    var actionDescription = ""
    var actionStatus = 0
    var actionDate = ""
    
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        self.view.backgroundColor = UIColor.appErrorRed()
        
        println(actionDate)
        println(actionStatus)
        println(actionTitle)
        println(actionDescription)
        println(actionColor)
        
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


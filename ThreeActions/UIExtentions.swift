//
//  UIExtentions.swift
//  ThreeActions
//
//  Created by Jason Martin on 2/21/15.
//  Copyright (c) 2015 Revolvity LLC. All rights reserved.
//

import Foundation
import UIKit

extension UIViewController {
    
    class func  buttonCreator(button:UIButton){
        button.layer.cornerRadius = 5
        button.layer.borderColor = UIColor.appDarkPlum().CGColor
        button.layer.borderWidth = 0.5
        button.backgroundColor = UIColor.appPlum()
        
        button.setTitleColor(UIColor.appGhostWhite(), forState: UIControlState.Normal)
        button.setTitleColor(UIColor.appLightBase(), forState: UIControlState.Highlighted)
    }
    
    class func  buttonCreatorAction(button:UIButton){
        button.layer.cornerRadius = 5
        button.layer.borderColor = UIColor.appDarkPlum().CGColor
        button.layer.borderWidth = 0.5
        button.backgroundColor = UIColor.appSage()
        
        button.setTitleColor(UIColor.appShadyGhost(), forState: UIControlState.Normal)
        button.setTitleColor(UIColor.appMidnight(), forState: UIControlState.Highlighted)
    }
    
    class func  buttonCreatorDismiss(button:UIButton){
        button.layer.cornerRadius = 5
        button.layer.borderColor = UIColor.appDarkPlum().CGColor
        button.layer.borderWidth = 0.5
        button.backgroundColor = UIColor.appMidnight()
        
        button.setTitleColor(UIColor.appGhostWhite(), forState: UIControlState.Normal)
        button.setTitleColor(UIColor.appLightBase(), forState: UIControlState.Highlighted)
    }
}

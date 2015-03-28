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
        //plum
        button.layer.cornerRadius = 15
        button.layer.borderColor = UIColor.appColorButtonNormal().CGColor
        button.layer.borderWidth = 0.5
        button.backgroundColor = UIColor.appColorButtonNormal()
        
        button.setTitleColor(UIColor.appGhostWhite(), forState: UIControlState.Normal)
        button.setTitleColor(UIColor.appLightBase(), forState: UIControlState.Highlighted)
    }
    
    class func  buttonCreatorAction(button:UIButton){
        //sage
        button.layer.cornerRadius = 15
        button.layer.borderColor = UIColor.appColorButtonNormal().CGColor
        button.layer.borderWidth = 0.5
        button.backgroundColor = UIColor.appColorButtonNormal()
        
        button.setTitleColor(UIColor.appShadyGhost(), forState: UIControlState.Normal)
        button.setTitleColor(UIColor.appMidnight(), forState: UIControlState.Highlighted)
    }
    
    class func  buttonCreatorDismiss(button:UIButton){
        //midnight
        button.layer.cornerRadius = 15
        button.layer.borderColor = UIColor.appColorButtonNormal().CGColor
        button.layer.borderWidth = 0.5
        button.backgroundColor = UIColor.appColorButtonNormal()
        
        button.setTitleColor(UIColor.appGhostWhite(), forState: UIControlState.Normal)
        button.setTitleColor(UIColor.appLightBase(), forState: UIControlState.Highlighted)
    }
    
    
    class func  actionSectionButton(button:UIButton){
        //buttons for the 3 action section in Today view
        button.layer.cornerRadius = 15
        button.layer.borderColor = UIColor.appColorButtonNormal().CGColor
        button.layer.borderWidth = 0.5        
    }
    
    class func roundedButton(button:UIButton){
        button.layer.cornerRadius = 15
        button.layer.borderColor = UIColor.appColorButtonNormal().CGColor
        button.layer.borderWidth = 0.1
    }
    
    class func logo() -> UIImageView{
        let logoFile = "ThreeActionsLogoV2"
        let logoImage = UIImage(named: logoFile)
        let logo = UIImageView(image: logoImage!)
        logo.sizeToFit()
        return logo
    }
    
    class func textInput(#placeholder: String, #bgColor: UIColor) -> UITextField {
        let textField = UITextField(frame: CGRect(x: 0, y: 0, width: 200.00, height: 40.00))
        textField.backgroundColor = bgColor
        textField.placeholder = placeholder
        textField.layer.cornerRadius = 15.0
        textField.textAlignment = .Center
        return textField
    }
    
    class func textView(#bgColor: UIColor) -> UITextView {
        let textView =  UITextView(frame: CGRect(x: 0, y:0, width: 200.00, height:40.00))
        textView.backgroundColor = bgColor
        textView.layer.cornerRadius = 15.0
        textView.textAlignment = .Left
        textView.textColor = UIColor.appMidnight()
        return textView
    }
    
}

//
//  Colors.swift
//  ThreeActions
//
//  Created by Jason Martin on 2/21/15.
//  Copyright (c) 2015 Revolvity LLC. All rights reserved.
//

import Foundation
import UIKit

extension UIColor {
    class func appPlum() -> UIColor {
        return UIColor(red: 129.0/255.0, green: 65.0/255.0, blue: 94.0/255.0, alpha: 1.0)
    }
    class func appDarkPlum() -> UIColor {
        return UIColor(red: 77.0/255.0, green: 40.0/255.0, blue: 58.0/255.0, alpha: 1.0)
    }
    class func appGhostWhite() -> UIColor {
        return UIColor(red: 248.0/255.0, green: 248.0/255.0, blue: 255.0/255.0, alpha: 1.0)
    }
    class func appMidnight() -> UIColor {
        return UIColor(red: 55.0/255.0, green: 47.0/255.0, blue: 51.0/255.0, alpha: 1.0)
    }
    class func appDustyWall() -> UIColor {
        return UIColor(red: 130.0/255.0, green: 109.0/255.0, blue: 118.0/255.0, alpha: 1.0)
    }
    class func appDarkBase() -> UIColor {
        return UIColor(red: 215.0/255.0, green: 182.0/255.0, blue: 199.0/255.0, alpha: 1.0)
    }
    class func appLightBase() -> UIColor {
        return UIColor(red: 229.0/255.0, green: 213.0/255.0, blue: 209.0/255.0, alpha: 1.0)
    }
    class func grayScaleColor(grayScale : CGFloat) -> UIColor {
        return UIColor(red: grayScale/255.0, green: grayScale/255.0, blue: grayScale/255.0, alpha: 1.0)
    }
}

struct ColorWheel {

    //setting up all the colors for the app with a dictionary
    
    let appColors: [String:UIColor] = [

    "darkCoat": UIColor(red: 70/255.0, green: 70/255.0, blue: 70/255.0, alpha: 1.0)
    ]
       }
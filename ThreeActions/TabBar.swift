//
//  TabBar.swift
//  ThreeActions
//
//  Created by Jason Martin on 3/27/15.
//  Copyright (c) 2015 Revolvity LLC. All rights reserved.
//

import Foundation

class TabBar: UITabBar {
    
    override func sizeThatFits(size: CGSize) -> CGSize {
        super.sizeThatFits(size)
        
        var sizeThatFits = super.sizeThatFits(size)
        sizeThatFits.height = 66
        
        return sizeThatFits
    }
}
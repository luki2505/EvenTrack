//
//  BorderManager.swift
//  bezline
//
//  Created by Lukas on 03.05.16.
//  Copyright © 2016 Lukas. All rights reserved.
//

import Foundation
import UIKit

class BorderManager {
    
    static func getTop(_ item: AnyObject) -> CALayer {
        let border = CALayer()
        border.frame = CGRect(x: 0.0, y: 0.0, width: item.frame.size.width, height: 1.0)
        border.backgroundColor = UIColor(red:0.65, green:0.65, blue:0.67, alpha:0.5).cgColor
        return border
    }
    
    static func getSplit(_ item: AnyObject) -> CALayer {
        let border = CALayer()
        border.frame = CGRect(x: 20.0, y: item.frame.size.height - 1, width: item.frame.size.width, height: 1.0)
        border.backgroundColor = UIColor(red:0.78, green:0.78, blue:0.79, alpha:0.5).cgColor
        return border
    }
    
    static func getBottom(_ item: AnyObject) -> CALayer {
        let border = CALayer()
        border.frame = CGRect(x: 0.0, y: item.frame.size.height - 1, width: item.frame.size.width, height: 1.0)
        border.backgroundColor = UIColor(red:0.65, green:0.65, blue:0.67, alpha:0.5).cgColor
        return border
    }
}

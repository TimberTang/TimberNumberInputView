//
//  Color.swift
//  TimberNumberInputView
//
//  Created by TimberTang on 2017/8/23.
//  Copyright © 2017年 TimberTang. All rights reserved.
//

import Foundation
import UIKit
extension UIColor {
    public convenience init(rgbValue: UInt32) {
        let red   = CGFloat((rgbValue >> 16) & 0xff) / 255.0
        let green = CGFloat((rgbValue >>  8) & 0xff) / 255.0
        let blue  = CGFloat((rgbValue      ) & 0xff) / 255.0
        
        self.init(red: red, green: green, blue: blue, alpha: 1)
    }
}

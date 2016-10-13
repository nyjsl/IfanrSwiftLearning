//
//  NSMutableAttribtedStringExt.swift
//  IFanSwiftLearning
//
//  Created by 魏星 on 16/10/13.
//  Copyright © 2016年 wx. All rights reserved.
//

import Foundation
import UIKit

extension NSMutableAttributedString{
    
    class func attribute(text: String) -> NSMutableAttributedString{
        let attribute = NSMutableAttributedString(string: text)
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineSpacing = 5
        attribute.addAttribute(NSParagraphStyleAttributeName, value: paragraphStyle, range: NSRange(location: 0,length: text.length))
        return attribute
    }
}

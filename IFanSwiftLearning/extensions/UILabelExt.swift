//
//  UILabelExt.swift
//  IFanSwiftLearning
//
//  Created by 魏星 on 2016/10/18.
//  Copyright © 2016年 wx. All rights reserved.
//

import Foundation
import UIKit

extension UILabel{
    
    
    class func setAttrubutedText(content: String?,lineSpacing: CGFloat) -> NSAttributedString{
        let attrs = NSMutableAttributedString(string: content!)
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineSpacing = lineSpacing
        paragraphStyle.firstLineHeadIndent    = 0.0
        paragraphStyle.hyphenationFactor      = 0.0
        paragraphStyle.paragraphSpacingBefore = 0.0
        attrs.addAttribute(NSParagraphStyleAttributeName,value: paragraphStyle,
                           range: NSMakeRange(0, (content!.characters.count)))
        return attrs
    }
}
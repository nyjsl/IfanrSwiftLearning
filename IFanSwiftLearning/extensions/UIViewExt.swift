//
//  UIViewExt.swift
//  IFanSwiftLearning
//
//  Created by 魏星 on 16/9/11.
//  Copyright © 2016年 wx. All rights reserved.
//

import UIKit
/**
 frame是CGRect结构体类型的，结构体有个规定，不能单独修改结构体内部的任何一个属性，只能用一个新建的结构体覆盖掉原来的结构体
**/
extension UIView{
    
    
    public var x: CGFloat{
        get {
            return self.frame.origin.x
        }
        
        set{
            var newFrame = self.frame
            newFrame.origin.x = newValue
            self.frame = newFrame
        }
    }
    
    public var y: CGFloat{
        get{
            return self.frame.origin.y
        }
        
        set{
            var newFrame = self.frame
            newFrame.origin.y = newValue
            self.frame = newFrame
        }
    }
    
    public var width: CGFloat{
        get{
            return self.frame.width
        }
        
        set{
            var newFrame = self.frame
            newFrame.size.width = newValue
            self.frame = newFrame
        }
    }
    
    public var height: CGFloat{
        get{
            return self.frame.height
        }
        
        set{
            var newFrame = self.frame
            newFrame.size.height = newValue
            self.frame = newFrame
        }
    }
    
    public var size: CGSize{
        get{
            return self.frame.size
        }
        
        set{
            var newFrame = self.frame
            newFrame.size = newValue
            self.frame = newFrame
        }
    }
    
    public var origin: CGPoint{
        get{
            return self.frame.origin
        }
        set{
            var newFrame = self.frame
            newFrame.origin = newValue
            self.frame = newFrame

        }
    }
    
    public var bottom: CGFloat{
        get{
            return self.frame.origin.y + self.frame.size.height
        }
        
    }
    
    
}

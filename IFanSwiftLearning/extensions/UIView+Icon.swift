//
//  UIView+Icon.swift
//  IFanSwiftLearning
//
//  Created by 魏星 on 2016/10/16.
//  Copyright © 2016年 wx. All rights reserved.
//

import Foundation
import UIKit

let IPHONE6_HEIGHT: CGFloat  = 667
let HJVIconKey: String       = "HJVIconKey";
let kBaseSize: CGFloat       = 101.0

extension UIView{
    
    func showICon(num: String?){
        if num != nil && getIcon(num!) != nil{
            self.addSubview(getIcon(num!)!)
        }
    }
    
    func getIcon(num: String) -> UIView?{
        self.dismissV()
        let existingActivityView: UIView? = objc_getAssociatedObject(self, HJVIconKey) as? UIView ?? nil
        var vLabel = existingActivityView as? UILabel ?? nil
        if existingActivityView == nil{
            vLabel = UILabel()
            vLabel?.backgroundColor = UIColor(red: 211/255.0, green: 55/255.0, blue: 38/255.0, alpha: 1.0)
            self.superview?.addSubview(vLabel!)
            objc_setAssociatedObject(self, HJVIconKey, vLabel, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        }
        vLabel?.frame = CGRect(x: 0, y: 0, width: 15, height: 15)
        vLabel?.textColor = UIColor.whiteColor()
        vLabel?.font = UIFont.customFont_FZLTZCHJW(fontSize: 9)
        vLabel?.layer.cornerRadius = 7.5
        vLabel?.layer.masksToBounds = true
        vLabel?.textAlignment = .Center
        vLabel?.text = num
        
        var center = CGPoint(x: self.width*0.83, y: self.height*0.83)
        center = self.convertPoint(center, toView: self.superview)
        vLabel?.center = center
        
        if CGRectGetMaxY((vLabel?.frame)!) > CGRectGetMaxY((self.superview?.frame)!){
            vLabel?.center = CGPoint(x: 15*1.45, y: 15*0.1)
        }
        return vLabel
    }
    
    func dismissV(){
        
        let  existingActivityView: UIView? = objc_getAssociatedObject(self, HJVIconKey) as? UIView ?? nil
        if existingActivityView != nil{
            existingActivityView?.removeFromSuperview()
            objc_setAssociatedObject(self, HJVIconKey, nil, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        }
        
    }
    
    func uxy_rounedRectWith(raduis:CGFloat,corners: UIRectCorner) -> UIView{
        let maskPath: UIBezierPath = UIBezierPath(roundedRect: self.bounds, byRoundingCorners: corners, cornerRadii: CGSizeMake(raduis, raduis))
        let maskLayer = CAShapeLayer()
        maskLayer.frame = self.bounds
        maskLayer.path = maskPath.CGPath
        self.layer.mask = maskLayer
        return self
    }
    
    
    
    
}
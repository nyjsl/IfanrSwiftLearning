//
//  UIImageViewExt.swift
//  IFanSwiftLearning
//
//  Created by 魏星 on 16/10/13.
//  Copyright © 2016年 wx. All rights reserved.
//

import UIKit
import YYWebImage

extension UIImageView{
    
    func extSetImage(imgUrl:NSURL!){
        self.yy_setImageWithURL(imgUrl, placeholder: UIImage(named: "place_holder_image"), options: [.SetImageWithFadeAnimation,.ProgressiveBlur],completion: nil)
    }
    
    func extSetAvatar(avatarUrl: NSURL!) {
        self.yy_setImageWithURL(avatarUrl, placeholder: UIImage(named: "place_holder_avatar"), options: [.SetImageWithFadeAnimation, .ProgressiveBlur], completion: nil)
    }
}

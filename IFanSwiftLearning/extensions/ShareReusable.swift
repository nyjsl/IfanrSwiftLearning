//
//  ShareReusable.swift
//  IFanSwiftLearning
//
//  Created by 魏星 on 2016/10/15.
//  Copyright © 2016年 wx. All rights reserved.
//

import Foundation

import MonkeyKing

public protocol ShareReusable: ShareViewDelegate{
    
    var shareView: ShareView?{get set}
    var shadowView: UIView?{get set}
    
}

extension ShareReusable where Self: UIViewController{
    
    func hideShareView(){
        UIView.animateWithDuration(0.3, animations: { 
            self.shadowView?.alpha = 0
            self.shareView?.center.y += 170
            }) { (result) in
                if result{
                    self.shadowView?.removeFromSuperview()
                    self.shareView?.removeFromSuperview()
                }
        }
    }
    
    func showShareView(){
        
        self.shareView =
            ShareView(frame: CGRect(x: 0, y: UIConstant.SCREEN_HEIGHT, width: UIConstant.SCREEN_WIDTH, height: UIConstant.SCREEN_HEIGHT))
        self.shareView!.delegate = self
        
        self.shadowView = UIView(frame: self.view.frame)
        self.shadowView?.alpha = 0
        self.shadowView?.backgroundColor = UIColor.blackColor()
        
        let window: UIWindow = UIApplication.sharedApplication().keyWindow!
        window.addSubview(shareView!)
        window.addSubview(shadowView!)
        
        UIView.animateWithDuration(0.3, animations: { 
            self.shadowView?.alpha = 0.5
            self.shareView?.center.y -= 170
        })
        
    }
    
    
    func shareToFriend(shareContent: String, shareImageUrl: String, shareUrl: String, shareTitle: String)  {
        
//        let message = MonkeyKing.Message.WeChat(.Session(info: (
//            title: shareTitle,
//            description: shareContent,
//            thumbnail:  UIImage(data: NSData(contentsOfURL: NSURL(string: shareImageUrl)!)!),
//            media: .URL(NSURL(string: shareUrl)!)
//        )))
//        
//        MonkeyKing.shareMessage(message) { success in
//            print("shareURLToWeChatSession success: \(success)")
//        }
    }
    
    func shareToFriendsCircle(shareContent: String, shareTitle: String, shareUrl: String, shareImageUrl: String) {
        
        
//        let message = MonkeyKing.Message.WeChat(.Timeline(info: (title: shareTitle,
//            description: shareContent,
//            thumbnail: UIImage(data: NSData(contentsOfURL: NSURL(string: shareImageUrl)!)!),
//            media: .URL(NSURL(string: shareUrl)!))))
//        
//        MonkeyKing.shareMessage(message) { (result) in
//            print("share to TimeLine Success:\(result)...")
//        }
    }
    

}

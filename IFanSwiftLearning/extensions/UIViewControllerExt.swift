//
//  UIViewControllerExt.swift
//  IFanSwiftLearning
//
//  Created by 魏星 on 16/10/15.
//  Copyright © 2016年 wx. All rights reserved.
//

import Foundation
import UIKit
import SnapKit

extension UIViewController{
    
    func showProgress(){
        
        let progressView = UIActivityIndicatorView()
        progressView.activityIndicatorViewStyle = .Gray
        progressView.hidesWhenStopped = true
        progressView.tag = 500
        self.view.addSubview(progressView)
        
        progressView.snp_makeConstraints { (make) in
            make.center.equalTo(self.view)
            make.height.width.equalTo(20)
        }
        
        progressView.startAnimating()
    }
    
    func hideProgress(){
        for view in self.view.subviews{
            if view.tag == 500{
                let indicatorView = view as! UIActivityIndicatorView
                indicatorView.stopAnimating()
                indicatorView.removeFromSuperview()
            }
        }
    }
    
}
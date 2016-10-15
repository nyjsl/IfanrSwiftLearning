//
//  HeaderBackView.swift
//  IFanSwiftLearning
//
//  Created by 魏星 on 16/10/15.
//  Copyright © 2016年 wx. All rights reserved.
//

import Foundation
import UIKit
import SnapKit

protocol HeaderViewDelegate {
    func backButtonDidClick()
}

class HeaderBackView: UIView{
    
    var delegate: HeaderViewDelegate?
    
    var title: String! = "" {
        didSet{
            self.titleLabel.text = title
        }
    }
    
    convenience init(title: String) {
        self.init()
        self.title = title
        backgroundColor = UIColor.clearColor()
        addSubview(blurView)
        addSubview(backButton)
        addSubview(titleLabel)
        setUpLayout()
        
    }
    
    private func setUpLayout(){
        blurView.snp_makeConstraints { (make) in
            make.edges.equalTo(self)
        }
        
        backButton.snp_makeConstraints { (make) in
            make.left.equalTo(self).offset(15)
            make.centerY.equalTo(self)
            make.width.equalTo(20)
            make.height.equalTo(15)
        }
        
        titleLabel.snp_makeConstraints { (make) in
            make.left.equalTo(self.backButton.snp_right)
            make.centerY.equalTo(self)
            make.height.equalTo(40)
            make.width.equalTo(100)
        }
        
    }
    
    //MARK  ------ACTION EVENT------
    @objc private func goBack(){
        self.delegate?.backButtonDidClick()
    }
    
    //MARK  -----------getter and setter-----
    
    private lazy var backButton: UIButton = {
        let button: UIButton = UIButton()
        button.setImage(UIImage(imageLiteral: "ic_article_back"), forState: .Normal)
        button.imageView?.contentMode = .ScaleAspectFit
        button.addTarget(self, action: #selector(goBack), forControlEvents: .TouchUpInside)
        return button
    }()
    
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.text = self.title
        label.font = UIFont.customFont_FZLTZCHJW(fontSize: 14)
        return label
    }()
    
    private lazy var blurView: UIVisualEffectView = {
        let blurEffect: UIBlurEffect = UIBlurEffect(style: .Light)
        let blurView: UIVisualEffectView = UIVisualEffectView(effect: blurEffect)
        return blurView
    }()
    
}
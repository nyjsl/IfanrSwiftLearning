//
//  ShareView.swift
//  IFanSwiftLearning
//
//  Created by 魏星 on 2016/10/15.
//  Copyright © 2016年 wx. All rights reserved.
//


import Foundation
import UIKit

public protocol ShareViewDelegate: class{
    
    func wxShareBtnDidClick()
    func wxCircleShareBtnDidClick()
    func shareMoreBtnDidClick()
    
}

public class ShareView: UIView{
    
    var delegate: ShareViewDelegate?
    
    //MARK -life cycle--
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.addSubview(self.wxShareBtn)
        self.addSubview(self.wxCircleShareBtn)
        self.addSubview(self.shareMoreButton)
        self.addSubview(self.logoShareImageView)
        self.addSubview(titleLabel)
        self.addSubview(wxShareLabel)
        self.addSubview(shareMoreLabel)
        self.addSubview(wxCircleShareLabel)
        self.backgroundColor = UIColor(red: 250/255.0, green: 250/255.0, blue: 250/255.0, alpha: 1.0)
        self.setupLayout()

    }
    
    private func setupLayout(){
        logoShareImageView.snp_makeConstraints { (make) in
            make.top.left.equalTo(self).offset(20)
            make.height.width.equalTo(13)
        }
        titleLabel.snp_makeConstraints { (make) in
            make.left.equalTo(logoShareImageView.snp_right).offset(10)
            make.width.equalTo(150)
            make.height.equalTo(30)
            make.centerY.equalTo(logoShareImageView)
        }
        wxShareBtn.snp_makeConstraints { (make) in
            make.top.equalTo(logoShareImageView.snp_bottom).offset(30)
            make.left.equalTo(self).offset(30)
            make.width.equalTo(50)
            make.height.equalTo(50)
        }
        
        wxCircleShareBtn.snp_makeConstraints { (make) in
            make.top.equalTo(logoShareImageView.snp_bottom).offset(30)
            make.centerX.equalTo(self)
            make.width.height.equalTo(50)
        }
        
        shareMoreButton.snp_makeConstraints { (make) in
            make.top.equalTo(logoShareImageView.snp_bottom).offset(30)
            make.right.equalTo(self).offset(-30)
            make.width.height.equalTo(50)
        }
        
        wxShareLabel.snp_makeConstraints { (make) in
            make.top.equalTo(wxShareBtn.snp_bottom).offset(10)
            make.centerX.equalTo(wxShareBtn)
            make.width.equalTo(150)
        }
        
        wxCircleShareLabel.snp_makeConstraints { (make) in
            make.top.equalTo(wxCircleShareBtn.snp_bottom).offset(10)
            make.centerX.equalTo(wxCircleShareBtn)
            make.width.equalTo(150)
        }
        
        shareMoreLabel.snp_makeConstraints { (make) in
            make.top.equalTo(shareMoreButton.snp_bottom).offset(10)
            make.centerX.equalTo(shareMoreButton)
            make.width.equalTo(150)
        }

    }
    
    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK ACTION
    func wxShareAction(){
        self.delegate?.wxShareBtnDidClick()
    }
    
    func wxCirCleAction(){
        self.delegate?.wxCircleShareBtnDidClick()
    }
    
    func shareMoreAction(){
        self.delegate?.shareMoreBtnDidClick()
    }
    
    //MARK Setter Getter
    private lazy var wxShareBtn: UIButton = {
        let button: UIButton = UIButton()
        button.setImage(UIImage(named: "share_wechat"), forState: .Normal)
        button.setTitle("微信朋友", forState: .Normal)
        button.setTitleColor(UIColor.blackColor(), forState: .Normal)
        button.imageView?.contentMode = .ScaleAspectFit
        button.addTarget(self, action: #selector(wxShareAction), forControlEvents: .TouchUpInside)
        return button
    }()
    
    private lazy var wxShareLabel: UILabel = {
        let label = UILabel()
        label.text = "微信朋友"
        label.textAlignment = .Center
        label.textColor = UIColor(red: 82/255.0, green: 78/255.0, blue: 80/255.0, alpha: 1.0)
        label.font = UIFont.systemFontOfSize(13)
        return label
    }()
    
    private lazy var wxCircleShareBtn: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: "share_wechat_moment"), forState: .Normal)
        button.setTitle("朋友圈", forState: .Normal)
        button.addTarget(self, action: #selector(wxCirCleAction), forControlEvents: .TouchUpInside)
        return button
    }()
    
    
    private lazy var wxCircleShareLabel: UILabel = {
        let label = UILabel()
        label.text = "朋友圈"
        label.textAlignment = .Center
        label.textColor = UIColor(red: 82/255.0, green: 78/255.0, blue: 80/255.0, alpha: 1.0)
        label.font = UIFont.systemFontOfSize(13)
        return label
    }()
    
    // 分享更多
    private lazy var shareMoreButton: UIButton = {
        let shareMoreButton = UIButton()
        shareMoreButton.setImage(UIImage(named: "share_more"), forState: .Normal)
        shareMoreButton.setTitle("更多", forState: .Normal)
        shareMoreButton.addTarget(self, action: #selector(shareMoreAction), forControlEvents: .TouchUpInside)
        
        return shareMoreButton
    }()
    private lazy var shareMoreLabel: UILabel = {
        let shareMoreLabel = UILabel()
        shareMoreLabel.text = "更多"
        shareMoreLabel.textAlignment = .Center
        shareMoreLabel.textColor = UIColor(red: 82/255.0, green: 78/255.0, blue: 80/255.0, alpha: 1.0)
        shareMoreLabel.font = UIFont.systemFontOfSize(13)
        
        return shareMoreLabel
    }()

    // logo
    private lazy var logoShareImageView: UIImageView = {
        let logoShareImageView = UIImageView()
        logoShareImageView.image = UIImage(named: "ic_dialog_share")
        
        return logoShareImageView
    }()
    // titleLabel
    private lazy var titleLabel: UILabel = {
        let titleLabel = UILabel()
        titleLabel.text = "分享文章给朋友:"
        titleLabel.font = UIFont.systemFontOfSize(14.0)
        titleLabel.textColor = UIColor(red: 124/255.0, green: 129/255.0, blue: 142/255.0, alpha: 1.0)
        
        return titleLabel
    }()

    
}
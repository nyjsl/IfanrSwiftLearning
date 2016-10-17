//
//  CommentHeaderView.swift
//  IFanSwiftLearning
//
//  Created by 魏星 on 2016/10/17.
//  Copyright © 2016年 wx. All rights reserved.
//

import Foundation

import UIKit
import SnapKit

protocol CommentHeaderDelegate {
    func gobackBtnDidClick()
    func timeSortedBtnDidClick(sender: UIButton)
    func heatSortedBtnDidClick(sender: UIButton)
}

class CommentHeaderView: UIView{
    
    private var model: CommonModel?
    
    var delegate: CommentHeaderDelegate?
    
    convenience init(model: CommonModel?){
        self.init()
        self.model = model
        
        self.topView.addSubview(self.goBackContainer)
        self.topView.addSubview(self.goBackBtn)
        self.topView.addSubview(self.titleLabel)
        self.bottomView.addSubview(hintLabel)
        self.bottomView.addSubview(self.timeSortedButton)
        self.bottomView.addSubview(self.line)
        self.bottomView.addSubview(self.heatSortedButton)
        
        self.addSubview(topView)
        self.addSubview(bottomView)
        userInteractionEnabled = true
        timeSortedButton.selected = true
        
        setupLayout()
        
    }
    
    private func setupLayout(){
        self.topView.snp_makeConstraints { (make) in
            make.left.right.top.equalTo(self)
            make.height.equalTo(44)
        }
        self.bottomView.snp_makeConstraints { (make) in
            make.left.right.equalTo(self)
            make.top.equalTo(self.topView.snp_bottom)
            make.height.equalTo(40)
        }
        
        /// topView layout
        self.goBackContainer.snp_makeConstraints { (make) in
            make.top.bottom.left.equalTo(self)
            make.width.equalTo(44)
        }
        self.goBackBtn.snp_makeConstraints { (make) in
            make.left.equalTo(self.topView).offset(15)
            make.top.equalTo(self.topView).offset(14.5)
            make.width.equalTo(17)
            make.height.equalTo(15)
        }
        self.titleLabel.snp_makeConstraints { (make) in
            make.centerX.centerY.equalTo(self.topView)
            make.width.equalTo(100)
            make.height.equalTo(30)
        }
        
        /// bottomView layout
        self.hintLabel.snp_makeConstraints { (make) in
            make.left.equalTo(self.bottomView).offset(15)
            make.centerY.equalTo(self.bottomView)
        }
        self.timeSortedButton.snp_makeConstraints { (make) in
            make.left.equalTo(self.hintLabel.snp_right).offset(5)
            make.centerY.equalTo(self.bottomView)
            make.height.width.equalTo(40)
        }
        self.line.snp_makeConstraints { (make) in
            make.left.equalTo(self.timeSortedButton.snp_right).offset(3)
            make.top.equalTo(self.bottomView).offset(9)
            make.bottom.equalTo(self.bottomView).offset(-9)
            make.width.equalTo(1)
        }
        self.heatSortedButton.snp_makeConstraints { (make) in
            make.left.equalTo(self.line.snp_right).offset(3)
            make.centerY.equalTo(self.bottomView)
            make.height.width.equalTo(40)
        }

    }
    
    @objc private func goBackBtnAction(){
        self.delegate?.gobackBtnDidClick()
    }
    
    @objc private func timeSrotedBtnAction(sender: UIButton){
        self.delegate?.timeSortedBtnDidClick(sender)
    }
    
    @objc private func heatSortBtnAction(sender: UIButton){
        self.delegate?.heatSortedBtnDidClick(sender)
    }
    
    
    //MARK Getter and Setter
    
    private lazy var topView: UIView = {
        let topView = UIView()
        topView.backgroundColor = UIColor.blackColor()
        return topView
    }()
    
    
    private lazy var goBackBtn: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named:"ic_back"), forState: .Normal)
        button.contentMode = .ScaleAspectFit
        button.addTarget(self, action: #selector(goBackBtnAction), forControlEvents: .TouchUpInside)
        return button
    }()
    
    
    /// goBackButton----
    private lazy var goBackContainer: UIButton = {
        let goBackContainer = UIButton()
        goBackContainer.addTarget(self, action: #selector(goBackBtnAction), forControlEvents: .TouchUpInside)
        return goBackContainer
    }()
    
    /// titleLabel
    private lazy var titleLabel: UILabel = {
        let titleLable: UILabel = UILabel()
        titleLable.text = "全部评论(0)"
        titleLable.font = UIFont.boldSystemFontOfSize(15)
        titleLable.textColor = UIColor.whiteColor()
        titleLable.textAlignment = .Center
        return titleLable
    }()
    
    
    /// bottomView
    lazy var bottomView: UIView = {
        let bottomView: UIView = UIView()
        bottomView.backgroundColor = UIColor.whiteColor()
        return bottomView
    }()
    
    
    /// 排序方式
    private lazy var hintLabel: UILabel = {
        let hintLabel: UILabel = UILabel()
        hintLabel.text = "排序方式:"
        hintLabel.textColor = UIColor.lightGrayColor()
        hintLabel.font = UIFont.systemFontOfSize(14)
        return hintLabel
    }()

    private lazy var timeSortedButton: UIButton = {
        let button = UIButton()
        button.setTitle("时间", forState: .Normal)
        button.titleLabel?.font = UIFont.systemFontOfSize(14)
        button.setTitleColor(UIColor(red: 211/255.0, green: 55/255.0, blue: 38/255.0, alpha: 1.0), forState: .Selected)
        button.setTitleColor(UIColor.lightGrayColor(), forState: .Normal)
        button.addTarget(self, action: #selector(timeSrotedBtnAction), forControlEvents: .TouchUpInside)
        return button
    }()
    
    private lazy var line: UIView = {
        let line: UIView = UIView()
        line.backgroundColor = UIColor.lightGrayColor()
        return line
    }()
    
    /// 热度排序
    private lazy var heatSortedButton: UIButton = {
        let heatSortedButton = UIButton()
        heatSortedButton.setTitle("热度", forState: .Normal)
        heatSortedButton.titleLabel?.font = UIFont.systemFontOfSize(14)
        heatSortedButton.setTitleColor(UIColor.lightGrayColor(), forState: .Normal)
        heatSortedButton.setTitleColor(UIColor(red: 211/255.0, green: 55/255.0, blue: 38/255.0, alpha: 1.0), forState: .Selected)
        heatSortedButton.addTarget(self, action: #selector(heatSortBtnAction), forControlEvents: .TouchUpInside)
        return heatSortedButton
    }()

    
    
}

//
//  BottomToolsBar.swift
//  IFanSwiftLearning
//
//  Created by 魏星 on 16/10/15.
//  Copyright © 2016年 wx. All rights reserved.
//

import UIKit
import Foundation


protocol ToolBarDelegate {
    func editCommentDidClick()
    func praiseButtonDidClick()
    func shareButtonDidClick()
    func commentButtonDidClick()

}

class BottomToolsBar: UIView{
    
    var delegate: ToolBarDelegate?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.addSubview(self.praizeButton)
        self.addSubview(self.shareButton)
        self.addSubview(self.commentButton)
        self.addSubview(self.editCommentTextField)
        self.addSubview(self.redLineView)
        
        self.backgroundColor = UIColor.whiteColor()
        self.userInteractionEnabled = true
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc private func praiseButtonAction(){
        self.delegate?.praiseButtonDidClick()
    }
    
    @objc private func editCommentAction(){
        self.delegate?.editCommentDidClick()
    }
    
    @objc private func shareButtonAction() {
        self.delegate?.shareButtonDidClick()
    }
    
    @objc private func commentButtonAction() {
        self.delegate?.commentButtonDidClick()
    }

    
    //MARK -------getter setter
    
    private lazy var redLineView: UIView = {
        let readLineView: UIView = UIView(frame:CGRectMake(20,12.5,2,25))
        readLineView.backgroundColor = UIColor.redColor()
        return readLineView
    }()
    //编辑评论的框
    private lazy var editCommentTextField: UITextField = {
        let textField: UITextField = UITextField(frame: CGRectMake(self.redLineView.x+12,12.5,100,25))
        textField.font = UIFont.customFont_FZLTZCHJW(fontSize: 12)
        textField.placeholder = "您有什么看法呢?"
        textField.contentVerticalAlignment = .Center
        textField.addTarget(self, action: #selector(editCommentAction), forControlEvents: .TouchUpInside)
        return textField
        
    }()
    
    lazy var praizeButton:UIButton = {
        let frame = CGRectMake(UIConstant.SCREEN_WIDTH-115, 12.5, 50, 30)
        let button: UIButton = UIButton(frame: frame)
        button.setImage(UIImage(imageLiteral: "ic_comment_bar_like_false"), forState: .Normal)
        button.setImage((UIImage(imageLiteral: "ic_comment_bar_like_true")), forState: .Selected)
        button.setTitle("点赞(11)", forState: .Normal)
        button.setTitleColor(UIColor.grayColor(), forState: .Normal)
        button.titleLabel?.font = UIFont.customFont_FZLTXIHJW(fontSize: 9)
        button.imageView?.contentMode = .ScaleAspectFit
        button.imageEdgeInsets = UIEdgeInsetsMake(-12, 16, 0, 16)
        button.titleEdgeInsets = UIEdgeInsetsMake(button.currentImage!.size.height-9,-button.currentImage!.size.width,0, 0)
        button.addTarget(self, action: #selector(praiseButtonAction), forControlEvents: .TouchUpInside)
        return button
    }()
    
    /// 分享 button
    lazy var shareButton: UIButton = {
        let shareButton: UIButton = UIButton(frame: CGRectMake(UIConstant.SCREEN_WIDTH-95, 12.5, 30, 30))
        shareButton.setImage(UIImage(imageLiteral: "ic_comment_bar_share"), forState: .Normal)
        shareButton.setTitle("分享", forState: .Normal)
        shareButton.setTitleColor(UIColor.grayColor(), forState: .Normal)
        shareButton.imageView?.contentMode = .ScaleAspectFit
        shareButton.titleLabel?.font = UIFont.customFont_FZLTXIHJW(fontSize: 9)
        shareButton.imageEdgeInsets = UIEdgeInsetsMake(-16, 7, 0, 7)
        shareButton.titleEdgeInsets = UIEdgeInsetsMake(shareButton.currentImage!.size.height-12.5, -shareButton.currentImage!.size.width, 0, 0)
        shareButton.addTarget(self, action: #selector(shareButtonAction), forControlEvents: .TouchUpInside)
        return shareButton
    }()
    /// 评论 button
    internal lazy var commentButton: UIButton = {
        let commentButton: UIButton = UIButton(frame: CGRectMake(UIConstant.SCREEN_WIDTH-45, 12.5, 30, 30))
        commentButton.setImage(UIImage(imageLiteral: "ic_comment"), forState: .Normal)
        commentButton.setTitle("评论", forState: .Normal)
        commentButton.setTitleColor(UIColor.grayColor(), forState: .Normal)
        commentButton.titleLabel?.font  = UIFont.customFont_FZLTXIHJW(fontSize: 9)
        commentButton.imageView?.contentMode = .ScaleAspectFit
        commentButton.imageEdgeInsets = UIEdgeInsetsMake(-12, 6.5, 0, 6.5)
        commentButton.titleEdgeInsets = UIEdgeInsetsMake(commentButton.currentImage!.size.height-10, -commentButton.currentImage!.size.width, 0, 0)
        commentButton.addTarget(self, action: #selector(commentButtonAction), forControlEvents: .TouchUpInside)
        return commentButton
    }()

    
    
}


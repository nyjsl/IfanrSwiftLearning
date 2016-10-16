//
//  DetailController.swift
//  IFanSwiftLearning
//
//  Created by 魏星 on 16/10/15.
//  Copyright © 2016年 wx. All rights reserved.
//

import UIKit
import WebKit
import SnapKit

class DetailController: UIViewController {
   
    var shareView: ShareView? //confirm to protocol
    var shadowView: UIView?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.addSubview(wkWebView)
        self.view.addSubview(toolBar)
        self.view.addSubview(headerBack)
        self.setupLayout()
    }
    
    private func setupLayout(){
        self.wkWebView.snp_makeConstraints { (make) in
            make.left.right.top.bottom.equalTo(self.view)
        }
        self.toolBar.snp_makeConstraints { (make) in
            make.left.right.bottom.equalTo(self.view)
            make.height.equalTo(50)
        }
        self.headerBack.snp_makeConstraints { (make) in
            make.left.right.equalTo(self.view)
            self.headerTopConstranit = make.top.equalTo(self.view).constraint
            make.height.equalTo(50)
        }
    }
    
    override func prefersStatusBarHidden() -> Bool {
        return true
    }
    
    convenience init(model: CommonModel,navTitle: String){
        self.init()
        self.model = model
        self.navTitle = navTitle
        headerBack.title = navTitle
    }
    
    private lazy var wkWebView: WKWebView = {
       let webView = WKWebView()
        return webView
    }()
    
    private var model: CommonModel?
    private var navTitle: String!
    
    //底部工具栏
    private lazy var toolBar: BottomToolsBar = {
        let toolBar: BottomToolsBar = BottomToolsBar()
        toolBar.delegate = self
        return toolBar
    }()
    //顶部返回栏
    
    private lazy var headerBack: HeaderBackView = {
        let headerBack: HeaderBackView = HeaderBackView(title: "")
        headerBack.delegate = self
        return headerBack
        
    }()
    
    
    private var lastPosition: CGFloat = 0
    
    private var headerTopConstranit: Constraint? = nil

}

extension DetailController: ShareViewDelegate,ShareReusable{
    

    
    func wxShareBtnDidClick() {
        shareToFriend((self.model?.excerpt)!, shareImageUrl: (model?.image)!, shareUrl: (model?.link)!, shareTitle: (model?.title)!)
    }
    
    func wxCircleShareBtnDidClick() {
        shareToFriendsCircle((model?.excerpt)!, shareTitle: (model?.title)!, shareUrl: (model?.link)!, shareImageUrl: (model?.image)!)
    }
    
    func shareMoreBtnDidClick() {
        hideShareView()
    }
    
    
}

extension DetailController: HeaderViewDelegate{
    func backButtonDidClick() {
        self.navigationController?.popViewControllerAnimated(true)
    }
}


extension DetailController: ToolBarDelegate{
    
    func commentButtonDidClick() {
        debugPrint("eidtCommon")
    }
    
    func praiseButtonDidClick() {
        self.toolBar.praizeButton.selected = !self.toolBar.praizeButton.selected
    }
    
    func shareButtonDidClick() {
        self.showShareView()
    }
    
    func editCommentDidClick() {
        //TODO
    }
    
    
}


extension DetailController: WKNavigationDelegate,UIScrollViewDelegate{
    
    
    func webView(webView: WKWebView, didStartProvisionalNavigation navigation: WKNavigation!) {
        self.showProgress()
    }
    
    func webView(webView: WKWebView, didFinishNavigation navigation: WKNavigation!) {
        self.hideProgress()
    }
    
    func scrollViewDidScroll(scrollView: UIScrollView) {
        let currentPositon = scrollView.contentOffset.y
        if currentPositon - self.lastPosition > 30  && currentPositon>0{
            self.headerTopConstranit?.updateOffset(50)
            UIView.animateWithDuration(0.3, animations: {
                self.headerBack.layoutIfNeeded()
            })
            self.lastPosition = currentPositon
        }else if self.lastPosition - currentPositon > 10{
            self.headerTopConstranit?.updateOffset(0)
            UIView.animateWithDuration(0.3, animations: {
                self.headerBack.layoutIfNeeded()
            })
            self.lastPosition = currentPositon
        }
        
    }
}

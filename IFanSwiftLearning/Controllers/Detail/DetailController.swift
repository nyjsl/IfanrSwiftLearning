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
        //TODO
    }
    
    func praiseButtonDidClick() {
        //TODO
    }
    
    func shareButtonDidClick() {
        //TODO
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
        }
    }
}

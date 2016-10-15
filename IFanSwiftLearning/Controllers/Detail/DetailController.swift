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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    private lazy var wkWebView: WKWebView = {
       let webView = WKWebView()
        return webView
    }()
    
    //底部工具栏
    private lazy var toolBar: BottomToolsBar = {
        let toolBar: BottomToolsBar = BottomToolsBar()
        toolBar.delegate = self
        return toolBar
    }()
    //顶部返回栏
    
//    private lazy var headerBack: 
    
    
    private var lastPosition: CGFloat = 0
    
    private var headerTopConstranit: Constraint? = nil

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

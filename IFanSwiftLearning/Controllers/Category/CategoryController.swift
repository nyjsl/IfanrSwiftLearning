//
//  CategoryController.swift
//  IFanSwiftLearning
//
//  Created by 魏星 on 16/10/10.
//  Copyright © 2016年 wx. All rights reserved.
//

import UIKit

class CategoryController: UIViewController {
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.whiteColor()
    }
    
    convenience init(categoryModel: CategoryModel){
        self.init()
        
       
    }
    
    private lazy var headerView: CategoryListHeaderView = {
        let view = CategoryListHeaderView(frame: CGRect(x: 0, y: 0, width: self.view.width, height: 200*UIConstant.SCREEN_WIDTH / UIConstant.IPHONE5_HEIGHT))
        return view
    }()
    
    
    private lazy var tableView: UITableView = {
        let tableView = UITableView(frame: self.view.bounds)
        tableView.backgroundColor = UIColor.whiteColor()
        tableView.separatorStyle = .None
        tableView.sectionFooterHeight = 50
        var inset = tableView.contentInset
        // 50是tag图片高度
        inset.top = self.headerView.height+self.cellHeaderViewHeight
        tableView.contentInset = inset
        tableView.delegate = self
        tableView.dataSource = self
        return tableView
    }()
    
     private var cellHeaderViewHeight: CGFloat = 70.0
}


extension CategoryController: UITableViewDelegate,UITableViewDataSource{
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
    }
    
    func tableView(tableView: UITableView, willDisplayCell cell: UITableViewCell, forRowAtIndexPath indexPath: NSIndexPath) {
        code
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        <#code#>
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        <#code#>
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        code
    }
}

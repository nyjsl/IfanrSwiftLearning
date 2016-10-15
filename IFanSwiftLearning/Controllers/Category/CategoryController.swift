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
    
    private var latestCellLayout = Array<HomePopbarLayout>()
}


extension CategoryController: UITableViewDelegate,UITableViewDataSource{
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return latestCellLayout.count
    }
    
    func tableView(tableView: UITableView, willDisplayCell cell: UITableViewCell, forRowAtIndexPath indexPath: NSIndexPath) {
        let cellModel = latestCellLayout[indexPath.row].model
        if cellModel.post_type == PostType.dasheng{
            let cell = cell as! HomeLatestTextCell
            cell.homePopbarLayout = latestCellLayout[indexPath.row]
        }else if cellModel.post_type == PostType.data{
            let cell = cell as! HomeLatestDateCell
            cell.popularLayout = latestCellLayout[indexPath.row]
        }else{
            let cell = cell as! HomeLatestImageCell
            cell.popularLayout = latestCellLayout[indexPath.row]
        }
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        var cell: UITableViewCell!
        
        let cellModel = latestCellLayout[indexPath.row].model
        if cellModel.post_type == PostType.dasheng{
             cell = HomeLatestTextCell.cellWithTableView(tableView)
        }else if cellModel.post_type == PostType.data{
             cell = HomeLatestDateCell.cellWithTableView(tableView)
        }else{
             cell = HomeLatestImageCell.cellWithTableView(tableView)
        }
        return cell
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return latestCellLayout[indexPath.row].cellHeight
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        let model = latestCellLayout[indexPath.row].model
        self.navigationController?.pushViewController(UIViewController, animated: true)
    }
}

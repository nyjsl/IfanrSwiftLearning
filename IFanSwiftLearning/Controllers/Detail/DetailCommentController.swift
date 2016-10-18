//
//  DetailCommentController.swift
//  IFanSwiftLearning
//
//  Created by 魏星 on 2016/10/17.
//  Copyright © 2016年 wx. All rights reserved.
//

import Foundation
import UIKit
import SnapKit

class DetailCommentController: UIViewController{
    
    var id: String!
    
    private var detailsCommentModelArray: Array<CommentModel> = Array()
    
    convenience init(id: String!){
        self.init()
        self.id = id
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.addSubview(headerView)
        self.view.addSubview(tableView)
        self.setupLayout()
        getData()
    }
    
    private func getData(){
        
        let type: CommentModel? = CommentModel(dict: [:])
        IFanService.shareInstance.getData(APIConstant.Comments_latest(self.id), t: type, keys: ["data", "all"], successHandle: { (modelArray) in
            modelArray.forEach({ (model) in
                self.detailsCommentModelArray.append(model)
            })
            self.tableView.reloadData()
            }) { (error) in
                print(error)
        }
    }
    
    private func setupLayout(){
        self.headerView.snp_makeConstraints { (make) in
            make.left.top.right.equalTo(self.view)
            make.height.equalTo(84)
        }
        self.tableView.snp_makeConstraints { (make) in
            make.left.bottom.right.equalTo(self.view)
            make.top.equalTo(self.headerView.snp_bottom)
        }
    }
    
    private lazy var headerView: CommentHeaderView = {
        
        let headerView = CommentHeaderView(model: nil)
        headerView.delegate = self
        return headerView
    }()
    
    private lazy var tableView: UITableView = {
        let tableView: UITableView = UITableView(frame:self.view.frame)
        tableView.dataSource = self
        tableView.delegate = self
        tableView.tableFooterView = UIView()
        tableView.backgroundColor = UIColor(red: 250/255.0, green: 247/255.0, blue: 250/255.0, alpha: 1.0)
        return tableView
    }()
}

extension DetailCommentController:CommentHeaderDelegate{
    
    func resetBtnSelectState(){
        for item: AnyObject in self.headerView.bottomView.subviews{
            if item is UIButton{
                let itemBtn: UIButton = item as! UIButton
                itemBtn.selected = false
            }
        }
    }
    
    func gobackBtnDidClick() {
        self.navigationController?.popViewControllerAnimated(true)
    }
    
    func timeSortedBtnDidClick(sender: UIButton) {
        if !sender.selected{
            resetBtnSelectState()
            self.detailsCommentModelArray.sortInPlace({ (first, second) -> Bool in
                return NSDate.isEarlier(first.comment_date, dateSecond: second.comment_date)
            })
            self.tableView.reloadData()
            sender.selected = true
        }
    }
    
    func heatSortedBtnDidClick(sender: UIButton) {
        if !sender.selected {
            resetBtnSelectState()
            
            self.detailsCommentModelArray.sortInPlace({ (model1, model2) -> Bool in
                Int(model1.comment_rating_up) > Int(model2.comment_rating_up)
            })
            self.tableView.reloadData()
            
            sender.selected = true
        }

    }
}

extension DetailCommentController: UITableViewDelegate,UITableViewDataSource{
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.detailsCommentModelArray.count
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        //
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        var model = self.detailsCommentModelArray[indexPath.row]
        let cell = CommentTableViewCell.cellWithTableView(tableView)
        if model.comment_parent == "0"{//不是子评论
            cell.layoutMargins = UIEdgeInsetsMake(0, 15, 0, 0)
            model.isBig = true
        }else{//子评论
            cell.layoutMargins =  UIEdgeInsetsMake(0, 45, 0, 0)
            model.isBig = false
        }
        cell.model = model
        return cell
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        
        let model: CommentModel = self.detailsCommentModelArray[indexPath.row]
        
        if model.comment_parent == "0" {
            return CommentTableViewCell.estimateCellHeigth(model.comment_content,
                                                           font: UIFont.systemFontOfSize(13),
                                                           size: CGSizeMake(UIConstant.SCREEN_WIDTH-30, 2000))
        } else {
            return CommentTableViewCell.estimateCellHeigth(model.comment_content,
                                                                font: UIFont.systemFontOfSize(13),
                                                                size: CGSizeMake(UIConstant.SCREEN_WIDTH-60, 2000))
        }

    }
    
}

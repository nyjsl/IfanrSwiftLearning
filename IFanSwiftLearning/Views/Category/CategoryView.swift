//
//  CategoryView.swift
//  IFanSwiftLearning
//
//  Created by 魏星 on 16/10/9.
//  Copyright © 2016年 wx. All rights reserved.
//

import Foundation

import UIKit




class CategoryView: UIView{
    
    typealias CoverBtnClickCallback = ()->Void
    
    typealias ItemDidClickCallback = (collectionView: UICollectionView,indexPath: NSIndexPath)->Void

    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(titleLabel)
        addSubview(collectionView)
        addSubview(coverButton)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.customFont_FZLTXIHJW(fontSize: 10)
        label.origin = CGPointZero
        label.size = CGSize(width: self.width, height: 20)
        label.text = "更多栏目"
        label.textColor = UIColor.whiteColor()
        label.textAlignment = .Center
        return label
    
    }()
    
    @objc private func coverBtnDidClick(){
        if let callBack = coverBtnClickCallback{
            callBack()
        }
    }
    
    private var coverBtnClickCallback: CoverBtnClickCallback?
    private var itemDidClickCallback: ItemDidClickCallback?
    
    private lazy var collectionView: UICollectionView = {
        
        let collectionViewLayout = UICollectionViewFlowLayout()
        collectionViewLayout.headerReferenceSize = CGSize(width: self.width, height: 70)
        collectionViewLayout.scrollDirection = .Vertical
        collectionViewLayout.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 10)
        let itemWidth = (UIConstant.SCREEN_WIDTH-4*UIConstant.UI_MARGIN_10)/3
        let itemHeight = itemWidth*81/100
        collectionViewLayout.itemSize = CGSize(width: itemWidth, height: itemHeight)
        var collectionView = UICollectionView(frame: CGRect(x: 0, y: UIConstant.UI_MARGIN_20, width: self.width, height: self.height*0.8), collectionViewLayout: collectionViewLayout)
        collectionView.bounces = true
        collectionView.backgroundColor = UIColor.whiteColor()
        collectionView.registerClass(CategrotyViewCell.self)
        collectionView.registerClass(CategoryHeaderView.self, forSupplementaryViewOfKind: UICollectionElementKindSectionHeader)
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.showsVerticalScrollIndicator = false
        return collectionView
    }()
    
    private lazy var coverButton: UIButton = {
        let coverButton = UIButton()
        coverButton.origin = CGPoint(x: 0, y: self.collectionView.frame.maxY)
        coverButton.size = CGSize(width: self.width, height: self.height-self.collectionView.frame.maxY)
        coverButton.backgroundColor = UIColor.blackColor().colorWithAlphaComponent(0.4)
        coverButton.addTarget(self, action: #selector(CategoryView.coverBtnDidClick), forControlEvents: .TouchDown)
        return coverButton
    }()
    
}

extension CategoryView{
    
    func coverBtnClick(callBack: CoverBtnClickCallback){
        self.coverBtnClickCallback = callBack
    }
    
    func itemBtnDidClick(callBack: ItemDidClickCallback){
        self.itemDidClickCallback  = callBack
    }
}

extension CategoryView: UICollectionViewDataSource,UICollectionViewDelegate{
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return categoryModelArray.count
    }
    
    func collectionView(collectionView: UICollectionView, willDisplayCell cell: UICollectionViewCell, forItemAtIndexPath indexPath: NSIndexPath) {
        let cell = cell as! CategrotyViewCell
        cell.model = categoryModelArray[indexPath.row]
    }
    
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeReuseableCell(indexPath) as CategrotyViewCell
        return cell
    }
    
    func collectionView(collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, atIndexPath indexPath: NSIndexPath) -> UICollectionReusableView {
        indexPath
        
        let headerView = collectionView.dequeReuseable(UICollectionElementKindSectionHeader, forIndexPath: indexPath) as CategoryHeaderView
        return headerView
    }
    
    func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        if let callBack = itemDidClickCallback {
            callBack(collectionView: collectionView, indexPath:  indexPath)
        }
    }
    
}


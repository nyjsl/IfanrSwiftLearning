//
//  CategoryListHeaderView.swift
//  IFanSwiftLearning
//
//  Created by 魏星 on 16/10/11.
//  Copyright © 2016年 wx. All rights reserved.
//

import UIKit

class CategoryListHeaderView: UIView {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(backgroundImage)
        addSubview(coverView)
        addSubview(titleLabel)
        addSubview(subTitleLabel)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    var model: CategoryModel!{
        didSet{
            backgroundImage.image = model.backgroudImage
            titleLabel.text = model.title
            coverView.backgroundColor = model.coverColor
            subTitleLabel.text = model.subTitle
        }
    }
    
    var labelAlpha: CGFloat = 1{
        didSet {
            self.titleLabel.alpha = labelAlpha
            self.subTitleLabel.alpha = labelAlpha
        }
    }
    
    private lazy var backgroundImage: UIImageView = {
        let image = UIImageView()
        image.origin = CGPointZero
        image.size = self.size
        image.clipsToBounds = true
        image.contentMode = .ScaleAspectFit
        return image
    }()
    
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.origin = CGPoint(x: UIConstant.UI_MARGIN_20, y: self.center.y)
        label.size = CGSize(width: self.width-2*UIConstant.UI_MARGIN_20, height: 20)
        label.textColor = UIColor.whiteColor()
        label.font = UIFont.customFont_FZLTZCHJW(fontSize: 20)
        return label
            
    }()
    
    private lazy var coverView: UIView = {
       let cover = UIView()
        cover.origin = CGPointZero
        cover.size = self.size
        return cover
    }()
    
    private lazy var subTitleLabel: UILabel = {
        var subTitleLabel = UILabel()
        subTitleLabel.origin = CGPoint(x: self.titleLabel.x, y: self.titleLabel.frame.maxY+UIConstant.UI_MARGIN_10)
        subTitleLabel.size = self.titleLabel.size
        subTitleLabel.textColor = UIColor.whiteColor()
        subTitleLabel.font = UIFont.customFont_FZLTXIHJW(fontSize: 12)
        return subTitleLabel
    }()

}

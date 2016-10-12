//
//  APIConstant.swift
//  IFanSwiftLearning
//
//  Created by 魏星 on 16/10/9.
//  Copyright © 2016年 wx. All rights reserved.
//

import Foundation
import UIKit
import Moya

public enum APIConstant{
    
    /**
     *  首页-热门（5条导航）参数 page, posts_per_page
     *
     *  @param Int    page请求的页数
     *
     */
    case Home_hot_features(Int)
    
    /**
     *  首页-列表 每次请求12条
     *
     *  @param Int 参数page 分页数从1开始
     *
     */
    case Home_latest(Int)
    
    /**
     *  快讯-列表
     *
     *  @param Int 分页数
     */
    case NewsFlash_latest(Int)
    
    /**
     *  玩物志
     *
     *  @param Int 分页数
     */
    case PlayingZhi_latest(Int)
    
    /**
     *  AppSo
     *
     */
    case AppSo_latest(Int)
    
    /**
     *  MainStore  从0开始
     */
    case MindStore_latest(Int)
    
    /**
     *  MindStore详情页的头像  id
     */
    case MindStore_Detail_Vote(String)
    
    /**
     *  MindStore详情页的评论  id offset
     */
    case MindStore_Detail_Comments(String, Int)
    
    /**
     *  分类
     */
    case Category(CategoryName,Int)
    
    /**
     *  获得评论
     */
    case Comments_latest(String)
}


/**
 分类类型
 
 - Video:      视频
 - ISeed:      ISeed
 - DaSheng:    大声
 - Shudu:      数读
 - Evaluation: 评测
 - Product:    参评
 - Car:        汽车
 - Business:   商业
 - Interview:  访谈
 - Picture:    图记
 - List:       清单
 */
public enum CategoryName {
    case Video
    case ISeed
    case DaSheng
    case Shudu
    case Evaluation
    case Product
    case Car
    case Business
    case Interview
    case Picture
    case List
    
    /**
     获取分类名字
     */
    func getName() -> String {
        switch self {
        case .Video:
            return "video-special"
        case .ISeed:
            return "iseed"
        case .DaSheng:
            return "dasheng"
        case .Shudu:
            return "data"
        case .Evaluation:
            return "review"
        case .Product:
            return "product"
        case .Car:
            return "intelligentcar"
        case .Business:
            return "business"
        case .Interview:
            return "interview"
        case .Picture:
            return "tuji"
        case .List:
            return "%E6%B8%85%E5%8D%95".stringByRemovingPercentEncoding!
        }
    }
}





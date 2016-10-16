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


extension APIConstant: TargetType{
    
    
    private var appKey: String{
        return "sg5673g77yk72455af4sd55ea"
    }
    
    private var excerpt_length: Int{
        return 80
    }
    
    private var sign: String{
        return "be072a0fc0b7020836bae8777f2fbeca"
    }
    
    private var timeStamp: String{
        return NSDate.getCurrentTimeStamp()
    }
    
    
    private var post_type: String{
        switch self {
        case .Home_hot_features(_),.Home_latest(_):
            return "post%2Cnews%2Cdasheng%2Cdata".stringByRemovingPercentEncoding!
        case .NewsFlash_latest(_):
            return "buzz"
        case .PlayingZhi_latest(_):
            return "coolbuy"
        case .AppSo_latest(_):
            return "app"
        case let .Category(type, _):
            return type.getName()
        default:
            return ""
        }
    }
    
    private var action: String{
        switch self {
        case .Home_hot_features(_):
            return "hot_featurs"
        case .Comments_latest(_):
            return "ifr_m_get_mobile_comments"
        default:
          return "ifr_m_latest"
        }
    }
    
    private var posts_per_page: Int {
        switch self {
        case .Home_hot_features(_):
            return 5
        default:
            return 12
        }
    }

    
    
    public var baseURL: NSURL {
        switch self {
        case .MindStore_latest(_),.MindStore_Detail_Vote(_),.MindStore_Detail_Comments(_, _):
            return NSURL(string: "https://sso.ifanr.com/api/v1.2/mind/")!
        default:
             return NSURL(string: "https://www.ifanr.com/api/v3.0/")!
        }
    }
    public var path: String {
        switch self {
        case let .MindStore_Detail_Vote(id):
            return "vote/\(id)"
        case .MindStore_Detail_Comments(_, _):
            return "comment/"
        default:
            return ""
        }
    }
    public var method: Moya.Method {
        return .GET
    }
    public var parameters: [String: AnyObject]? {
        switch self {
        //首页热门
        case let .Home_hot_features(page):
            return getParameters(page)
        //首页列表
        case let .Home_latest(page):
            return getParameters(page)
        //快讯列表
        case let .NewsFlash_latest(page):
            return getParameters(page)
        //玩物志列表
        case let .PlayingZhi_latest(page):
            return getParameters(page)
        case let .AppSo_latest(page):
            return getParameters(page)
        case let .MindStore_latest(page):
            return ["look_back_days":page,"limit":60]
        case let .Comments_latest(id):
            return ["action":action, "appKey": appKey, "post_id":id ,"sign": sign, "timestamp": timeStamp]
        case let .Category(type, page):
            if type == CategoryName.DaSheng || type == CategoryName.Shudu || type == CategoryName.Picture{
                return getParameters(page)
            }else{
                return getParamatersIncludeCategotyType(page, type: type.getName())
            }
        case let .MindStore_Detail_Comments(id, offset):
            return ["mind": id, "limit": 12, "offset": offset]
        default:
            return nil
        }
    }
    
    private func getParameters(page: Int) -> [String:AnyObject]?{
        return ["action":action,"appkey":appKey,"excerpt_length":excerpt_length,"sign":sign,"timestamp":timeStamp,
            "page":page,"posts_per_page":posts_per_page,"post_type":post_type]
    }
    
    private func getParamatersIncludeCategotyType(page: Int,type: String) -> [String:AnyObject]?{
        if var dict = getParameters(page){
            dict["category_name"] = type
            return dict
        }
        return nil
    }
    
    public var sampleData: NSData {
        return "{}".dataUsingEncoding(NSUTF8StringEncoding)!
    }
    
    public var multipartBody: [MultipartFormData]? {
        return nil
    }
}





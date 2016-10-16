//
//  IFanService.swift
//  IFanSwiftLearning
//
//  Created by 魏星 on 2016/10/16.
//  Copyright © 2016年 wx. All rights reserved.
//

import Foundation
import UIKit
import Moya

class IFanService{
    
    static let shareInstance = IFanService()
    
    lazy var ifanProvider = MoyaProvider<APIConstant>()
    
    private init(){}
    
    
    /*
     获取首页列表数据
    */
        func getLatestLayout(target: APIConstant,successHandle: (Array<HomePopbarLayout> -> Void)?,errorHandle:((Error) -> Void)?){
        
        ifanProvider.request(target) { (result) in
            switch result{
            case let .Success(response):
                do {
                    let json = try response.mapJSON() as? Dictionary<String,AnyObject>
                    if let json = json{
                        if let content = json["data"] as? Array<AnyObject>{
                            dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), { 
                                let layoutArray = content.map({ (dict) -> HomePopbarLayout in
                                    return HomePopbarLayout(model: CommonModel(dict: dict as! NSDictionary))
                                })
                                
                                dispatch_async(dispatch_get_main_queue(), { 
                                    if let success = successHandle{
                                        success(layoutArray)
                                    }
                                })
                            })
                        }
                    }
                    
                }catch{
                   print("出现异常")
                }
            case let .Failure(error):
                if let handle = errorHandle{
                    handle(error)
                }
            }
        }
    }
    
    
    
    func getData<T:Initable>(target: APIConstant,t: T?,keys:Array<String>,successHandle: (Array<T> -> Void)? ,errorHandle: ((Error) -> Void)?){
        
        ifanProvider.request(target) { (result) in
            switch result{
            case let .Success(response):
                do{
                    let json = try response.mapJSON() as? Dictionary<String,AnyObject>
                    if let json = json{
                        if keys.count == 1{ //获取data数组
                            if let content = json[keys[0]] as? Array<AnyObject>{
                                dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), { 
                                    let modelArray = content.map({ (dict) -> T in
                                        return T(dict: dict as!NSDictionary)
                                    })
                                    dispatch_async(dispatch_get_main_queue(), { 
                                        if let success = successHandle{
                                            success(modelArray)
                                        }
                                    })
                                })
                            }else{
                                print("没有数据")
                            }
                            
                        }else if keys.count == 2{
                            if let content = json[keys[0]] as? Dictionary<String,AnyObject>{
                                if let alls = content[keys[1]] as? Array<AnyObject>{
                                    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), { 
                                        let  allsArray = alls.map({ (dict) -> T in
                                            return T(dict: dict as! NSDictionary)
                                        })
                                        
                                        dispatch_async(dispatch_get_main_queue(), { 
                                            if let success = successHandle{
                                                success(allsArray)
                                            }
                                        })
                                    })
                                }
                            }else{
                                print("没有数据")
                            }
                        }
                    }else{
                        print("没有数据")
                    }
                }catch{
                    print("出现异常")
                }
                
            case let .Failure(error):
                if let handle = errorHandle{
                    handle(error)
                }
            }
        }
        
    }
    
}

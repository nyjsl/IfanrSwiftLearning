//
//  NSDateExt.swift
//  IFanSwiftLearning
//
//  Created by 魏星 on 16/10/12.
//  Copyright © 2016年 wx. All rights reserved.
//

import Foundation

extension NSDate{
    //获取今天日期
    class func today() -> String{
        let dateFormatter = NSDateFormatter()
        let date = NSDate()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        return dateFormatter.stringFromDate(date)
    }
    //判断是否是今天
    class func isToday(dateStr: String) -> Bool{
        return dateStr == today()
    }
    
    class func getTimeIntervalFromNow(dateStr: String) -> NSTimeInterval{
        
        guard dateStr.characters.count > 0 else{
            return 0
        }
        let dateFormatter = NSDateFormatter()
        dateFormatter.dateStyle = .ShortStyle
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        dateFormatter.timeZone = NSTimeZone(name: "Asia/Beijing")
        let date = dateFormatter.dateFromString(dateStr)
        return (date?.timeIntervalSinceNow)!
        
    }
    
    class func getCommonExpresionOfDate(dateStr: String) -> String{
        
        var resultStr = ""
        
        let timeIntervalHour = (-1*getTimeIntervalFromNow(dateStr))/60/60
        if timeIntervalHour<1{
            resultStr = "\(timeIntervalHour*60)分钟前"
        }else if timeIntervalHour<24{
            resultStr = "\(Int(timeIntervalHour))小时前"
        }else if timeIntervalHour<48{
            resultStr = "昨天 \(getStrByRange(dateStr,start: 11,end: 17))"
        }else if timeIntervalHour<72{
            resultStr = "前天 \(getStrByRange(dateStr,start: 11,end: 17))"
        }else{
            if let array: Array = dateStr.componentsSeparatedByString(" "){
                if let monthDayArray: Array = array[0].componentsSeparatedByString("-"){
                    resultStr = monthDayArray[1]+"月"+monthDayArray[2]+"日"
                }
                resultStr += getStrByRange(array[1], start: 0, end: 5)
            }
            
        }
        return resultStr
        
    }
    
    class func getStrByRange(dateStr: String,start:Int,end:Int) ->String{
        guard dateStr.characters.count > end-1 else{
            return ""
        }
        let indexStart = dateStr.startIndex.advancedBy(start)
        let indexEnd = dateStr.startIndex.advancedBy(end)
        let indexRange = Range(indexStart..<indexEnd)
        return dateStr.substringWithRange(indexRange)
    }
    
    /**
     将yyyy-MM-dd HH:mm:ss装换成MM月dd日 HH:mm
     
     - parameter timeStamp: 时间戳
     */
    class func getDate(date: String) -> String{
        let lastFormatter = NSDateFormatter()
        lastFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        let lastDate = lastFormatter.dateFromString(date)
        
        let currFormatter = NSDateFormatter()
        currFormatter.dateFormat = "MM月dd日 HH:mm"
        return currFormatter.stringFromDate(lastDate!)
    }


    class func getCurrentTimeStamp() -> String{
        let timeStamp: String = "\(Int64(floor(NSDate().timeIntervalSince1970*1000)))"
        return timeStamp
    }
    
    class func isEarlier(dateFirst: String , dateSecond: String) -> Bool{
        let dateFormatter : NSDateFormatter = NSDateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        
        let date1 = dateFormatter.dateFromString(dateFirst)
        let date2 = dateFormatter.dateFromString(dateSecond)
        return date1?.compare(date2!) == NSComparisonResult.OrderedAscending
    }
    
    
}

//
//  Resuable.swift
//  IFanSwiftLearning
//
//  Created by 魏星 on 16/9/11.
//  Copyright © 2016年 wx. All rights reserved.
//

import UIKit

public protocol Reuseable: class{
    
    static var reuseIdentifier: String{get}
    
}
extension Reuseable{
    static var reuseIdentifier: String{
        return String(Self)
    }
}

/*
 Indentifier 参数为类名
*/
public extension UITableView{
    
    func dequeReuseableCell<T: Reuseable>() -> T?{
        return self.dequeueReusableCellWithIdentifier(T.reuseIdentifier) as! T?
    }
    
}


public extension UICollectionView{
    
    func dequeReuseableCell<T: Reuseable>(forIndexPath: NSIndexPath)-> T{
        return self.dequeueReusableCellWithReuseIdentifier(T.reuseIdentifier, forIndexPath: forIndexPath) as! T
    }
    
    func dequeReuseable<T: Reuseable>(elementKind: String,forIndexPath: NSIndexPath) -> T{
        return self.dequeueReusableSupplementaryViewOfKind(elementKind, withReuseIdentifier: T.reuseIdentifier, forIndexPath: forIndexPath) as! T
    }
    
    func registerClass<T: UICollectionViewCell where T: Reuseable>(_: T.Type){
        return self.registerClass(T.self, forCellWithReuseIdentifier: T.reuseIdentifier)
    }
    
    func registerClass<T: UICollectionReusableView where T: Reuseable>(_: T.Type, forSupplementaryViewOfKind: String) {
        return self.registerClass(T.self, forSupplementaryViewOfKind: forSupplementaryViewOfKind, withReuseIdentifier: T.reuseIdentifier)
    }
}


//
//  MyNSArrayExtension.swift
//  SwiftExtension
//
//  Created by 东正 on 15/12/7.
//  Copyright © 2015年 东正. All rights reserved.
//

import Foundation
extension NSArray{
    
    ///除去重复
    func removeRepeat()->NSArray{
        
        let newSet = NSMutableSet(array: self as [AnyObject])
        return newSet.allObjects
        
    }
    
    /**
     在搜索里面删除重复
     
     - parameter dic: 需要插入
     
     - returns: 无重复数据
     */
    func removeRepeatForSearch(dic:NSDictionary)->NSMutableArray{
        let returnArr = NSMutableArray(array: self)
        var content = false
        let RLName = dic["RLName"] as! String
        var indexs = -1
        for (var i = 0 ; i < self.count ; i++){
            let contentDic = self[i] as! NSDictionary
            if ((contentDic["RLName"] as! String) == RLName){
                content = true
                indexs = i
            }
        }
        if(content && indexs != -1){
            returnArr.removeObjectAtIndex(indexs)
        }
        returnArr.insertObject(dic, atIndex: 0)
        
        return returnArr
    }

    
    
}

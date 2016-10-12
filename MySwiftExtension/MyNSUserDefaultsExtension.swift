//
//  MyNSUserDefaultsExtension.swift
//  SwiftExtension
//
//  Created by 东正 on 15/12/22.
//  Copyright © 2015年 东正. All rights reserved.
//

import Foundation
import UIKit


extension NSUserDefaults{
    
    public func setColor(color: UIColor?, forKey key: String) {
        var colorData: NSData?
        if let color = color {
            colorData = NSKeyedArchiver.archivedDataWithRootObject(color)
        }
        setObject(colorData, forKey: key)
    }
    
    public func colorForKey(key: String) -> UIColor? {
        var color: UIColor?
        if let colorData = dataForKey(key) {
            color = NSKeyedUnarchiver.unarchiveObjectWithData(colorData) as? UIColor
        }
        return color
    }
}

public extension NSObject {
    
    /**
    在延迟后结束. 在 main_queue 调用.
    
    - parameter delay: 延迟的秒数
    */
    func delay(delay: Double, closure:()->()) {
        dispatch_after(
            dispatch_time(
                DISPATCH_TIME_NOW,
                Int64(delay * Double(NSEC_PER_SEC))
            ),
            dispatch_get_main_queue(), closure)
    }
    
    /**
     modle 转字典
     
     - returns: model转成的字典
     */
    func toNSDictionary()->NSMutableDictionary{
        let dic = NSMutableDictionary()
        var count:UInt32 = 0
        let ivar = class_copyIvarList(self.classForCoder, &count)
        for index in 0 ... count - 1 {
            let ivarName = ivar_getName( ivar[ Int(index) ] )
            let valueIndex = self.valueForKey(String.fromCString(ivarName)!)
            guard let value = valueIndex else{ break }
            dic[String.fromCString(ivarName)!] = checkValueTypeByModelToNSDictionary(value)
        }
        
        return dic
    }
    
    /**
     检查Value的类型 并且把其转换成NS类型
     
     - parameter value: 需要检查转换的Value
     
     - returns: Value对应的NS类型数据
     */
    private func checkValueTypeByModelToNSDictionary(value:AnyObject) -> AnyObject{
        let valueString = NSStringFromClass(value.classForCoder)
        switch valueString.checkObjectType(){
        case .NSObjectType: return value
        case .UnNSObjectType: return value.toNSDictionary()
        case .NSListType: return listOrSetByModelToNSDictionary(value)
        default: return listOrSetByModelToNSDictionary((value as! NSSet).allObjects)
        }
        
    }
    
    /**
     转化数组内的数据
     
     - parameter listOrSet: 待转化的数组
     
     - returns: 转化之后的数组集合
     */
    private func listOrSetByModelToNSDictionary(listOrSet:AnyObject)->NSArray{
        let listArr = NSMutableArray()
        for(var i = 0 ; i < (listOrSet as! [AnyObject]).count ; i++){
            listArr.addObject(checkValueTypeByModelToNSDictionary((listOrSet as! [AnyObject])[i]))
        }
        
        return listArr
    }
    
    /**
     类名字
     
     - returns: 类名字
     */
    func className()->String{
        
        return NSStringFromClass(self.classForCoder)
    }
    
    
}



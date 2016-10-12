//
//  MyDictionaryExtension.swift
//  SwiftExtension
//
//  Created by 东正 on 15/12/7.
//  Copyright © 2015年 东正. All rights reserved.
//

import Foundation

//MARK:排序
public extension Dictionary where Value:Comparable {
    
    var valuesOrderedByAscending:[Value] {
        return self.values.sort()
    }
    
    var valuesOrderedbyDescending:[Value] {
        return self.values.sort().reverse()
    }
    
}

public extension Dictionary where Key:Comparable {
    
    /// 适用于 int
    var keysOrderedByAscending:[Key] {
        return self.keys.sort()
    }
    /// 适用于 int
    var keysOrderedByDescending:[Key] {
        return self.keys.sort().reverse()
    }
    
}

extension Dictionary {
    
    /**
    为了修改TODICT方法的返回值
    
    - parameter dict:
    
    - returns:
    */
    func Swift2reflect(dict:[String: Any])->String{
        var returnDictStr = "\(dict)"
        returnDictStr = returnDictStr.substringWithRange(NSMakeRange(1, returnDictStr.length - 2))
        returnDictStr = "{" + returnDictStr + "}"
        return returnDictStr
    }
    
    /**
    输入与本身的差异
    
    - parameter dictionaries: 要比较的字典
    - returns: 自身与输入字典的差异
    */
    func difference <V: Equatable> (dictionaries: [Key: V]...) -> [Key: V] {
        
        var result = [Key: V]()
        
        each {
            if let item = $1 as? V {
                result[$0] = item
            }
        }
        
        //  差异
        for dictionary in dictionaries {
            for (key, value) in dictionary {
                if result.has(key) && result[key] == value {
                    result.removeValueForKey(key)
                }
            }
        }
        
        return result
        
    }
    
    /**
    自己与输入字典的并集
    
    - parameter dictionaries: 加入字典
    - returns: 并集字典
    */
    func union (dictionaries: Dictionary...) -> Dictionary {
        
        var result = self
        
        dictionaries.each { (dictionary) -> Void in
            dictionary.each { (key, value) -> Void in
                _ = result.updateValue(value, forKey: key)
            }
        }
        
        return result
        
    }
    
    /**
    自身与输入字典的交集
    
    - parameter values: 输入字典
    - returns: 交集字典
    */
    func intersection <K, V where K: Equatable, V: Equatable> (dictionaries: [K: V]...) -> [K: V] {
        
        //  Casts self from [Key: Value] to [K: V]
        let filtered = mapFilter { (item, value) -> (K, V)? in
            if (item is K) && (value is V) {
                return (item as! K, value as! V)
            }
            
            return nil
        }
        
        //  Intersection
        return filtered.filter({ (key: K, value: V) -> Bool in
            //  check for [key: value] in all the dictionaries
            dictionaries.all { $0.has(key) && $0[key] == value }
        })
        
    }
    
    /**
    检查字典里面有没有这个key
    
    - parameter key: Key
    - returns: true or false
    */
    func has (key: Key) -> Bool {
        return indexForKey(key) != nil
    }
    
    /**
    转换成数组 V要写成需要的类型
    
    - parameter mapFunction:
    - returns: Mapped array
    */
    func toArray <V> (map: (Key, Value) -> V) -> [V] {
        
        var mapped = [V]()
        
        each {
            mapped.append(map($0, $1))
        }
        
        return mapped
        
    }
    
    /**
    检查返回值是否为true  如果返回值为true 那么就继续遍历 如果是false久停止
    
    - parameter test: 为每个元素调用函数
    - returns: 如果全为true 就遍历自身
    */
    func all (test: (Key, Value) -> (Bool)) -> Bool {
        
        for (key, value) in self {
            if !test(key, value) {
                return false
            }
        }
        
        return true
        
    }
    
    /**
    检查返回值是否为false  如果返回值为false 那么就继续遍历 如果是true久停止
    
    - parameter test: 为每个元素调用函数
    - returns: 如果全为false 就遍历自身
    */
    func any (test: (Key, Value) -> (Bool)) -> Bool {
        
        for (key, value) in self {
            if test(key, value) {
                return true
            }
        }
        
        return false
        
    }
    
    /**
    返回满足条件的元素的数目
    
    - parameter test: 为每个元素调用函数
    - returns: 数量
    */
    func countWhere (test: (Key, Value) -> (Bool)) -> Int {
        
        var result = 0
        
        for (key, value) in self {
            if test(key, value) {
                result++
            }
        }
        
        return result
    }

    
    /**
    过滤自我，只有列入白名单的键的值才能被展示
    
    - parameter keys: 白名单
    - returns: 过滤字典
    */
    func pick (keys: [Key]) -> Dictionary {
        return filter { (key: Key, _) -> Bool in
            return keys.contains(key)
        }
    }
    
    /**
    过滤自我，只有列入白名单的键的值才能被展示
    
    - parameter keys: 白名单
    - returns: 过滤字典
    */
    func pick (keys: Key...) -> Dictionary {
        return pick(unsafeBitCast(keys, [Key].self))
    }
    
    /**
    过滤自我，只有列入白名单的键的值才能被展示。
    
    - parameter keys: Keys
    - returns: 给定键的字典
    */
    func at (keys: Key...) -> Dictionary {
        return pick(keys)
    }
    
    /**
    删除一个键值对，并返回元组，如果为空了就返回nil
    - returns: (key, value) tuple
    */
    mutating func shift () -> (Key, Value)? {
        if let key = keys.first {
            return (key, removeValueForKey(key)!)
        }
        
        return nil
    }
    
    /**
    合并字典
    
    - returns: 将参数字典添加到本身中
    */
    mutating func merge<K, V>(dictionaries: Dictionary<K, V>...) {
        for dict in dictionaries {
            for (key, value) in dict {
                self.updateValue(value as! Value, forKey: key as! Key)
            }
        }
    }
    
    /**
    Creates a Dictionary with the same keys as self and values generated by running
    each [key: value] of self through the mapFunction.
    
    - parameter mapFunction:
    - returns: Mapped dictionary
    */
    func mapValues <V> (map: (Key, Value) -> V) -> [Key: V] {
        
        var mapped = [Key: V]()
        
        each {
            mapped[$0] = map($0, $1)
        }
        
        return mapped
        
    }
    
    /**
    Creates a Dictionary with the same keys as self and values generated by running
    each [key: value] of self through the mapFunction discarding nil return values.
    
    - parameter mapFunction:
    - returns: Mapped dictionary
    */
    func mapFilterValues <V> (map: (Key, Value) -> V?) -> [Key: V] {
        
        var mapped = [Key: V]()
        
        each {
            if let value = map($0, $1) {
                mapped[$0] = value
            }
        }
        
        return mapped
        
    }
    
    /**
    Creates a Dictionary with keys and values generated by running
    each [key: value] of self through the mapFunction discarding nil return values.
    
    - parameter mapFunction:
    - returns: Mapped dictionary
    */
    func mapFilter <K, V> (map: (Key, Value) -> (K, V)?) -> [K: V] {
        
        var mapped = [K: V]()
        
        each {
            if let value = map($0, $1) {
                mapped[value.0] = value.1
            }
        }
        
        return mapped
        
    }
    
    /**
    Creates a Dictionary with keys and values generated by running
    each [key: value] of self through the mapFunction.
    
    - parameter mapFunction:
    - returns: Mapped dictionary
    */
    func map <K, V> (map: (Key, Value) -> (K, V)) -> [K: V] {
        
        var mapped = [K: V]()
        
        self.each({
            let (_key, _value) = map($0, $1)
            mapped[_key] = _value
        })
        
        return mapped
        
    }
    
    /**
    Loops trough each [key: value] pair in self.
    
    - parameter eachFunction: Function to inovke on each loop
    */
    func each (each: (Key, Value) -> ()) {
        
        for (key, value) in self {
            each(key, value)
        }
        
    }
    
    /**
    Constructs a dictionary containing every [key: value] pair from self
    for which testFunction evaluates to true.
    
    - parameter testFunction: Function called to test each key, value
    - returns: Filtered dictionary
    */
    func filter (test: (Key, Value) -> Bool) -> Dictionary {
        
        var result = Dictionary()
        
        for (key, value) in self {
            if test(key, value) {
                result[key] = value
            }
        }
        
        return result
        
    }
    
    /**
    Creates a dictionary composed of keys generated from the results of
    running each element of self through groupingFunction. The corresponding
    value of each key is an array of the elements responsible for generating the key.
    
    - parameter groupingFunction:
    - returns: Grouped dictionary
    */
    func groupBy <T> (group: (Key, Value) -> T) -> [T: [Value]] {
        
        var result = [T: [Value]]()
        
        for (key, value) in self {
            
            let groupKey = group(key, value)
            
            // If element has already been added to dictionary, append to it. If not, create one.
            if result.has(groupKey) {
                result[groupKey]! += [value]
            } else {
                result[groupKey] = [value]
            }
            
        }
        
        return result
    }
    
    /**
    Similar to groupBy. Doesn't return a list of values, but the number of values for each group.
    
    - parameter groupingFunction: Function called to define the grouping key
    - returns: Grouped dictionary
    */
    func countBy <T> (group: (Key, Value) -> (T)) -> [T: Int] {
        
        var result = [T: Int]()
        
        for (key, value) in self {
            
            let groupKey = group(key, value)
            
            // If element has already been added to dictionary, append to it. If not, create one.
            if result.has(groupKey) {
                result[groupKey]!++
            } else {
                result[groupKey] = 1
            }
        }
        
        return result
    }
    
    /**
    Recombines the [key: value] couples in self trough combine using initial as initial value.
    
    - parameter initial: Initial value
    - parameter combine: Function that reduces the dictionary
    - returns: Resulting value
    */
    func reduce <U> (initial: U, combine: (U, Element) -> U) -> U {
        return self.reduce(initial, combine: combine)
    }

}

/**
Difference operator
*/
public func - <K, V: Equatable> (first: [K: V], second: [K: V]) -> [K: V] {
    return first.difference(second)
}

/**
Intersection operator
*/
public func & <K, V: Equatable> (first: [K: V], second: [K: V]) -> [K: V] {
    return first.intersection(second)
}

/**
Union operator
*/
public func | <K: Hashable, V> (first: [K: V], second: [K: V]) -> [K: V] {
    return first.union(second)
}

public extension Dictionary {
    
    /// 过滤字典，删除所有的键-值对，不匹配提供 block。
    /// - parameter block: 匹配 block
    mutating func performSelect( block: (Key,Value) -> Bool){
        var keysToRemove = [Key]()
        
        for (key,value) in self {
            if !block(key,value) {
                keysToRemove.append(key)
            }
        }
        
        for key in keysToRemove {
            self.removeValueForKey(key)
        }
    }
    
    /// 过滤词典，删除所有的键值对，匹配提供 block.
    mutating func performReject( block: (Key,Value) -> Bool){
        self.performSelect { (key, value) -> Bool in
            return !block(key,value)
        }
    }
    
    /// 查找键-值对，不匹配提供块
    /// - returns: Dictionary, 包含键值对，不匹配block
    func reject( block: (Key,Value) -> Bool) -> [Key:Value]
    {
        return self.select({ (key,value) -> Bool in
            return !block(key,value)
        })
    }
    
    /// 找到所有的键-值对，即匹配block
    /// - returns: Dictionary, 包含键值对，匹配block
    func select( block: (Element) -> Bool) -> [Key:Value]
    {
        var result: [Key:Value] = Dictionary()
        
        for (key,value) in self {
            if block(key,value)
            {
                result[key] = value
            }
        }
        return result
    }
}
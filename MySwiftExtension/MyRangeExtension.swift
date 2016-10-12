//
//  MyRangeExtension.swift
//  SwiftExtension
//
//  Created by 东正 on 15/12/16.
//  Copyright © 2015年 东正. All rights reserved.
//

import Foundation

public extension Range {
    
    /// For each index in the range invoke the callback by passing the item in range
    ///
    /// :param callback The callback function to invoke that take an element
    func eachWithIndex(callback: (Element) -> ()) {
        for index in self {
            callback(index)
        }
    }
    
    /// For each index in the range invoke the callback
    ///
    /// :param callback The callback function to invoke
    func each(callback: () -> ()) {
        self.eachWithIndex { (T) -> () in
            callback()
        }
    }
    
}

public func ==<T: ForwardIndexType>(left: Range<T>, right: Range<T>) -> Bool {
    return left.startIndex == right.startIndex && left.endIndex == right.endIndex
}
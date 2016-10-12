//
//  MyArrayExtension.swift
//  SwiftExtension
//
//  Created by 东正 on 15/12/7.
//  Copyright © 2015年 东正. All rights reserved.
//

import UIKit


public extension Array where Element: Equatable {
    
    func removeObject(object: Element) -> [Element] {
        return filter { $0 != object }
    }
    
    func removeObjectsInArray(objects : [Element]){
        for obj in objects{
            self.removeObject(obj)
        }
    }
    /**
    是否包含某元素
    
    - parameter obj: 要比较的元素 要是基本数据类型
    
    - returns: true 代表包含
    */
    func containsObj(obj : Element)-> Bool{
        return self.contains(obj) == true
    }
    
    func findObj (obj: Element) -> Bool {
        return (indexOf(obj) != nil) ? true : false
    }
    
    func contains<T where T : Equatable>(object: T) -> Bool {
        return self.filter({$0 as? T == object}).count > 0
    }
    
}

extension Array where Element : StringType{
    
    // ["test","123"] -> "test123"
    func combineAllStrInArr() -> String  {
        return String(self.map{$0.characters}.reduce(String.CharacterView(), combine: {$0 + $1}))
    }
}


//MARK:Github Extension

public extension Array {
    
    /// Filter array, deleting all objects, that do not match block
    ///
    /// - parameter block: matching block.
    mutating func ck_performSelect(block: (Element) -> Bool) {
        var indexes = [Int]()
        for (index,element) in self.enumerate() {
            if !block(element) { indexes.append(index)}
        }
        
        self.removeAtIndexes(indexes)
    }
    
    /// Filter array, deleting all objects, that match block
    ///
    /// - parameter block: matching block
    mutating func ck_performReject(block: (Element) -> Bool) {
        return self.ck_performSelect({ (element) -> Bool in
            return !block(element)
        })
    }
}

private extension Array
{
    mutating func removeAtIndexes( indexes: [Int]) {
        for index in indexes.sort(>) {
            self.removeAtIndex(index)
        }
    }
}


extension Array{
    
    
    mutating func addElements(new : Element){
        self.append(new)
    }
    
    mutating func removeLastObj() -> Element{
        return self.removeLast()
    }
    
    mutating func removeFirstObj() ->Element{
        return self.removeFirst()
    }
    
    mutating func flushArray(){
        // will give empty Arr
        return self.removeAll()
    }
    
    func joinArrayBySeperator(separator:String) -> String {
        return self.map({ String($0) }).joinWithSeparator(separator)
    }
    
    /// Creates an array of elements from the specified indexes, or keys, of the collection.
    /// Indexes may be specified as individual arguments or as arrays of indexes.
    ///
    /// :param array The array to source from
    /// :param indexes Get elements from these indexes
    /// :return New array with elements from the indexes specified.
    func at(indexes: Int...) -> [Element] {
        return $.at(self, indexes: indexes)
    }
    
    /// Cycles through the array n times passing each element into the callback function
    ///
    /// :param times Number of times to cycle through the array
    /// :param callback function to call with the element
    func cycle<U>(times: Int, callback: (Element) -> U) {
        $.cycle(self, times, callback: callback)
    }
    
    /// Cycles through the array indefinetly passing each element into the callback function
    ///
    /// :param callback function to call with the element
    func cycle<U>(callback: (Element) -> U) {
        $.cycle(self, callback: callback)
    }
    
    /// For each item in the array invoke the callback by passing the elem
    ///
    /// :param callback The callback function to invoke that take an element
    func eachWithIndex(callback: (Int, Element) -> ()) -> [Element] {
        for (index, elem) in self.enumerate() {
            callback(index, elem)
        }
        return self
    }
    
//    /// For each item in the array invoke the callback by passing the elem along with the index
//    ///
//    /// :param callback The callback function to invoke
//    func each(callback: (Element) -> ()) -> [Element] {
//        self.eachWithIndex { (index, elem) -> () in
//            callback(elem)
//        }
//        return self
//    }
    
    /// For each item in the array that meets the when conditon, invoke the callback by passing the elem
    ///
    /// :param callback The callback function to invoke
    /// :param when The condition to check each element against
    /// :return the array itself
    func each(when when: (Element) -> Bool, callback: (Element) -> ()) -> [Element] {
        return $.each(self, when: when, callback: callback);
    }
    
    /// Checks if the given callback returns true value for all items in the array.
    ///
    /// :param array The array to check.
    /// :param callback Check whether element value is true or false.
    /// :return First element from the array.
    func every(callback: (Element) -> Bool) -> Bool {
        return $.every(self, callback: callback)
    }
    
    /// Get element from an array at the given index which can be negative
    /// to find elements from the end of the array
    ///
    /// :param index Can be positive or negative to find from end of the array
    /// :param orElse Default value to use if index is out of bounds
    /// :return Element fetched from the array or the default value passed in orElse
    func fetch(index: Int, orElse: Element? = .None) -> Element! {
        return $.fetch(self, index, orElse: orElse)
    }
    
    /// This method is like find except that it returns the index of the first element
    /// that passes the callback check.
    ///
    /// :param array The array to search for the element in.
    /// :param callback Function used to figure out whether element is the same.
    /// :return First element's index from the array found using the callback.
    func findIndex(callback: (Element) -> Bool) -> Int? {
        return $.findIndex(self, callback: callback)
    }
    
    /// This method is like findIndex except that it iterates over elements of the array
    /// from right to left.
    ///
    /// :param array The array to search for the element in.
    /// :param callback Function used to figure out whether element is the same.
    /// :return Last element's index from the array found using the callback.
    func findLastIndex(callback: (Element) -> Bool) -> Int? {
        return $.findLastIndex(self, callback: callback)
    }
    
//    /// Gets the first element in the array.
//    ///
//    /// :param array The array to wrap.
//    /// :return First element from the array.
//    func first() -> Element? {
//        return $.first(self)
//    }
    
    /// Flattens the array
    ///
    /// :return Flatten array of elements
    func flatten() -> [Element] {
        return $.flatten(self)
    }
    
//    /// Get element at index
//    ///
//    /// :param index The index in the array
//    /// :return Element at that index
//    func get(index: Int) -> Element! {
//        return self.fetch(index)
//    }
    
    /// Gets all but the last element or last n elements of an array.
    ///
    /// :param array The array to source from.
    /// :param numElements The number of elements to ignore in the end.
    /// :return Array of initial values.
    func initial(numElements: Int? = 1) -> [Element] {
        return $.initial(self, numElements: numElements!)
    }
    
//    /// Gets the last element from the array.
//    ///
//    /// :param array The array to source from.
//    /// :return Last element from the array.
//    func last() -> Element? {
//        return $.last(self)
//    }
    
    /// The opposite of initial this method gets all but the first element or first n elements of an array.
    ///
    /// :param array The array to source from.
    /// :param numElements The number of elements to exclude from the beginning.
    /// :return The rest of the elements.
    func rest(numElements: Int? = 1) -> [Element] {
        return $.rest(self, numElements: numElements!)
    }
    
    /// Retrieves the minimum value in an array.
    ///
    /// :param array The array to source from.
    /// :return Minimum value from array.
    func min<T: Comparable>() -> T? {
        return $.min(map { $0 as! T })
    }
    
    /// Retrieves the maximum value in an array.
    ///
    /// :param array The array to source from.
    /// :return Maximum element in array.
    func max<T: Comparable>() -> T? {
        return $.max(map { $0 as! T })
    }
    
//    /// Gets the index at which the first occurrence of value is found.
//    ///
//    /// :param value Value whose index needs to be found.
//    /// :return Index of the element otherwise returns nil if not found.
//    func indexOf<T: Equatable>(value: T) -> Int? {
//        return $.indexOf(map { $0 as! T }, value: value)
//    }
    
    /// Remove element from array
    ///
    /// :param value Value that is to be removed from array
    /// :return Element at that index
    mutating func remove<T: Equatable>(value: T) -> T? {
        if let index = $.indexOf(map { $0 as! T }, value: value) {
            return (removeAtIndex(index) as? T)
        } else {
            return .None
        }
    }
    
//    /// Checks if a given value is present in the array.
//    ///
//    /// :param value The value to check.
//    /// :return Whether value is in the array.
//    func contains<T:Equatable>(value: T) -> Bool {
//        return $.contains(map { $0 as! T }, value: value)
//    }
    
    /// Return the result of repeatedly calling `combine` with an accumulated value initialized
    /// to `initial` on each element of `self`, in turn with a corresponding index.
    ///
    /// :param initial the value to be accumulated
    /// :param combine the combiner with the result, index, and current element
    /// :return combined result
    func reduceWithIndex<T>(initial: T, @noescape combine: (T, Int, Array.Generator.Element) throws -> T) rethrows -> T {
        var result = initial
        for (index, element) in self.enumerate() {
            result = try combine(result, index, element)
        }
        return result
    }


}

/// Overloaded operator to appends another array to an array
///
/// :return array with the element appended in the end
public func <<<T>(inout left: [T], right: [T]) -> [T] {
    left += right
    return left
}

/// Overloaded operator to append element to an array
///
/// :return array with the element appended in the end
public func <<<T>(inout array: [T], elem: T) -> [T] {
    array.append(elem)
    return array
}

/// Overloaded operator to remove elements from first array
///
/// :return array with the elements from second array removed
public func -<T: Hashable>(left: [T], right: [T]) -> [T] {
    return $.difference(left, right)
}




extension Array{
    private var indexesInterval: HalfOpenInterval<Int> { return HalfOpenInterval<Int>(0, self.count) }
    
    /**
    检查是否包含一个项目列表。
    
    - parameter items: 需要搜索的项目列表
    - returns: 如果包含返回成功
    */
    func contains <T: Equatable> (items: T...) -> Bool {
        return items.all { self.indexOf($0) >= 0 }
    }
    
    /**
    与输入数组的差异
    
    - parameter values: Arrays to subtract
    - returns: Difference of self and the input arrays
    */
    func difference <T: Equatable> (values: [T]...) -> [T] {
        
        var result = [T]()
        
        elements: for e in self {
            if let element = e as? T {
                for value in values {
                    //  if a value is in both self and one of the values arrays
                    //  jump to the next iteration of the outer loop
                    if value.contains(element) {
                        continue elements
                    }
                }
                
                //  element it's only in self
                result.append(element)
            }
        }
        
        return result
        
    }
    
    /**
    与输入数组的交集
    
    - parameter values: Arrays to intersect
    - returns: Array of unique values contained in all the dictionaries and self
    */
    func intersection <U: Equatable> (values: [U]...) -> Array {
        
        var result = self
        var intersection = Array()
        
        for (i, value) in values.enumerate() {
            
            //  the intersection is computed by intersecting a couple per loop:
            //  self n values[0], (self n values[0]) n values[1], ...
            if (i > 0) {
                result = intersection
                intersection = Array()
            }
            
            //  find common elements and save them in first set
            //  to intersect in the next loop
            value.each { (item: U) -> Void in
                if result.contains(item) {
                    intersection.append(item as! Element)
                }
            }
            
        }
        
        return intersection
        
    }
    
    /**
    与输入数组的并集.
    
    - parameter values: Arrays
    - returns: Union array of unique values
    */
    func union <U: Equatable> (values: [U]...) -> Array {
        
        var result = self
        
        for array in values {
            for value in array {
                if !result.contains(value) {
                    result.append(value as! Element)
                }
            }
        }
        
        return result
        
    }
    
    /**
    第一个元素
    
    - returns: First element of the array if not empty
    */
    @available(*, unavailable, message="use the 'first' property instead") func first () -> Element? {
        return first
    }
    
    /**
    最后一个元素
    
    - returns: Last element of the array if not empty
    */
    @available(*, unavailable, message="use the 'last' property instead") func last () -> Element? {
        return last
    }
    
    /**
    如果发现，返回第一次发生的item的索引值
    
    - parameter item: The item to search for
    - returns: Matched item or nil
    */
    func find <U: Equatable> (item: U) -> Element? {
        if let index = indexOf(item) {
            return self[index]
        }
        
        return nil
    }
    
    
    /**
        判定第一项符合条件
    
    - parameter condition: 如果一个元素满足给定的条件，返回一个布尔值的函数。
    
    - returns: First matched item or nil
    */
    func find (condition: Element -> Bool) -> Element? {
        return takeFirst(condition)
    }
    
    /**
        搜索item的位置
    
    - parameter item: The item to search for
    - returns: Index of the matched item or nil
    */
    func indexOf <U: Equatable> (item: U) -> Int? {
        if item is Element {
            return unsafeBitCast(self, [U].self).indexOf(item)
        }
        
        return nil
    }
    
    /**
        搜索item的位置
    
    - parameter condition: A function which returns a boolean if an element satisfies a given condition or not.
    - returns: Index of the first matched item or nil
    */
    func indexOf (condition: Element -> Bool) -> Int? {
        for (index, element) in self.enumerate() {
            if condition(element) {
                return index
            }
        }
        
        return nil
    }
    

    /**
        在指定的索引处获取对象，如果它存在。
    
    - parameter index:
    - returns: Object at index in self
    */
    func get (index: Int) -> Element? {
        
        return index >= 0 && index < count ? self[index] : nil
        
    }
    
    /**
    获取指定范围内的对象。
    
    - parameter range:
    - returns: Subarray in range
    */
    func get (range: Range<Int>) -> Array {
        
        return self[rangeAsArray: range]
        
    }
    
    
    /**
    Produces an array of arrays, each containing n elements, each offset by step.
    If the final partition is not n elements long it is dropped.
    
    - parameter n: The number of elements in each partition.
    - parameter step: The number of elements to progress between each partition.  Set to n if not supplied.
    - returns: Array partitioned into n element arrays, starting step elements apart.
    */
    func partition (var n: Int, var step: Int? = nil) -> [Array] {
        var result = [Array]()
        
        // If no step is supplied move n each step.
        if step == nil {
            step = n
        }
        
        if step < 1 { step = 1 } // Less than 1 results in an infinite loop.
        if n < 1    { n = 0 }    // Allow 0 if user wants [[],[],[]] for some reason.
        if n > count { return [[]] }
        
        for i in 0.stride(through: count - n, by: step!) {
            result += [self[i..<(i + n)]]
        }
        
        return result
    }
    
    /**
    Produces an array of arrays, each containing n elements, each offset by step.
    
    - parameter n: The number of elements in each partition.
    - parameter step: The number of elements to progress between each partition.  Set to n if not supplied.
    - parameter pad: An array of elements to pad the last partition if it is not long enough to
    contain n elements. If nil is passed or there are not enough pad elements
    the last partition may less than n elements long.
    - returns: Array partitioned into n element arrays, starting step elements apart.
    */
    func partition (var n: Int, var step: Int? = nil, pad: Array?) -> [Array] {
        var result = [Array]()
        
        // If no step is supplied move n each step.
        if step == nil {
            step = n
        }
        
        // Less than 1 results in an infinite loop.
        if step < 1 {
            step = 1
        }
        
        // Allow 0 if user wants [[],[],[]] for some reason.
        if n < 1 {
            n = 0
        }
        
        for i in 0.stride(to: count, by: step!) {
            var end = i + n
            
            if end > count {
                end = count
            }
            
            result += [self[i..<end]]
            
            if end != i + n {
                break
            }
        }
        
        if let padding = pad {
            let remaining = count % n
            result[result.count - 1] += padding[0..<remaining] as Array
        }
        
        return result
    }
    
    /**
    Produces an array of arrays, each containing n elements, each offset by step.
    
    - parameter n: The number of elements in each partition.
    - parameter step: The number of elements to progress between each partition. Set to n if not supplied.
    - returns: Array partitioned into n element arrays, starting step elements apart.
    */
    func partitionAll (var n: Int, var step: Int? = nil) -> [Array] {
        var result = [Array]()
        
        // If no step is supplied move n each step.
        if step == nil {
            step = n
        }
        
        if step < 1 { step = 1 } // Less than 1 results in an infinite loop.
        if n < 1    { n = 0 }    // Allow 0 if user wants [[],[],[]] for some reason.
        
        for i in 0.stride(to: count, by: step!) {
            result += [self[i..<(i + n)]]
        }
        
        return result
    }
    
    /**
    Applies cond to each element in array, splitting it each time cond returns a new value.
    
    - parameter cond: Function which takes an element and produces an equatable result.
    - returns: Array partitioned in order, splitting via results of cond.
    */
    func partitionBy <T: Equatable> (cond: (Element) -> T) -> [Array] {
        var result = [Array]()
        var lastValue: T? = nil
        
        for item in self {
            let value = cond(item)
            
            if value == lastValue {
                let index: Int = result.count - 1
                result[index] += [item]
            } else {
                result.append([item])
                lastValue = value
            }
        }
        
        return result
    }
    
   
    
    /**
    Max value in the current array (if Array.Element implements the Comparable protocol).
    
    - returns: Max value
    */
    func max <U: Comparable> () -> U {
        
        return map {
            return $0 as! U
            }.maxElement()!
        
    }
    
    /**
    Min value in the current array (if Array.Element implements the Comparable protocol).
    
    - returns: Min value
    */
    func min <U: Comparable> () -> U {
        
        return map {
            return $0 as! U
            }.minElement()!
        
    }
    
    /**
    The value for which call(value) is highest.
    
    - returns: Max value in terms of call(value)
    */
    func maxBy <U: Comparable> (call: (Element) -> (U)) -> Element? {
        
        if let firstValue = self.first {
            var maxElement: Element = firstValue
            var maxValue: U = call(firstValue)
            for i in 1..<self.count {
                let element: Element = self[i]
                let value: U = call(element)
                if value > maxValue {
                    maxElement = element
                    maxValue = value
                }
            }
            return maxElement
        } else {
            return nil
        }
        
    }
    
    /**
    The value for which call(value) is lowest.
    
    - returns: Min value in terms of call(value)
    */
    func minBy <U: Comparable> (call: (Element) -> (U)) -> Element? {
        
        if let firstValue = self.first {
            var minElement: Element = firstValue
            var minValue: U = call(firstValue)
            for i in 1..<self.count {
                let element: Element = self[i]
                let value: U = call(element)
                if value < minValue {
                    minElement = element
                    minValue = value
                }
            }
            return minElement
        } else {
            return nil
        }
        
    }
    
    /**
    Iterates on each element of the array.
    
    - parameter call: Function to call for each element
    */
    func each (call: (Element) -> ()) {
        
        for item in self {
            call(item)
        }
        
    }
    
    /**
    Iterates on each element of the array with its index.
    
    - parameter call: Function to call for each element
    */
    func each (call: (Int, Element) -> ()) {
        
        for (index, item) in self.enumerate() {
            call(index, item)
        }
        
    }
    
    /**
    Iterates on each element of the array from Right to Left.
    
    - parameter call: Function to call for each element
    */
    @available(*, unavailable, message="use 'reverse().each' instead") func eachRight (call: (Element) -> ()) {
        reverse().each(call)
    }
    
    /**
    Iterates on each element of the array, with its index, from Right to Left.
    
    - parameter call: Function to call for each element
    */
    @available(*, unavailable, message="use 'reverse().each' instead") func eachRight (call: (Int, Element) -> ()) {
        for (index, item) in reverse().enumerate() {
            call(count - index - 1, item)
        }
    }
    
    /**
    Checks if test returns true for any element of self.
    
    - parameter test: Function to call for each element
    - returns: true if test returns true for any element of self
    */
    func any (test: (Element) -> Bool) -> Bool {
        for item in self {
            if test(item) {
                return true
            }
        }
        
        return false
    }
    
    /**
    Checks if test returns true for all the elements in self
    
    - parameter test: Function to call for each element
    - returns: True if test returns true for all the elements in self
    */
    func all (test: (Element) -> Bool) -> Bool {
        for item in self {
            if !test(item) {
                return false
            }
        }
        
        return true
    }
    
    /**
    Opposite of filter.
    
    - parameter exclude: Function invoked to test elements for the exclusion from the array
    - returns: Filtered array
    */
    func reject (exclude: (Element -> Bool)) -> Array {
        return filter {
            return !exclude($0)
        }
    }
    
    /**
    Returns an array containing the first n elements of self.
    
    - parameter n: Number of elements to take
    - returns: First n elements
    */
    func take (n: Int) -> Array {
        return self[0..<Swift.max(0, n)]
    }
    
    /**
    Returns the elements of the array up until an element does not meet the condition.
    
    - parameter condition: A function which returns a boolean if an element satisfies a given condition or not.
    - returns: Elements of the array up until an element does not meet the condition
    */
    func takeWhile (condition: (Element) -> Bool) -> Array {
        
        var lastTrue = -1
        
        for (index, value) in self.enumerate() {
            if condition(value) {
                lastTrue = index
            } else {
                break
            }
        }
        
        return take(lastTrue + 1)
        
    }
    
    /**
    Returns the first element in the array to meet the condition.
    
    - parameter condition: A function which returns a boolean if an element satisfies a given condition or not.
    - returns: The first element in the array to meet the condition
    */
    func takeFirst (condition: (Element) -> Bool) -> Element? {
        
        for value in self {
            if condition(value) {
                return value
            }
        }
        
        return nil
        
    }
    
    /**
    Returns an array containing the the last n elements of self.
    
    - parameter n: Number of elements to take
    - returns: Last n elements
    */
    func last (n: Int) -> Array {
        
        return  self[(count - n)..<count]
        
    }
    
    /**
    跳过n个元素直到结尾
    
    - parameter n: Number of elements to skip
    - returns: Array from n to the end
    */
    func skip (n: Int) -> Array {
        
        return n > count ? [] : self[Int(n)..<count]
        
    }
    
    /**
    跳过n个元素直到结尾
    
    - parameter condition: A function which returns a boolean if an element satisfies a given condition or not
    - returns: Elements of the array starting with the element which does not meet the condition
    */
    func skipWhile (condition: (Element) -> Bool) -> Array {
        
        var lastTrue = -1
        
        for (index, value) in self.enumerate() {
            if condition(value) {
                lastTrue = index
            } else {
                break
            }
        }
        
        return skip(lastTrue + 1)
    }
    
    /**
    Costructs an array removing the duplicate values in self
    if Array.Element implements the Equatable protocol.
    
    - returns: Array of unique values
    */
    func unique <T: Equatable> () -> [T] {
        var result = [T]()
        
        for item in self {
            if !result.contains(item as! T) {
                result.append(item as! T)
            }
        }
        
        return result
    }
    
    /**
    Returns the set of elements for which call(element) is unique
    
    - parameter call: The closure to use to determine uniqueness
    - returns: The set of elements for which call(element) is unique
    */
    func uniqueBy <T: Equatable> (call: (Element) -> (T)) -> [Element] {
        var result: [Element] = []
        var uniqueItems: [T] = []
        
        for item in self {
            let callResult: T = call(item)
            if !uniqueItems.contains(callResult) {
                uniqueItems.append(callResult)
                result.append(item)
            }
        }
        
        return result
    }
    
    
    
       /**
    Recursive helper method where all of the permutation-generating work is done
    This is Heap's algorithm
    */
    private func permutationHelper(n: Int, inout array: [Element], inout endArray: [[Element]]) -> [[Element]] {
        if n == 1 {
            endArray += [array]
        }
        for var i = 0; i < n; i++ {
            permutationHelper(n - 1, array: &array, endArray: &endArray)
            let j = n % 2 == 0 ? i : 0;
            (array[j], array[n - 1]) = (array[n - 1], array[j])
            let temp: Element = array[j]
            array[j] = array[n - 1]
            array[n - 1] = temp
        }
        return endArray
    }
    
    /**
    创建一个字典
    
    - parameter groupingFunction:
    - returns: Grouped dictionary
    */
    func groupBy <U> (groupingFunction group: (Element) -> U) -> [U: Array] {
        
        var result = [U: Array]()
        
        for item in self {
            
            let groupKey = group(item)
            
            // If element has already been added to dictionary, append to it. If not, create one.
            if result.has(groupKey) {
                result[groupKey]! += [item]
            } else {
                result[groupKey] = [item]
            }
        }
        
        return result
    }
    
    /**
    Similar to groupBy, instead of returning a list of values,
    returns the number of values for each group.
    
    - parameter groupingFunction:
    - returns: Grouped dictionary
    */
    func countBy <U> (groupingFunction group: (Element) -> U) -> [U: Int] {
        
        var result = [U: Int]()
        
        for item in self {
            let groupKey = group(item)
            
            if result.has(groupKey) {
                result[groupKey]!++
            } else {
                result[groupKey] = 1
            }
        }
        
        return result
    }
    
    /**
    Returns all of the permutations of this array of a given length, allowing repeats
    
    - parameter length: The length of each permutations
    :returns All of the permutations of this array of a given length, allowing repeats
    */
    func repeatedPermutation(length: Int) -> [[Element]] {
        if length < 1 {
            return []
        }
        var permutationIndexes: [[Int]] = []
        permutationIndexes.repeatedPermutationHelper([], length: length, arrayLength: self.count, permutationIndexes: &permutationIndexes)
        return permutationIndexes.map({ $0.map({ i in self[i] }) })
    }
    
    private func repeatedPermutationHelper(seed: [Int], length: Int, arrayLength: Int, inout permutationIndexes: [[Int]]) {
        if seed.count == length {
            permutationIndexes.append(seed)
            return
        }
        for i in (0..<arrayLength) {
            var newSeed: [Int] = seed
            newSeed.append(i)
            self.repeatedPermutationHelper(newSeed, length: length, arrayLength: arrayLength, permutationIndexes: &permutationIndexes)
        }
    }
    
    /**
    Returns the number of elements which meet the condition
    
    - parameter test: Function to call for each element
    - returns: the number of elements meeting the condition
    */
    func countWhere (test: (Element) -> Bool) -> Int {
        
        var result = 0
        
        for item in self {
            if test(item) {
                result++
            }
        }
        
        return result
    }
    
    
    
    
    
    /**
    Creates an array with values generated by running each value of self
    through the mapFunction and discarding nil return values.
    
    - parameter mapFunction:
    - returns: Mapped array
    */
    func mapFilter <V> (mapFunction map: (Element) -> (V)?) -> [V] {
        
        var mapped = [V]()
        
        each { (value: Element) -> Void in
            if let mappedValue = map(value) {
                mapped.append(mappedValue)
            }
        }
        
        return mapped
        
    }
    
    /**
    Creates an array with values and an accumulated result by running accumulated result
    and each value of self through the mapFunction.
    
    - parameter initial: Initial value for accumulator
    - parameter mapFunction:
    - returns: Accumulated value and mapped array
    */
    func mapAccum <U, V> (initial: U, mapFunction map: (U, Element) -> (U, V)) -> (U, [V]) {
        var mapped = [V]()
        var acc = initial
        
        each { (value: Element) -> Void in
            let (mappedAcc, mappedValue) = map(acc, value)
            acc = mappedAcc
            mapped.append(mappedValue)
        }
        
        return (acc, mapped)
    }
    
    /**
    self.reduce with initial value self.first()
    */
    func reduce (combine: (Element, Element) -> Element) -> Element? {
        if let firstElement = first {
            return skip(1).reduce(firstElement, combine: combine)
        }
        
        return nil
    }
    
    /**
    self.reduce from right to left
    */
    @available(*, unavailable, message="use 'reverse().reduce' instead") func reduceRight <U> (initial: U, combine: (U, Element) -> U) -> U {
        return reverse().reduce(initial, combine: combine)
    }
    
    /**
    self.reduceRight with initial value self.last()
    */
    @available(*, unavailable, message="use 'reverse().reduce' instead") func reduceRight (combine: (Element, Element) -> Element) -> Element? {
        return reverse().reduce(combine)
    }
    
//    /**
//    Creates an array with the elements at the specified indexes.
//    
//    - parameter indexes: Indexes of the elements to get
//    - returns: Array with the elements at indexes
//    */
//    func at(indexes: Int...) -> Array {
//        return indexes.map { self.get($0)! }
//    }
    
    /**
    Converts the array to a dictionary with the keys supplied via the keySelector.
    
    - parameter keySelector:
    - returns: A dictionary
    */
    func toDictionary <U> (keySelector:(Element) -> U) -> [U: Element] {
        var result: [U: Element] = [:]
        for item in self {
            result[keySelector(item)] = item
        }
        
        return result
    }
    
    /**
    Converts the array to a dictionary with keys and values supplied via the transform function.
    
    - parameter transform:
    - returns: A dictionary
    */
    func toDictionary <K, V> (transform: (Element) -> (key: K, value: V)?) -> [K: V] {
        var result: [K: V] = [:]
        for item in self {
            if let entry = transform(item) {
                result[entry.key] = entry.value
            }
        }
        
        return result
    }
    
   
    
   

    
    /**
    Calls the passed block for each element in the array, either n times or infinitely, if n isn't specified
    
    - parameter n: the number of times to cycle through
    - parameter block: the block to run for each element in each cycle
    */
    func cycle (n: Int? = nil, block: (Element) -> ()) {
        var cyclesRun = 0
        while true {
            if let n = n {
                if cyclesRun >= n {
                    break
                }
            }
            for item in self {
                block(item)
            }
            cyclesRun++
        }
    }
    
    /**
    Runs a binary search to find the smallest element for which the block evaluates to true
    The block should return true for all items in the array above a certain point and false for all items below a certain point
    If that point is beyond the furthest item in the array, it returns nil
    
    See http://ruby-doc.org/core-2.2.0/Array.html#method-i-bsearch regarding find-minimum mode for more
    
    - parameter block: the block to run each time
    - returns: the min element, or nil if there are no items for which the block returns true
    */
    func bSearch (block: (Element) -> (Bool)) -> Element? {
        if count == 0 {
            return nil
        }
        
        var low = 0
        var high = count - 1
        while low <= high {
            let mid = low + (high - low) / 2
            if block(self[mid]) {
                if mid == 0 || !block(self[mid - 1]) {
                    return self[mid]
                } else {
                    high = mid
                }
            } else {
                low = mid + 1
            }
        }
        
        return nil
    }
    
    /**
    Runs a binary search to find some element for which the block returns 0.
    The block should return a negative number if the current value is before the target in the array, 0 if it's the target, and a positive number if it's after the target
    The Spaceship operator is a perfect fit for this operation, e.g. if you want to find the object with a specific date and name property, you could keep the array sorted by date first, then name, and use this call:
    let match = bSearch {  [targetDate, targetName] <=> [$0.date, $0.name] }
    
    See http://ruby-doc.org/core-2.2.0/Array.html#method-i-bsearch regarding find-any mode for more
    
    - parameter block: the block to run each time
    - returns: an item (there could be multiple matches) for which the block returns true
    */
    func bSearch (block: (Element) -> (Int)) -> Element? {
        let match = bSearch { item in
            block(item) >= 0
        }
        if let match = match {
            return block(match) == 0 ? match : nil
        } else {
            return nil
        }
    }
    
    /**
    Sorts the array by the value returned from the block, in ascending order
    
    - parameter block: the block to use to sort by
    - returns: an array sorted by that block, in ascending order
    */
    func sortUsing <U:Comparable> (block: ((Element) -> U)) -> [Element] {
        return self.sort({ block($0.0) < block($0.1) })
    }
    
    /**
    Removes the last element from self and returns it.
    
    - returns: The removed element
    */
    mutating func pop () -> Element? {
        
        if self.isEmpty {
            return nil
        }
        
        return removeLast()
        
    }
    
    /**
    Same as append.
    
    - parameter newElement: Element to append
    */
    mutating func push (newElement: Element) {
        return append(newElement)
    }
    
    /**
    Returns the first element of self and removes it from the array.
    
    - returns: The removed element
    */
    mutating func shift () -> Element? {
        
        if self.isEmpty {
            return nil
        }
        
        return removeAtIndex(0)
        
    }
    
    /**
    Prepends an object to the array.
    
    - parameter newElement: Object to prepend
    */
    mutating func unshift (newElement: Element) {
        insert(newElement, atIndex: 0)
    }
    
    /**
    Inserts an array at a given index in self.
    
    - parameter newArray: Array to insert
    - parameter atIndex: Where to insert the array
    */
    mutating func insert (newArray: Array, atIndex: Int) {
        self = take(atIndex) + newArray + skip(atIndex)
    }
    
    /**
    Deletes all the items in self that are equal to element.
    
    - parameter element: Element to remove
    */
    mutating func remove <U: Equatable> (element: U) {
        let anotherSelf = self
        
        removeAll(keepCapacity: true)
        
        anotherSelf.each {
            (index: Int, current: Element) in
            if (current as! U) != element {
                self.append(current)
            }
        }
    }
    
    /**
    Constructs an array containing the values in the given range.
    
    - parameter range:
    - returns: Array of values
    */
    @available(*, unavailable, message="use the '[U](range)' constructor") static func range <U: ForwardIndexType> (range: Range<U>) -> [U] {
        return [U](range)
    }
    
    /**
    Returns the subarray in the given range.
    
    - parameter range: Range of the subarray elements
    - returns: Subarray or nil if the index is out of bounds
    */
    subscript (rangeAsArray rangeAsArray: Range<Int>) -> Array {
        //  Fix out of bounds indexes
        let start = Swift.max(0, rangeAsArray.startIndex)
        let end = Swift.min(rangeAsArray.endIndex, count)
        
        if start > end {
            return []
        }
        
        return Array(self[Range(start: start, end: end)] as ArraySlice<Element>)
    }
    
    /**
    Returns a subarray whose items are in the given interval in self.
    
    - parameter interval: Interval of indexes of the subarray elements
    - returns: Subarray or nil if the index is out of bounds
    */
    subscript (interval: HalfOpenInterval<Int>) -> Array {
        return self[rangeAsArray: Range(start: interval.start, end: interval.end)]
    }
    
    /**
    Returns a subarray whose items are in the given interval in self.
    
    - parameter interval: Interval of indexes of the subarray elements
    - returns: Subarray or nil if the index is out of bounds
    */
    subscript (interval: ClosedInterval<Int>) -> Array {
        return self[rangeAsArray: Range(start: interval.start, end: interval.end + 1)]
    }
    
    /**
    Creates an array with the elements at indexes in the given list of integers.
    
    - parameter first: First index
    - parameter second: Second index
    - parameter rest: Rest of indexes
    - returns: Array with the items at the specified indexes
    */
    subscript (first: Int, second: Int, rest: Int...) -> Array {
        let indexes = [first, second] + rest
        return indexes.map { self[$0] }
    }
    
}

/**
Remove an element from the array
*/
public func - <T: Equatable> (first: [T], second: T) -> [T] {
    return first - [second]
}

/**
Difference operator
*/
public func - <T: Equatable> (first: [T], second: [T]) -> [T] {
    return first.difference(second)
}

/**
Intersection operator
*/
public func & <T: Equatable> (first: [T], second: [T]) -> [T] {
    return first.intersection(second)
}

/**
Union operator
*/
public func | <T: Equatable> (first: [T], second: [T]) -> [T] {
    return first.union(second)
}


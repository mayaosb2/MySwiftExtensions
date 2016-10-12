//
//  SWIFT_OPERATORS_EXTENSION.swift
//  FSZCItem
//  运算符的声明和重载（你懂得）==== 公式的解析
//  Created by MrShan on 16/6/29.
//  Copyright © 2016年 Mrshan. All rights reserved.
//

import Foundation

//MARK:阶乘方法
/**
*  声明一个操作符，infix说明他有两个操作数，左右各有一个，operator保留字操作符 ** 你懂得 associativity left 说明从左往右解析 precedence 160 意思是运算符优先级默认的
*/
infix operator ** { associativity left precedence 160 }

/**
 关于**的运算符 次幂运算 2**3 = 2^3 = 8
 
 - parameter leftNumber:  左边的数值
 - parameter rightNumber: 右边的数值
 
 - returns: 结果
 */
func ** (leftNumber:Double,rightNumber:Double)->Double {
    return pow(leftNumber,rightNumber)
}


infix operator **= { associativity right precedence 90 }

/**
 创建一个运算符，顺便创建一个此运算符的赋值运算符 例如 +=
 
 - parameter left:  左边数
 - parameter right: 右边数
 */
func **= (inout left: Double, right: Double) {
    left = left ** right
}


//MARK:公式解析器类 2016.6.29
class MathfunctionAnalyze {
    
    /**
     公式解析方法，阉割版
     a + b * ( c + d )  ==  cd+b*a+ == 34+5*6+ ==  3,4,+,5,*,6,+
     思路：将公式以计算机栈中存储的方式返回，并且每一层用[，]分割，有三个变量，中间计算结果，左操作数，右操作数，当计算完毕一次之后
     左边数值赋值为中间数，继续循环,这个栈是倒栈
     现在只是支持  + - * /  如果需要其他运算那么需要自定义并且协商好运算符表示方式  eg:  3**4 == 3 ^ 4
     
     - parameter mathFunction: 公式字符串
     
     - returns: 最终结果
     */
    class func ayalyze(mathFunction:String)->Double {
        var MIDDLE_NUMBER:Double = 0
        var leftNumber:Double?
        var rightNumber:Double?
        for eachItem in mathFunction.componentsSeparatedByString(",") {
            //这里进行处理
            if leftNumber == nil {
                leftNumber = eachItem.doubleValue!
                continue
            }
            if rightNumber == nil {
                rightNumber = eachItem.doubleValue!
                continue
            }
            MIDDLE_NUMBER = septetorChange("\(eachItem)", leftNumber: leftNumber!, rightNumber: rightNumber!)
            leftNumber = MIDDLE_NUMBER
            rightNumber = nil
        }
        return MIDDLE_NUMBER
    }
    
    /**
     运用递归方式来计算公式，完美版
     思路：34+56*-   ||    34+5*6-   两种方式的都可以，判断 左右操作数是否为空都不为空的时候才计算，如果有一个为空，那么就讲左操作数和当前操作符加入到成员变量数组中，遍历结束
     之后判断中间数组中数值个数是否是1，如果是则直接返回，如果不是则递归执行此方法，参数是中间数组
     34+5*6- == 3+4-5*6   ||  34+5*6- == 3+4*5-6
     3+5*6
     
     - parameter mathFunction: 操作符数组
     
     - returns: 结果
     */
    class func ayalyzeWow(mathFunction:[AnyObject])->Double {
        var MIDDLE_NUMBER:Double = 0
        var leftNumber:Double?
        var rightNumber:Double?
        var middle_array:[AnyObject] = []
        if mathFunction.count != 1 {
            for eachItem in mathFunction {
                if ifSep("\(eachItem)") {
                    //是操作符
                    if leftNumber != nil && rightNumber != nil {
                        MIDDLE_NUMBER = septetorChange("\(eachItem)", leftNumber: leftNumber!, rightNumber: rightNumber!)
                        middle_array.append(MIDDLE_NUMBER)
                        leftNumber = nil
                        rightNumber = nil
                        continue
                    }else{
                        if leftNumber != nil {
                            middle_array.append(leftNumber!)
                        }
                        if rightNumber != nil {
                            middle_array.append(rightNumber!)
                        }
                        middle_array.append(eachItem)
                        leftNumber = nil
                        rightNumber = nil
                        continue
                    }
                }else{
                    //不是操作符
                    if leftNumber == nil {
                        leftNumber = eachItem.doubleValue!
                        continue
                    }
                    if rightNumber == nil {
                        rightNumber = eachItem.doubleValue!
                        continue
                    }
                }
            }
            if middle_array.count != 1 {
                print(middle_array)
                return ayalyzeWow(middle_array)
            }else{
                return middle_array[0] as! Double
            }
        }else{
            return mathFunction[0] as! Double
        }
    }
    
    /**
     最终版
     3+6*5 == 365*+
     34+5*6- == 3+4-5*6
     a + b * ( c + d )  ==  3,4,+,5,*,6,+
     - parameter mathFunction: 公式数组
     
     - returns: 结果
     */
    class func analyzeFunctionLastVersion(mathFunction:[AnyObject])->Double{
        //一个公式最少3个操作符如果小于这个数那么就直接返回0
        if mathFunction.count < 3 {
            return 0
        }
        //当少于三个的时候直接计算
        if mathFunction.count == 3 {
            return self.septetorChange(mathFunction[2] as! String, leftNumber: mathFunction[0] as! Double, rightNumber: mathFunction[1] as! Double)
        }
        var middle_array:[AnyObject] = []
        for var i = 0 ; i < mathFunction.count ; i++ {
            if i + 2 < mathFunction.count {
                //正常处理，说明i后面还有至少俩对象
                if !ifSep("\(mathFunction[i])") && !ifSep("\(mathFunction[i+1])") && ifSep("\(mathFunction[i+2])") {
                    middle_array.append(self.septetorChange(mathFunction[i+2] as! String, leftNumber: mathFunction[i] as! Double, rightNumber: mathFunction[i+1] as! Double))
                    i+=2
                }else{
                    middle_array.append(mathFunction[i])
                }
            }else{
                //i后面没有两个对象了，有可能是最后一个，有可能后面还有一个,直接丢进去就行了
                middle_array.append(mathFunction[i])
            }
        }
        return analyzeFunctionLastVersion(middle_array)
    }
    
    /**
     判断字符串是否是操作符
     
     - parameter oper: 被判断的操作符
     
     - returns: true 是
     */
    class func ifSep(oper:String)->Bool {
        if oper.contains("+") || oper.contains("-") || oper.contains("*") || oper.contains("/") {
            return true
        }
        return false
    }
    
    /**
     中间运算符，计算方式
     
     - parameter oper:        运算符
     - parameter leftNumber:  左边的数值
     - parameter rightNumber: 右边的数值
     
     - returns: 结果
     */
    class func septetorChange(oper:String,leftNumber:Double,rightNumber:Double)->Double {
        switch oper {
        case "*" :return leftNumber * rightNumber;
        case "/" : return leftNumber / rightNumber;
        case "+": return leftNumber + rightNumber;
        case "-": return leftNumber - rightNumber;
        default:return 0
        }
    }
}




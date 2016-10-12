//
//  NSOperationQueueExtension.swift
//  FSZCItem
//
//  Created by MrShan on 16/7/1.
//  Copyright © 2016年 Mrshan. All rights reserved.
//

import Foundation

/**
 队列任务的类型
 
 - SQLite: 数据库操作
 - Others: 其他
 */
enum NSOperationType {
    case SQLite,Others
}

class NSOperationQueueExtension: NSOperationQueue {
    
    /**
     初始化方法
     
     - parameter queueName:      队列名称
     - parameter maxConcurrency: 队列重试次数
     - parameter maxRetries:     队列一个时间内可执行任务个数
     
     - returns:
     */
    required init(queueName: String, maxConcurrency: Int = 1,maxRetries: Int = 5) {
        super.init()
        self.name = queueName
        self.maxConcurrentOperationCount = maxConcurrency
    }
    
    /**
     添加任务的方法
     
     - parameter op:            任务
     - parameter operationType: 任务类型
     - parameter queueACC:      队列优先级
     */
    func addOperation(op: NSOperation, operationType:NSOperationType, queueACC:NSOperationQueuePriority) {
        op.queuePriority = queueACC
        super.addOperation(op)
    }
}


class TaskQueue: NSOperation {
    override func start() {
        super.start()
    }
    
    override func cancel() {
        super.cancel()
    }
    
    
    init(action:()->Void) {
        //self = NSBlockOperation(block: action)
    }
    
    
    
    
    
    
    
    
}
//
//  OperationManager.swift
//  YandexDiskApp
//
//  Created by Александр Чернов on 05.02.2018.
//  Copyright © 2018 Егор. All rights reserved.
//

import Foundation

class OperationManager
{
   private static var  operationQueue = OperationQueue()
    
    
    class func addOperation (op: Operation, cancellingQueue : Bool)
    {
        if cancellingQueue
        {
            operationQueue.cancelAllOperations()
        }
        
        operationQueue.maxConcurrentOperationCount = 1
        operationQueue.addOperation(op)
    }
}

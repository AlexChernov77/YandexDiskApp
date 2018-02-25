//
//  YaDiskVideoManager.swift
//  YandexDiskApp
//
//  Created by Иван on 21.02.2018.
//  Copyright © 2018 Егор. All rights reserved.
//

import Foundation
class YaDiskVideoManager
{
    class func getVideoOperation (limit: Int, offset: Int, success: @escaping () -> Void, failure: @escaping (Int) -> Void)
    {
        
        let operation = YaDiskGetVideoPreviewOperation(limit: limit, offset: offset, success: success, failure: failure)
        
        OperationManager.addOperation(op: operation, cancellingQueue: true)
    }
    
    
    class func getVideoPlay ( path: String, video: Video, success: @escaping ()-> Void, failure: @escaping (Int)-> Void )
    {
        let operation = YaDiskGetVideoPlayOperation(path: path, video: video, success: success, failure: failure)

        OperationManager.addOperation(op: operation, cancellingQueue: true)
    }
}

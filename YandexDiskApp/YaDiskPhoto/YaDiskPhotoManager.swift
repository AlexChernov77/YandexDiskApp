//
//  YaDiskPhotoManager.swift
//  YandexDiskApp
//
//  Created by Александр Чернов on 10.02.2018.
//  Copyright © 2018 Егор. All rights reserved.
//

import Foundation
class YaDiskPhotoManager
{
    class func getPhotoOperation (limit: Int, offset: Int, success: @escaping () -> Void, failure: @escaping (Int) -> Void)
    {
        
        let operation = YaDiskGetPhotoOperation(limit: limit, offset: offset, success: success, failure: failure)
        
        OperationManager.addOperation(op: operation, cancellingQueue: true)
    }
    
    
    class func getFullSizePhoto ( path: String, photo: Photo, success: @escaping ()-> Void, failure: @escaping (Int)-> Void )
    {
        let operation = YaDiskGetFullSizePhotoURLOperation(path: path, photo: photo, success: success, failure: failure)
        
        OperationManager.addOperation(op: operation, cancellingQueue: true)
    }
}

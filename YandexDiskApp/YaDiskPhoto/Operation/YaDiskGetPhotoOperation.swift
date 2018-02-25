//
//  YaDiskGetPhotoOperation.swift
//  YandexDiskApp
//
//  Created by Александр Чернов on 10.02.2018.
//  Copyright © 2018 Егор. All rights reserved.
//

import Foundation
import SwiftyJSON
import CoreData


class YaDiskGetPhotoOperation: Operation
{
    let success: () -> Void?
    let failure: ((Int) -> Void)?
    var offset: Int
    var limit: Int
    var urlSession: URLSessionDataTask?
    var fullSizePhoto = ""
    var id: Int64 = 0
    
    
    init(limit: Int, offset: Int, success: @escaping () -> Void,
         failure: @escaping (Int) -> Void)
    {
        self.success = success
        self.failure = failure
        self.limit = limit
        self.offset = offset
    }
    
    override func cancel()
    {
        urlSession?.cancel()
    }
    
    override func main()
    {
        let semaphore = DispatchSemaphore(value: 0)
        let backGroundContext = CoreDataManager.sharedInstance.getBackgroudContext()
        
        urlSession = YaDiskPhotoAPI_WRAPPER.getPhoto(limit: limit, offset: offset, mediaType: YConst.Arguments.kImageType as String, sort: YConst.Arguments.kSortByDate as String, success: { (jsonResponse) in
            
            let photos = jsonResponse["items"].arrayValue
            
            for photo in photos
            {
                let previewURL = photo["preview"].stringValue
                let created = photo["created"].stringValue
                let resourceID = photo["resource_id"].stringValue
                let name = photo["name"].stringValue
                let path = photo["path"].stringValue
                
                YaDiskPhotoModelFabric.setPhoto(id: self.id, created: created, name: name, resourceID: resourceID, path: path, previewURL: previewURL, fullSizePhoto: "", context: backGroundContext)
                self.id = self.id + 1
            }

            if self.isCancelled
            {
                self.success()
            }
            else
            {
                print("Бэкграндный котекст сохранен")
                _ =  try? backGroundContext.save()
                self.success()
            }
            _ = semaphore.signal()
            
        }) { (error) in
            // обработка ошибки
            _ = semaphore.signal()
        }
        _ = semaphore.wait(timeout: .distantFuture)
    }
}

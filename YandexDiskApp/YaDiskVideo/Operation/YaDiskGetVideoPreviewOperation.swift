//
//  YaDiskGetVideoPreviewOperation.swift
//  YandexDiskApp
//
//  Created by Иван on 21.02.2018.
//  Copyright © 2018 Егор. All rights reserved.
//

import Foundation
import SwiftyJSON
import CoreData

class YaDiskGetVideoPreviewOperation: Operation
{
    
    static var arrayVideo = [String]()
    
    let success: () -> Void?
    let failure: ((Int) -> Void)?
    var offset: Int
    var limit: Int
    var urlSession: URLSessionDataTask?
    var playVideoURL = ""
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
        
        urlSession = YaDiskVideoAPI_WRAPPER.getVIdeo(limit: limit, offset: offset, mediaType: YConst.Arguments.kVideoType as String, sort: YConst.Arguments.kSortByDate as String, success: { (jsonResponse) in
            
            let videos = jsonResponse["items"].arrayValue
            print("Video-------> \(jsonResponse)")
            
            for video in videos
            {
                let previewURL = video["preview"].stringValue
                let created = video["created"].stringValue
                let resourceID = video["resource_id"].stringValue
                let name = video["name"].stringValue
                let path = video["path"].stringValue
                let playVideoURL = jsonResponse["href"].stringValue
                
                YaDiskGetVideoPreviewOperation.arrayVideo.append(playVideoURL)
                
                YaDiskVideoModelFabrique.setVideo(id: self.id, created: created, name: name, resourceID: resourceID, path: path, previewURL: previewURL, videoURL: "", context: backGroundContext)
                self.id = self.id + 1
            }
            
            if self.isCancelled
            {
                self.success()
            }
            else
            {
                print("Бэкграндный котекст сохранен")
                print(videos)
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

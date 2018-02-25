//
//  YaDiskGetVideoPlayOperation.swift
//  YandexDiskApp
//
//  Created by Иван on 24.02.2018.
//  Copyright © 2018 Егор. All rights reserved.
//

import Foundation

class YaDiskGetVideoPlayOperation: Operation
{
    let path: String
    let success: () -> Void
    let failure: (Int) -> Void
    var urlSession: URLSessionDataTask?
    let video: Video
    
    init( path: String, video: Video, success: @escaping () -> Void, failure: @escaping (Int) -> Void)
    {
        self.path = path
        self.success = success
        self.failure = failure
        self.video = video
    }
    
    override func cancel()
    {
        urlSession?.cancel()
    }
    
    override func main()
    {
        let semaphore = DispatchSemaphore(value: 0)
        let context = CoreDataManager.sharedInstance.getBackgroudContext()
        urlSession = YaDiskPhotoAPI_WRAPPER.getFullSizePhotoURL(path: path, success: { (jsonResponse) in
            
            let videoURLFromJSON = jsonResponse["href"].stringValue
            
//            print("Фул сайз \(fullSizePhotoURL)")
            YaDiskVideoModelFabrique.setVideoURL(id: self.video.id, videoURL: videoURLFromJSON, context: context)
            print(videoURLFromJSON)
//            YaDiskPhotoModelFabric.setPhotoFullSizeURL(id: self.photo.id, fullSizePhoto: fullSizePhotoURL, context: context)
            
            if self.isCancelled
            {
                self.success()
            }
            else
            {
                print("Бэкграyндный котекст сохранен")
                _ =  try? context.save()
                self.success()
            }
            semaphore.signal()
            
        }) { (error) in
            self.failure(error)
            semaphore.signal()
        }
        
        
        _ = semaphore.wait(timeout: .distantFuture)
    }
}


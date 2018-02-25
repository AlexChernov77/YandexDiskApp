//
//  YaDiskGetFullSizePhotoURLOperation.swift
//  YandexDiskApp
//
//  Created by Александр Чернов on 17.02.2018.
//  Copyright © 2018 Егор. All rights reserved.
//

import Foundation

class YaDiskGetFullSizePhotoURLOperation: Operation
{
    let path: String
    let success: () -> Void
    let failure: (Int) -> Void
    var urlSession: URLSessionDataTask?
    let photo: Photo
    
    init( path: String, photo: Photo, success: @escaping () -> Void, failure: @escaping (Int) -> Void)
    {
        self.path = path
        self.success = success
        self.failure = failure
        self.photo = photo
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
            
            let fullSizePhotoURL = jsonResponse["href"].stringValue
            
            print("Фул сайз \(fullSizePhotoURL)")
            
            YaDiskPhotoModelFabric.setPhotoFullSizeURL(id: self.photo.id, fullSizePhoto: fullSizePhotoURL, context: context)
            
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

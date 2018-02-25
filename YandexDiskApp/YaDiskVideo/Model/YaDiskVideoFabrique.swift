//
//  YaDiskVideoFabrique.swift
//  YandexDiskApp
//
//  Created by Иван on 22.02.2018.
//  Copyright © 2018 Егор. All rights reserved.
//

import Foundation
import  CoreData

class YaDiskVideoModelFabrique
{
    
    class func setVideo (id: Int64, created: String, name: String, resourceID: String, path: String, previewURL: String, videoURL: String, context: NSManagedObjectContext)
    {
        let video = getVideo(id: id, context: context)
        
        if video == nil
        {
            let video = NSEntityDescription.insertNewObject(forEntityName: "Video", into: context) as! Video
            video.id = id
            video.resource_id = resourceID
            video.created = created
            video.name = name
            video.path = path
            video.previewURL = previewURL
            video.playVideoURL = videoURL
        }
        else
        {
            
            video!.created = created
            video!.name = name
            video!.path = path
            video!.previewURL = previewURL
            video!.playVideoURL = videoURL
        }
    }
    
    class func setVideoURL ( id: Int64, videoURL: String, context: NSManagedObjectContext)
    {
        
        let video = getVideo(id: id, context: context)
        print("Добавляем ссылку на видео-----\(video)")
        if video != nil
        {
            video?.playVideoURL = videoURL
        }

    }
    
    private class func getVideo (id: Int64, context: NSManagedObjectContext) -> Video?
    {
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Video")
        
        //        let request: NSFetchRequest<Dialog> = Dialog.fetchRequest()
        let predicate = NSPredicate(format: "id=%lld", id)
        fetchRequest.predicate = predicate
        let fetchResults = try? context.fetch(fetchRequest) as! [Video]
        if fetchResults!.count == 0
        {
            return nil
        }
        else
        {
            return fetchResults![0]
        }
    }
}


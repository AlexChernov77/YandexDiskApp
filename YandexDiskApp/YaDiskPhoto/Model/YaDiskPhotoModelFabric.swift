//
//  YaDiskPhotoModelFabric.swift
//  YandexDiskApp
//
//  Created by Александр Чернов on 16.02.2018.
//  Copyright © 2018 Егор. All rights reserved.
//

import Foundation
import  CoreData

class YaDiskPhotoModelFabric
{
    
    class func setPhoto (id: Int64, created: String, name: String, resourceID: String, path: String, previewURL: String, fullSizePhoto: String, context: NSManagedObjectContext)
    {
        let photo = getPhoto(id: id, context: context)
        
        if photo == nil
        {
             let photo = NSEntityDescription.insertNewObject(forEntityName: "Photo", into: context) as! Photo
            photo.id = id
            photo.resource_id = resourceID
            photo.created = created
            photo.name = name
            photo.path = path
            photo.previewURL = previewURL
            photo.fullSizeImage = fullSizePhoto
        }
        else
        {
            
            photo!.created = created
            photo!.name = name
            photo!.path = path
            photo!.previewURL = previewURL
            photo!.fullSizeImage = fullSizePhoto
        }
    }
    
    class func setPhotoFullSizeURL ( id: Int64, fullSizePhoto: String, context: NSManagedObjectContext)
    {
        
        let photo = getPhoto(id: id, context: context)
        if photo != nil
        {
            photo?.fullSizeImage = fullSizePhoto
        }
        
    }
    
    private class func getPhoto (id: Int64, context: NSManagedObjectContext) -> Photo?
    {
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Photo")
        
        //        let request: NSFetchRequest<Dialog> = Dialog.fetchRequest()
        let predicate = NSPredicate(format: "id=%lld", id)
        fetchRequest.predicate = predicate
        let fetchResults = try? context.fetch(fetchRequest) as! [Photo]
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

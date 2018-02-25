//
//  YaDiskPhotoModel.swift
//  YandexDiskApp
//
//  Created by Александр Чернов on 10.02.2018.
//  Copyright © 2018 Егор. All rights reserved.
//

import Foundation

class YaDiskPhotoModel
{
    let created: String
    let name: String
    let resourceID: Int64
    let path: String
    let previewURL: String
    
    init( created: String, name: String, resourceID: Int64, path: String, previewURL: String)
    {
        self.name = name
        self.created = created
        self.path = path
        self.previewURL = previewURL
        self.resourceID = resourceID
    }
}

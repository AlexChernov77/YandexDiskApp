//
//  Const.swift
//  YandexDiskApp
//
//  Created by Егор on 01.02.2018.
//  Copyright © 2018 Егор. All rights reserved.
//

import Foundation

class YConst {
    
    class AuthConst {
        
        static let authURL = "https://oauth.yandex.ru/authorize?response_type=token"
        static let clientIdArgument = "client_id="
        static let clientID = "b65a12411d17460bae76ad99aa76c5ae"
        
        static let kBaseURL = "https://cloud-api.yandex.net:443/v1/disk"
    }
    
    class Methods
    {
        //Получить список файлов упорядоченный по имени
        //его параметры в запросе limit , offset, media_type
        static let kMethodFilesListGet = "/resources/files"
        static let kMethodFullPhotoSizeURL = "/resources/download"
    }
    
    class Arguments
    {
        static let kLimit: NSString = "limit" // Количество файлов, описание которых следует вернуть в ответе
        static let kOffset: NSString = "offset" // отступ
        static let kMediaType: NSString = "media_type" // Тип файлов, которые нужно включить в список
        static let kImageType: NSString = "image"
        static let kVideoType: NSString = "video"
        static let kAudioType: NSString = "audio"
        static let kSort: NSString = "sort"
        static let kSortByDate: NSString = "-created"
        static let kPath: NSString = "path"
    }
    
}

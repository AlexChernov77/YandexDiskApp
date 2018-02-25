//
//  YaDiskVideoAPI_WRAPPER.swift
//  YandexDiskApp
//
//  Created by Иван on 21.02.2018.
//  Copyright © 2018 Егор. All rights reserved.
//

import Foundation
import SwiftyJSON

class YaDiskVideoAPI_WRAPPER
{
    
    class func getVIdeo (limit: Int, offset: Int, mediaType: String, sort: String ,success: @escaping (JSON) -> Void, failure: @escaping (Int) -> Void ) -> URLSessionDataTask
    {
        
        let argumentsDictionary = NSMutableDictionary()
        
        argumentsDictionary.setObject("\(limit)", forKey: YConst.Arguments.kLimit)
        argumentsDictionary.setObject("\(offset)", forKey: YConst.Arguments.kOffset)
        argumentsDictionary.setObject( mediaType, forKey: YConst.Arguments.kMediaType as NSCopying)
        argumentsDictionary.setObject( sort, forKey: YConst.Arguments.kSort)
        
        
        let request = GlobalAPIConfigure.composeGenericHTTPGetRequest(forBaseURL: YConst.AuthConst.kBaseURL, andMethod: YConst.Methods.kMethodFilesListGet, withParameters: argumentsDictionary)
        
        
        let dataTask = URLSession.shared.dataTask(with: request as URLRequest) { (data, response, error) in
            GlobalAPIConfigure.completionHandler(withResponseData: data, response: response, error: error, successBlock: success, failureBlock: failure)
        }
        dataTask.resume()
        return dataTask
    }
    
    class func getVideoURL ( path: String, success: @escaping (JSON) -> Void, failure: @escaping (Int) -> Void) -> URLSessionDataTask
    {
        let argsDictionary = NSMutableDictionary()
        let encodePath = path.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed)!
        
        argsDictionary.setObject("\(encodePath)", forKey: YConst.Arguments.kPath)
        
        let request = GlobalAPIConfigure.composeGenericHTTPGetRequest(forBaseURL: YConst.AuthConst.kBaseURL, andMethod: YConst.Methods.kMethodFullPhotoSizeURL, withParameters: argsDictionary)
        
        let dataTask = URLSession.shared.dataTask(with: request as URLRequest) { (data, response, error) in
            GlobalAPIConfigure.completionHandler(withResponseData: data, response: response, error: error, successBlock: success, failureBlock: failure)
        }
        dataTask.resume()
        return dataTask
    }
}


//
//  GlobalAPIConfigure.swift
//  YandexDiskApp
//
//  Created by Александр Чернов on 06.02.2018.
//  Copyright © 2018 Егор. All rights reserved.
//

import Foundation
import SwiftyJSON

class GlobalAPIConfigure
{
    // Общий метод для гет-запроса
    class func composeGenericHTTPGetRequest (forBaseURL baseURL: String, andMethod method: String, withParameters parameters: NSDictionary) -> NSURLRequest
    {
        
        var requestString = baseURL + method + "?"
        
        let keysArray = parameters.allKeys as! [String]
        
        for i in 0..<keysArray.count
        {
            let key = keysArray[i]
            let value = parameters[key] as! String
            
            if (i < keysArray.count - 1)
            {
                requestString += "\(key)=\(value)&"
            }
            else
            {
                requestString += "\(key)=\(value)"
            }
        }
        
        
        let request = NSMutableURLRequest ()
        request.httpMethod = "GET"
        request.setValue("OAuth " + YAuth.shared.getAccessToken(), forHTTPHeaderField: "Authorization")
        request.url = URL(string: requestString)
        print("ЗАПРОС  \(request)")
        return request
    }
    
    // Общий метод для пост-запроса
    class func composeGenericHTTPPostRequest (forBaseURL baseURL: String, andMethod method: String, withParameters parameters: NSDictionary) -> NSURLRequest
    {
        var requestString = baseURL + method + "?"
        
        let keysArray = parameters.allKeys as! [String]
        
        for i in 0..<keysArray.count
        {
            let key = keysArray[i]
            let value = parameters[key] as! String
            
            if (i < keysArray.count - 1)
            {
                requestString += "\(key)=\(value)&"
            }
            else
            {
                requestString += "\(key)=\(value)"
            }
        }
        
        //        print("строка запроса - \(requestString)")
        
        let request = NSMutableURLRequest ()
        request.httpMethod = "POST"
        request.setValue("OAuth " + YAuth.shared.getAccessToken(), forHTTPHeaderField: "Authorization")
        request.url = URL(string: requestString)
        
        return request
    }
    
    // обработка data запроса, получение JSON
     class func completionHandler(withResponseData data: Data?, response: URLResponse?, error: Error?, successBlock: (_ jsonResponse: JSON) -> Void, failureBlock: (_ errorCode: Int) -> Void)
    {
        if (error != nil)
        {
            failureBlock((error! as NSError).code)
        }
        
        if (data != nil)
        {
            do
            {
                let json = try JSONSerialization.jsonObject(with: data!, options: .mutableContainers)
                let swiftyJSON = JSON(json)
                print("ответ - \(swiftyJSON)")
                successBlock(swiftyJSON)
            }
            catch
            {
                failureBlock(-80)
            }
        }
        else
        {
            failureBlock(-80)
        }
    }
}

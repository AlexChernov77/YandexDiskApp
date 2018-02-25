//
//  YAuthorization.swift
//  YandexDiskApp
//
//  Created by Егор on 01.02.2018.
//  Copyright © 2018 Егор. All rights reserved.
//

import UIKit
import WebKit

//MARK:- интерфейс
class YAuth: NSObject {
    
    static let shared = YAuth()
    
    var success: (() -> Void)?
    var failure: (() -> Void)?
    
    func authorization (webView: WKWebView, success: @escaping () -> Void, failure: @escaping () -> Void) {
        
        self.success = success
        self.failure = failure
        
        if getAccessToken() != "" {
            success()
            return
        }
        
        let authURL = URL(string: YConst.AuthConst.authURL + "&" + YConst.AuthConst.clientIdArgument + YConst.AuthConst.clientID)!
        let authRequest = URLRequest(url: authURL)
        webView.load(authRequest)
        webView.navigationDelegate = self
    }
}

//MARK: - логика получения токена (протокол WKNavigationDelegate)
extension YAuth: WKNavigationDelegate {
    func webView(_ webView: WKWebView, decidePolicyFor navigationAction: WKNavigationAction, decisionHandler: @escaping (WKNavigationActionPolicy) -> Void) {
        
        if let url = navigationAction.request.url {
            
            if url.scheme == "myapp" {
                print(url)
                let set = CharacterSet(charactersIn: "#=&")
                let arr = String(describing: url).components(separatedBy: set)
                let token = arr[2]
                
                setAccessToken(token: token)
                success!()
            }
            
        } else {
            
            failure!()
            
        }
        
        decisionHandler(.allow)
    }
}

//MARK:- логика хранения токена
extension YAuth {
    
    private func setAccessToken (token: String) {
        UserDefaults.standard.set(token, forKey: "AccessToken")
        UserDefaults.standard.synchronize()
    }
    
     func getAccessToken () -> String {
        if let tokenStr = UserDefaults.standard.object(forKey: "AccessToken") as? String {
            return tokenStr
        }
        return ""
    }
}

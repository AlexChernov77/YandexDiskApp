//
//  ViewController.swift
//  YandexDiskApp
//
//  Created by Егор on 17.01.2018.
//  Copyright © 2018 Егор. All rights reserved.
//

import UIKit
import WebKit

class ViewController: UIViewController
{
    
    @IBOutlet weak var webView: WKWebView!
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
    }
    
    
    override func viewDidAppear(_ animated: Bool)
    {
        super.viewDidAppear(true)
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5)
        {
            YAuth.shared.authorization(webView: self.webView, success:
                {
                    print("токен: \(YAuth.shared.getAccessToken())")
                    self.performSegue(withIdentifier: "kTabbarSegueIdentifier", sender: self)
                    
                    
            }, failure:
                {
                    
                    let alert = UIAlertController(title: nil, message: "Авторизация не удалась", preferredStyle:  .alert)
                    let alertAction = UIAlertAction(title: "Ок", style: .default, handler: nil)
                    alert.addAction(alertAction)
                    self.present(alert, animated: true, completion: nil)
            })

        }
    }
}


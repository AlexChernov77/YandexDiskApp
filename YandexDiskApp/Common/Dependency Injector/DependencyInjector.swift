//
//  DependencyInjector.swift
//  YandexDiskApp
//
//  Created by Александр Чернов on 06.02.2018.
//  Copyright © 2018 Егор. All rights reserved.
//

import Foundation

class DependencyInjector
{
    class func assignPresenter (view : ViewInterface)
    {
        
        var presenter: PresenterInterface?
        if (view is YaDiskPhotoViewController)
        {
            presenter = YaDiskPhotoPresenter()
        }
        if (view is YaDiskVideoViewController)
        {
            presenter = YaDiskVideoPresenter()
        }
//        if (view is  "Егора контроллер")
//        {
//            let presenter = "Егора презентер"
//        }
//
        if presenter != nil
        {
            view.assignPresenter(presenter: presenter!)
            presenter?.assignView(view: view)
        }
    }
}

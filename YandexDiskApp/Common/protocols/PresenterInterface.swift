//
//  PresenterInterface.swift
//  YandexDiskApp
//
//  Created by Александр Чернов on 06.02.2018.
//  Copyright © 2018 Егор. All rights reserved.
//

import Foundation

protocol PresenterInterface
{
    // загрузка View
    func assignView(view: ViewInterface) -> Void
    // обновить данные
    func updateData() -> Void
    func loadData () -> Void
    func modelAt (atIndexPath indexPath: IndexPath) -> Any
    func numberOfModel () -> Int
    func getData (withOffset offset: Int, and count: Int) -> Void
    func getDownloadLink (path: String, model: Any)
}

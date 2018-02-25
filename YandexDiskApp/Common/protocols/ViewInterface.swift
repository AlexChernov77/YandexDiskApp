//
//  ViewInterface.swift
//  YandexDiskApp
//
//  Created by Александр Чернов on 06.02.2018.
//  Copyright © 2018 Егор. All rights reserved.
//

import Foundation

protocol ViewInterface: class
{
    func assignPresenter (presenter: PresenterInterface) -> Void
    func reloadData () -> Void
}

protocol ViewFrcInterface: class
{
    func beginUpdates () -> Void
    func endUpdates () -> Void
    func insert ( at : IndexPath ) -> Void
    func delete ( at : IndexPath ) -> Void
    func move ( from : IndexPath , to : IndexPath ) -> Void
    func update ( at : IndexPath ) -> Void
}

//
//  YaDiskVideoPresenter.swift
//  YandexDiskApp
//
//  Created by Иван on 21.02.2018.
//  Copyright © 2018 Егор. All rights reserved.
//

import Foundation
import CoreData

class YaDiskVideoPresenter: NSObject , PresenterInterface 
{
    let sf = 0
    weak var view: ViewInterface?
    weak var viewFrc: ViewFrcInterface?
    
    lazy var fetchedResultController : NSFetchedResultsController<NSFetchRequestResult> = {
        
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Video")
        let sortDescriptor = NSSortDescriptor(key: "id", ascending: true)
        fetchRequest.sortDescriptors = [sortDescriptor]
        
        let frc = NSFetchedResultsController(fetchRequest: fetchRequest, managedObjectContext: CoreDataManager.sharedInstance.getMainContext(), sectionNameKeyPath: nil, cacheName: nil)
        
        frc.delegate = self
        _ = try? frc.performFetch()
        
        
        return frc
    }()
    
    func assignView(view: ViewInterface)
    {
        self.view = view
    }
    
    func loadData()
    {
        DispatchQueue.main.async
            {
                self.getData(withOffset: 0, and: 40)
        }
    }
    
    func modelAt(atIndexPath indexPath: IndexPath) -> Any
    {
        return fetchedResultController.object(at: indexPath)
    }
    
    func updateData()
    {
        
    }
    
    func numberOfModel() -> Int
    {
        if let objectsArray = fetchedResultController.fetchedObjects
        {
            return objectsArray.count
        }
        return 0
    }
    
    func getData(withOffset offset: Int, and count: Int)
    {
        DispatchQueue.main.async
            {
                YaDiskVideoManager.getVideoOperation(limit: count, offset: offset, success: {
                    print("Главный контекст сохранен")
                    CoreDataManager.sharedInstance.save()
                    self.view?.reloadData()
                }, failure: { (error) in
                    print(error)
                })
        }
    }
    
    func getDownloadLink(path: String, model: Any)
    {
        YaDiskVideoManager.getVideoPlay(path: path, video: model as! Video, success: {
            print("Главный контекст сохранен, добавлена фулл скрин фотка")
            CoreDataManager.sharedInstance.save()
        }) { (error) in
            print(error)
        }
    }
}

extension YaDiskVideoPresenter: NSFetchedResultsControllerDelegate
{
    func controllerWillChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>)
    {
        viewFrc?.beginUpdates()
    }
    
    func controller(_ controller: NSFetchedResultsController<NSFetchRequestResult>, didChange anObject: Any, at indexPath: IndexPath?, for type: NSFetchedResultsChangeType, newIndexPath: IndexPath?)
    {
        if type == .insert
        {
            viewFrc?.insert(at: newIndexPath!)
        }
        
        if type == .update
        {
            viewFrc?.update(at: indexPath!)
        }
        
        if type == .move
        {
            viewFrc?.move(from: indexPath!, to: newIndexPath!)
        }
        
        if type == .delete
        {
            viewFrc?.delete(at: indexPath!)
        }
    }
    
    func controllerDidChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>)
    {
        viewFrc?.endUpdates()
    }
}


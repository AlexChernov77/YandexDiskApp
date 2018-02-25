//
//  YaDiskVideoViewController.swift
//  YandexDiskApp
//
//  Created by Александр Чернов on 05.02.2018.
//  Copyright © 2018 Егор. All rights reserved.
//

import UIKit

//добавить энтити

class YaDiskVideoViewController: UIViewController
{
    
    let kVideoCollectionViewCellNib = UINib(nibName: "YaDiskVideoCollectionViewCell", bundle: nil)
    let kVideoCollectionViewCellReuseIdentifier = "kVideoCollectionViewCellReuseIdentifier"
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    var presenter: PresenterInterface?
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        collectionView.register(kVideoCollectionViewCellNib, forCellWithReuseIdentifier: kVideoCollectionViewCellReuseIdentifier)
        DependencyInjector.assignPresenter(view: self)
        print("Размер \(presenter?.numberOfModel())")
    }
    
}

extension YaDiskVideoViewController: ViewInterface
{
    func assignPresenter(presenter: PresenterInterface)
    {
        self.presenter = presenter
        self.presenter?.loadData()
    }
    
    func reloadData()
    {
        DispatchQueue.main.async
            {
                self.collectionView.reloadData()
        }
    }
    
}

extension YaDiskVideoViewController: UICollectionViewDataSource, UICollectionViewDelegateFlowLayout
{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int
    {
        if presenter?.numberOfModel() != nil {
        print("Размер \(presenter?.numberOfModel())")
        return (presenter?.numberOfModel())!
        } else {
            return 0
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell
    {
        let model = presenter?.modelAt(atIndexPath: indexPath) as! Video
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: kVideoCollectionViewCellReuseIdentifier, for: indexPath) as! YaDiskVideoCollectionViewCell
        
        cell.configureSelf(model: model)
        
        return cell
        
    }
    
//    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath)
//    {
//        collectionView.deselectItem(at: indexPath, animated: true)
//
//        let model = presenter?.modelAt(atIndexPath: indexPath) as! Video
//
//        presenter?.getDownloadLink(path: model.path!, model: model)
//        print("Фул скрин фотка \(model.fullSizeImage)")
//    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath)
    {
        collectionView.deselectItem(at: indexPath, animated: true)
        
        let model = presenter?.modelAt(atIndexPath: indexPath) as! Video

        presenter?.getDownloadLink(path: model.path!, model: model)
        print("УРЛ----->> \(model.playVideoURL)")
        
        let videoLauncher = VideoLauncher()
        videoLauncher.showVideoPlayer()

    }

    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath)
    {
//        if indexPath.row == (presenter?.numberOfModel() ?? 0 ) - 15
//        {
//            presenter?.getData(withOffset: ((presenter?.numberOfModel())! - 15), and: 30)
//        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat
    {
        return 1
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat
    {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize
    {
        let size = (collectionView.bounds.size.width - 5) / 4
//        let height = (collectionView.bounds.size.height - 3) / 3
        
        return CGSize(width: size, height: size)
    }
}

extension YaDiskVideoViewController: ViewFrcInterface
{
    func beginUpdates()
    {
        
    }
    
    func endUpdates()
    {
        
    }
    
    
    
    func insert(at: IndexPath)
    {
        self.collectionView.insertItems(at: [at])
    }
    
    func delete(at: IndexPath)
    {
        self.collectionView.deleteItems(at: [at])
    }
    
    func move(from: IndexPath, to: IndexPath)
    {
        self.collectionView.moveItem(at: from, to: to)
    }
    
    func update(at: IndexPath)
    {
        self.collectionView.reloadItems(at: [at])
    }
    
}


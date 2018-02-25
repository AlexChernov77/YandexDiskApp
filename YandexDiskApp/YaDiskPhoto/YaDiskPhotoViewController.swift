//
//  YaDiskPhotoViewController.swift
//  YandexDiskApp
//
//  Created by Александр Чернов on 05.02.2018.
//  Copyright © 2018 Егор. All rights reserved.
//

import UIKit

class YaDiskPhotoViewController: UIViewController
{

    let kPhotoCollectionViewCellNib = UINib(nibName: "YaDiskPhotoCollectionViewCell", bundle: nil)
    let kPhotoCollectionViewCellReuseIdentifier = "kPhotoCollectionViewCellReuseIdentifier"
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    var presenter: PresenterInterface?
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        collectionView.register(kPhotoCollectionViewCellNib, forCellWithReuseIdentifier: kPhotoCollectionViewCellReuseIdentifier)
        DependencyInjector.assignPresenter(view: self)
    }

}

extension YaDiskPhotoViewController: ViewInterface
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

extension YaDiskPhotoViewController: UICollectionViewDataSource, UICollectionViewDelegateFlowLayout
{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int
    {
        print("Размер \(presenter?.numberOfModel())")
        return (presenter?.numberOfModel())!
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell
    {
        let model = presenter?.modelAt(atIndexPath: indexPath) as! Photo
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: kPhotoCollectionViewCellReuseIdentifier, for: indexPath) as! YaDiskPhotoCollectionViewCell
        
        cell.configureSelf(model: model)
        
        return cell
        
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath)
    {
        collectionView.deselectItem(at: indexPath, animated: true)
        
        let model = presenter?.modelAt(atIndexPath: indexPath) as! Photo

            presenter?.getDownloadLink(path: model.path!, model: model)
        print("Фул скрин фотка \(model.fullSizeImage)")
    }
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath)
    {
//        if indexPath.row == (presenter?.numberOfModel() ?? 0 ) - 15
//        {
//            presenter?.getData(withOffset: ((presenter?.numberOfModel())! - 1), and: 30)
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
        let size = (collectionView.bounds.size.width - 2) / 3
        return CGSize(width: size, height: size)
    }
}

extension YaDiskPhotoViewController: ViewFrcInterface
{
    func beginUpdates()
    {
        
    }
    
    func endUpdates()
    {
        
    }
    

    
    func insert(at: IndexPath)
    {
//        collectionView.performBatchUpdates(<#T##updates: (() -> Void)?##(() -> Void)?##() -> Void#>, completion: <#T##((Bool) -> Void)?##((Bool) -> Void)?##(Bool) -> Void#>)
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

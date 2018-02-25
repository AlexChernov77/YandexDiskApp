//
//  YaDiskVideoCollectionViewCell.swift
//  YandexDiskApp
//
//  Created by Иван on 21.02.2018.
//  Copyright © 2018 Егор. All rights reserved.
//

import UIKit
import  SDWebImage

class YaDiskVideoCollectionViewCell: UICollectionViewCell {
    
//    var names : Video?
    
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    
    
    override func awakeFromNib()
    {
        super.awakeFromNib()
    }
    
    func configureSelf ( model: Video )
    {
        nameLabel.text = model.name
//        print("----->>>>>> \(names?.name)")
        SDWebImageDownloader.shared().setValue("OAuth " + YAuth.shared.getAccessToken(), forHTTPHeaderField: "Authorization")
        imageView.sd_setImage(with: URL(string: model.previewURL!))
    }
    
    
}

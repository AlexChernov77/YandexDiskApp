//
//  YaDiskPhotoCollectionViewCell.swift
//  YandexDiskApp
//
//  Created by Александр Чернов on 16.02.2018.
//  Copyright © 2018 Егор. All rights reserved.
//

import UIKit
import  SDWebImage

class YaDiskPhotoCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var imageView: UIImageView!
    override func awakeFromNib()
    {
        super.awakeFromNib()
    }

    func configureSelf ( model: Photo )
    {

         SDWebImageDownloader.shared().setValue("OAuth " + YAuth.shared.getAccessToken(), forHTTPHeaderField: "Authorization")
        imageView.sd_setImage(with: URL(string: model.previewURL!))
    }
    
    
}

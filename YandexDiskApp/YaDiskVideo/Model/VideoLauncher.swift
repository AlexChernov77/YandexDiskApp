//
//  VideoLauncher.swift
//  YandexDiskApp
//
//  Created by Иван on 24.02.2018.
//  Copyright © 2018 Егор. All rights reserved.
//

import UIKit
import AVFoundation

class VideoPlayerView: UIView {
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        backgroundColor = .black

        let urlString = "https://downloader.disk.yandex.ru/disk/f492bc5a318877ea142991b140cac91a9d4c2025de371acd8efd908228f16a74/5a92953d/ZeNpSr8Odu-klBzKl_IJg8HpD_GBRe7z8bWsnGPFowBfTiR60hM61ZyOJpjuQGw8zZAs7Ob4kLlvwc__GwStiQ%3D%3D?uid=588151642&filename=63Pro_programmistov_i_novii_god.mp4&disposition=attachment&hash=&limit=0&content_type=video%2Fmp4&fsize=14070931&hid=b99556ceeec33ec710efad89cd638f6f&media_type=video&tknv=v2&etag=3d5f451dc8241a8618af75434fd6ffcc"
        print(urlString)
        if let url = URL(string: urlString) {
            let player = AVPlayer(url: url)
            let playerLayer = AVPlayerLayer(player: player)
            self.layer.addSublayer(playerLayer)
            playerLayer.frame = self.frame
            
            player.play()
            player.actionAtItemEnd = AVPlayerActionAtItemEnd.none
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

class VideoLauncher: NSObject {
    
    func showVideoPlayer() {
        print("showing")
        
        if let keyWindow = UIApplication.shared.keyWindow {
            let view = UIView(frame: keyWindow.frame)
            view.backgroundColor = UIColor.black.withAlphaComponent(0.82)
            
            view.frame = CGRect(x: keyWindow.frame.width , y: 230, width: 0, height: 0)
           
            let height = keyWindow.frame.width * (9 / 16)
            let videoPlayerFrame = CGRect(x: 0, y: 0, width: keyWindow.frame.width, height: height)
            let videoPlayerView = VideoPlayerView(frame: videoPlayerFrame)
            
            view.addSubview(videoPlayerView)
            keyWindow.addSubview(view)
            
            UIView.animate(withDuration: 0.5, animations: {
                view.frame = keyWindow.frame

                
                
            })
            
        }
        
    }
    
}

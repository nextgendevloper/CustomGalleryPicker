//
//  PhotoDataSource.swift
//  CustomGalleryPicker
//
//  Created by HKBeast on 20/04/23.
//

import Foundation
import PhotosUI

class PhotoDataSource{
    var images: [PHAsset] = []
    var selectedImages: [PHAsset] = []
    
    func fetchImages() {
//        let allPhotosOptions = PHFetchOptions()
//        allPhotosOptions.sortDescriptors = [NSSortDescriptor(key: "creationDate", ascending: false)]
//        let allPhotos = PHAsset.fetchAssets(with: .image, options: allPhotosOptions)
//        allPhotos.enumerateObjects({ (asset, count, stop) in
//            self.images.append(asset)
//        })
         images = fetchAllAssets()
    }
    
    
    func imageCount()->Int{
        return images.count
    }
}

//
//  Configure.swift
//  CustomGalleryPicker
//
//  Created by HKBeast on 28/04/23.
//

import Foundation
import Photos
import UIKit

struct IOSPickerConfiguration{
  
    
    var albumType:AlbumSort = .ALL
    var showEmptyAlbum:Bool = false
    var albumFetchOption:PHFetchOptions? = nil
    
    
    var selectedAsset = [GPAsset]()
    var assetMinSelection = 1
    var assetMaaxSelection = 5
    var assetFilters:AssetFilters = .CreationDate
    var cacheAssetSize:CGSize = CGSize(width: 600, height: 600)
    var allowSelectAll:Bool = false
    var contentMode:PHImageContentMode = .aspectFill
    var assetMediaType:PHAssetMediaType = .image
    var videoAssetDuration:CGFloat = 0.0
    
}

enum AlbumSort{
    case USER
    case DEFAULT
    case ALL
}

enum AssetFilters:String{
    case CreationDate = "Creation Date"
}

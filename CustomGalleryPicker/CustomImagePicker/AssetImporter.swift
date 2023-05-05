//
//  AssetImporter.swift
//  CustomGalleryPicker
//
//  Created by HKBeast on 27/04/23.
//

import Foundation
import Photos
import UIKit

//MARK: - *** Fetch All Image ***

//Fetch All asset according to their creation date
func fetchAllAssets() -> [PHAsset] {
    // Create empty array of assets
    var assets = [PHAsset]()
    
    // Create options for the fetch request
    let options = PHFetchOptions()
    options.sortDescriptors = [NSSortDescriptor(key: "creationDate", ascending: true)]
    
    // Fetch all photos and videos from the user's library
    let results = PHAsset.fetchAssets(with: options)
    
    // Enumerate through the results and add each asset to the array
    results.enumerateObjects { object, _, _ in
      //  if object.mediaType == .image || object.mediaType == .video {
            assets.append(object)
      //  }
    }
    
    // Return the array of assets
    return assets
}


//Fetch All asset according to their creation date
func fetchAsset(at:Int) -> PHAsset{
    // Create empty array of assets
    var assets = [PHAsset]()
    
    // Create options for the fetch request
    let options = PHFetchOptions()
    options.sortDescriptors = [NSSortDescriptor(key: "creationDate", ascending: true)]
    
    // Fetch all photos and videos from the user's library
    let results = PHAsset.fetchAssets(with: options)
    return results.object(at: at)
    // Enumerate through the results and add each asset to the array
//    results.enumerateObjects { object, _, _ in
//      //  if object.mediaType == .image || object.mediaType == .video {
//            assets.append(object)
//      //  }
//    }
    
    // Return the array of assets
//    return assets
}
//Fetch All asset according to their creation date
func fetchCount() ->Int {
    // Create empty array of assets
    var assets = [PHAsset]()
    
    // Create options for the fetch request
    let options = PHFetchOptions()
    options.sortDescriptors = [NSSortDescriptor(key: "creationDate", ascending: true)]
    
    // Fetch all photos and videos from the user's library
    let results = PHAsset.fetchAssets(with: options)
   return results.count
    // Enumerate through the results and add each asset to the array
    results.enumerateObjects { object, _, _ in
      //  if object.mediaType == .image || object.mediaType == .video {
            assets.append(object)
      //  }
    }
    
    // Return the array of assets
//    return assets
}



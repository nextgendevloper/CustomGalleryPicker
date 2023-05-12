//
//  GPModel.swift
//  CustomGalleryPicker
//
//  Created by HKBeast on 25/04/23.
//

import Foundation
import Photos
import UIKit

class GPAlbum  {
    // originalCollection : PHAssetCollection
    let originalCollection:PHAssetCollection
    // fetchResult : PHFetchResult<PHAsset>
    var fetchResult:PHFetchResult<PHAsset>
    // count {
    var count:Int{
        get{
            return fetchResult.count
        }
    }
    
    //    // title {
    //    originalAlbum.localisedTitle
    var title:String{
        get{
            return originalCollection.localizedTitle ?? " "
        }
    }

//    // thumbImage
//    //manager.shared.getThumbFor(album)
    
    
    
    
//
//// ID {
//return originalCollection.ID
//}
    var id:String{
        get{
            return originalCollection.localIdentifier
        }
    }
    
    
//
//init(phCollection : PHCollection) {
//// for each GPModal , fetch assetsResult ( only result )
//
//fetchResult = result
//
    init(phAssetCollection:PHAssetCollection,type:PHAssetMediaType){
        originalCollection = phAssetCollection
        
        let fetchOptions = PHFetchOptions()
        fetchOptions.predicate = NSPredicate(format: "mediaType == %d || mediaType == %d",
                                             type.rawValue)
        
        fetchResult = PHAsset.fetchAssets(in: phAssetCollection, options: fetchOptions)
        
    }
    
    
    func isEqaulTo(album:GPAlbum) -> Bool {
        return self.id == album.id
    }
    
}



   //IOSGallaryPicker
    // GPModal {
    // asset
    // albumName
    // smartAlbum
    // duration
    // thumbImage
    // isSelected
    // iCloud?
    //}


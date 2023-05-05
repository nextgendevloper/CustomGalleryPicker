//
//  IOSGalleryPickerVM.swift
//  CustomGalleryPicker
//
//  Created by HKBeast on 27/04/23.
//

import Foundation
import UIKit
import Photos

class IOSGalleryPickerVM{
    //intialize all all images array
    var allAssets = [PHAsset]()
    var selectedAssetsDict = [String:PHAsset]()
    //fetch all asset
    func fetchAllImages(){
       
         allAssets = fetchAllAssets()
//        createSelectedDictonary()
    }
    
    func createSelectedDictonary(){
//        for asset in allAssets{
//            let dict = asset.localIdentifier:asset
//            selectedAssetsDict.append(dict)
//        }
    }
    
}

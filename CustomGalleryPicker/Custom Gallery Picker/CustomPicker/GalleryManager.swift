//
//  GalleryManager.swift
//  CustomGalleryPicker
//
//  Created by HKBeast on 02/05/23.
//

import Foundation
import UIKit
import Photos

class GalleryManager{
  
    //MARK: - *** Variables ***
    
    var configuration = IOSPickerConfiguration()
    
   static  var shared = GalleryManager()
    
    //cache Manager object
    var cacheManager = PHCachingImageManager()
    
    //fetch Service class object
    var fetchService = GalleryFetchService()
    
    var albumList = [GPAlbum]()
    
    var onAlbumLoaded:((Bool)->())?
    
    //MARK: - *** Private Functions ***
    
    func loadAlbum(){
        // use configuratioin object to create predicate
        
        // fetch albums from PHrequest method
        let albums = fetchAlbums()
        // for each album create GPAlbumModel isnert into albumList for cache
        albums.forEach { assetCollection in
            let model = GPAlbum(phAssetCollection: assetCollection, type: configuration.assetMediaType)
            if !albumList.contains(where: { asset in
                asset.id == model.id
            }){
//            if !model.isEqaulTo(album: model){
                albumList.append(model)
                
            }
        }
        
        // call completion onAlbumLoaded(true/false)
         onAlbumLoaded?(true)
    }
    

    //MARK: - *** Fetching Methods ***
    
    /// cancel fetching at indexPath
    func cancelFetching(index:IndexPath) {
        if let id = fetchService.cancelFetching(indexPath: index){
            cacheManager.cancelImageRequest(id)
        }
    }

    
    //fetch image return request id
    ///fetchImage and return request ID
    func fetchImage(index:IndexPath,asset:PHAsset , size :CGSize = GalleryManager.shared.configuration.cacheAssetSize , contentMode:PHImageContentMode = GalleryManager.shared.configuration.contentMode, options:PHImageRequestOptions? = nil, completion:@escaping(UIImage,Error?,IndexPath)->() ) -> PHImageRequestID {
startCaching(assets: [asset])
//        var iD : PHImageRequestID = -1
        let reqID = cacheManager.requestImage(for: asset, targetSize: size, contentMode: contentMode, options: options) { image, _ in
            if let img = image{
//                fetchService.hashTable[IndexPath]
                completion(img,nil,index)
            
            }
        }
//        iD = reqID
        return reqID
    }


    
///fetch Image Data for original Image
    func fetchImageData(asset:PHAsset , size :CGSize = GalleryManager.shared.configuration.cacheAssetSize , contentMode:PHImageContentMode = GalleryManager.shared.configuration.contentMode, options:PHImageRequestOptions? = nil, completion:@escaping(Data,Error?)->()) {

        cacheManager.requestImageDataAndOrientation(for: asset, options: options) { imgData, _, _, _ in
            if let data = imgData{
                completion(data,nil)
            }
        }
        

    }


    ///fetch avasset  for original video
    func fetchAvasset(asset:PHAsset,option:PHVideoRequestOptions? = nil,completion:@escaping(AVAsset,Error?)->()) {

        cacheManager.requestAVAsset(forVideo: asset, options: option) { avAsset, _, _ in
            if let asset = avAsset{
                completion(asset,nil)
                
            }
        }
    }



    //MARK: - *** Caching Methods ***

    func startCaching(assets:[PHAsset] , size :CGSize = GalleryManager.shared.configuration.cacheAssetSize , contentMode:PHImageContentMode = GalleryManager.shared.configuration.contentMode, options:PHImageRequestOptions? = nil) {
        
        //start caching
      cacheManager.startCachingImages(for: assets, targetSize: size, contentMode: contentMode, options: options)

    }

    func stopCAching(assets:[PHAsset] , size :CGSize = GalleryManager.shared.configuration.cacheAssetSize , contentMode:PHImageContentMode = GalleryManager.shared.configuration.contentMode, options:PHImageRequestOptions? = nil) {
        
        //stop caching
      cacheManager.stopCachingImages(for: assets, targetSize: size, contentMode: contentMode, options: options)

    }

    func stopCAchingForAllAssets() {
        
        //cancel all caching
        cacheManager.stopCachingImagesForAllAssets()
    }
    
}

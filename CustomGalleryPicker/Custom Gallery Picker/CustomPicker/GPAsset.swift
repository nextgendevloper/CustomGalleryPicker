//
//  GPAsset.swift
//  CustomGalleryPicker
//
//  Created by HKBeast on 02/05/23.
//

import Foundation
import UIKit
import Photos

class GPAsset{
    //MARK: - *** variables ***
    let originalAsset:PHAsset
    
    // assetID
    // get asset.localize id
    var iD:String{
        get{
          return  originalAsset.localIdentifier
        }
    }
    
    
    var requestID:IndexPath?
    //assetDuration
    // get asset.duration
    
    var duration:CGFloat{
        get{
            if type == .video{
                return originalAsset.duration
            }else{
                return 0
            }
        }
    }
    
    // type
    //get
    var type:PHAssetMediaType{
        get{
           return originalAsset.mediaType
        }
    }
    
    var width:CGFloat{
        get{
            return CGFloat(originalAsset.pixelWidth)
        }
    }
    //width
    //get
    
    var height:CGFloat{
        get{
            return CGFloat(originalAsset.pixelHeight)
        }
    }
    // height
    //get
    
    //MARK: - *** init ***
    init(phAsset:PHAsset){
        
        originalAsset = phAsset
        
    }
    
}

//MARK: - *** extension ***

extension GPAsset {
    
    /**
     Fetch an image with the specific size.
     */
    
    // fetch image for current asset woth indexpath
    func fetchImage(with indexPath:IndexPath, size: CGSize = GalleryManager.shared.configuration.cacheAssetSize,
                    options: PHImageRequestOptions? = nil,
                    contentMode: PHImageContentMode = GalleryManager.shared.configuration.contentMode,
                    completion: @escaping (UIImage?,Error?,IndexPath,String) -> Void){
        
        //create fetch Service object
         let fetchService = GalleryManager.shared.fetchService
//
//        //if fetching is in process for current indexPath then return from here
//        if fetchService.isFetching(indexPath: indexPath){
//
//            return
//        }
       
        //else generate new request id for process
        let newID  =  GalleryManager.shared.fetchImage(index: indexPath, asset: self.originalAsset) { img, error,id in
           
           // say we are not moving and completion hits back
           // make sure id is in process alredy ( isFetching(indexPath) )
           // if true then go forwards else return
           
           // if we scrolled, id will get removed in didEnd and isFeching will return false
           // no need to go below
           
            //if error found cancel the fetch request
             /// else complete fetch request
           ///
           if indexPath == id{
               
               
               if error != nil{
                   fetchService.completeFetching(indexPath: indexPath)
                   completion(nil,error,indexPath,self.iD)
               }
               
               else{
                   fetchService.cancelFetching(indexPath: indexPath)
                   
                   completion(img,nil,indexPath,self.iD)
               }
           }
        }
    //register this fetching to corresponding index
        fetchService.registerFetching(id: newID, indexPath: indexPath)
//        self.requestID = newID
        
    }
    
    
    
    
    /**
     Fetch an image with the original size.
     */
    @objc func fetchOriginalImage(options: PHImageRequestOptions? = nil,
                                  completeBlock: @escaping (_ image: UIImage?, _ info: [AnyHashable: Any]?) -> Void) {
        GalleryManager.shared.fetchImageData(asset: self.originalAsset) { data, error in
            if error != nil {
                //print log
            }
            else{
                //create image with data
            }
        }
    }
    
    
    
    
    
    /**
     Fetch an image data with the original size.
     */
    @objc func fetchImageData(options: PHImageRequestOptions? = nil,
                              compressionQuality: CGFloat = 0.9,
                              completeBlock: @escaping (_ imageData: Data?, _ info: [AnyHashable: Any]?) -> Void) {
        GalleryManager.shared.fetchImageData(asset: self.originalAsset) { data, error in
            if error != nil {
                //print log
            }
            else{
                //create image with data
            }
        }
    }
    
    
    
    
    
    /**
     Fetch an AVAsset with a completeBlock and PHVideoRequestOptions.
     */
    @objc func fetchAVAsset(options: PHVideoRequestOptions? = nil,
                            completeBlock: @escaping (_ AVAsset: AVAsset?, _ info: [AnyHashable: Any]?) -> Void) {
        GalleryManager.shared.fetchAvasset(asset: self.originalAsset) { avAsset, error in
            if error != nil {
                //print log
            }
            else{
                //create video with data
            }
        }
    }
    
    
    
    
    
    
    
    @objc func cancelRequests(indexPath:IndexPath) {
                objc_sync_enter(self)
                defer { objc_sync_exit(self) }
        //
        GalleryManager.shared.cancelFetching(index: indexPath)
    
                
    }
    
}


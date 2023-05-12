//
//  CustomPIckerHelper.swift
//  CustomGalleryPicker
//
//  Created by HKBeast on 24/04/23.
//

import Foundation
import Photos
import UIKit




////func to convert asset into GPModelArray
//func getArrayModelOfGPModel()->[GPModel]{
//   //let and initialize arrayModel with empty
//    var modelArray = [GPModel]()
//    //get allAssets and store in constant
//    let allAsset = fetchAllAssets()
//    //iterate one by one asset from ModelArray
//    for asset in allAsset{
//        //let variable of type GPModel and initialize it
//        //set model properties from asset properties
//        let model = GPModel()
//        model.asset = asset
//        model.albumName = getAlbumName(for: asset)
//        model.smartAlbum = getSmartAlbumName(for: asset)
//        model.isSelected = true
//        //get duration only if media is video
//        if asset.mediaType == .video{
//            model.duration = CGFloat(getVideoDuration(asset: asset) ?? 0.0)
//          //  print("duration",model.duration as Any)
//        }
//        //now append the model into modelArray
//        modelArray.append(model)
//        
//        //log to show albumName and smart AlbumName
//        if model.smartAlbum != nil {
//          //  print("\(String(describing: model.albumName))",": \(String(describing: model.smartAlbum) )")
//        }
//    }
//
//    return modelArray
//}


//
func fetchByNameOfAlbums(sortAlbum by:AlbumSort = .ALL) -> [String] {
    
    var albums = [String]()
    var userAlbumsArray = [String]()
    var defaultAlbumsArray = [String]()
    
    // Fetch all user-created albums from the photo library
    let userAlbumsOptions = PHFetchOptions()
    userAlbumsOptions.predicate = NSPredicate(format: "estimatedAssetCount > 0")
    let userAlbums = PHAssetCollection.fetchAssetCollections(with: .album, subtype: .albumRegular, options: userAlbumsOptions)
    userAlbums.enumerateObjects { object, _, _ in
        //get albumName String from Object
        if let title = object.localizedTitle{
            albums.append(title)
            userAlbumsArray.append(title)
        }
    }

    // Fetch all smart albums from the photo library
    let smartAlbums = PHAssetCollection.fetchAssetCollections(with: .smartAlbum, subtype: .albumRegular, options: nil)
    smartAlbums.enumerateObjects { object, _, _ in
        //get albumName String from Object
        if let title = object.localizedTitle{
            albums.append(title)
            defaultAlbumsArray.append(title)
        }
    }

    
    if by == .USER{
       return userAlbumsArray
    }
    else if by == .DEFAULT{
        return defaultAlbumsArray
    }
   
    return albums
}


/// fetch smart album list - from system
func fetchAlbums() -> [PHAssetCollection] {
    var totalPhotos = 0
    
    var arrayOfALbums = [PHAssetCollection]()
    let userAlbums = PHAssetCollection.fetchAssetCollections(with: .album, subtype: .any, options: nil)
    
    userAlbums.enumerateObjects { cAlbum, index, info in
        
        let allAssets = PHAsset.fetchAssets(in: cAlbum, options: nil)
//        if cAlbum.localizedTitle == "Recents" {
//            print(allAssets.count)
//        }
       
        
            if allAssets.count != 0 {
                arrayOfALbums.append(cAlbum)
              //  print("\(cAlbum.localizedTitle ?? "No Name") Count: \(allAssets.count) ")
            }
        
        
        
    }
    
    
    //smart Album
    let smartAlbum = PHAssetCollection.fetchAssetCollections(with: .smartAlbum, subtype: .any, options: nil)
    
    smartAlbum.enumerateObjects { cAlbum, index, info in
        
        let allAssets = PHAsset.fetchAssets(in: cAlbum, options: nil)
//        if cAlbum.localizedTitle == "Recents" {
//            print(allAssets.count)
//        }
       
        
            if allAssets.count != 0 {
                arrayOfALbums.append(cAlbum)
              //  print("\(cAlbum.localizedTitle ?? "No Name") Count: \(allAssets.count) ")
            }
        
        
        
    }
    

    return arrayOfALbums
}

//fetch array of album object of gallery
func fetchAlbums(sortAlbum by:AlbumSort = .ALL) -> [PHAssetCollection] {
    
    var albums = [PHAssetCollection]()
    var userAlbumsArray = [PHAssetCollection]()
    var defaultAlbumsArray = [PHAssetCollection]()

    // Fetch all user-created albums from the photo library
    let userAlbumsOptions = PHFetchOptions()
    userAlbumsOptions.predicate = NSPredicate(format: "estimatedAssetCount > 0")
    let userAlbums = PHAssetCollection.fetchAssetCollections(with: .smartAlbum, subtype: .any, options: userAlbumsOptions)
    userAlbums.enumerateObjects { object, _, _ in
        if object.estimatedAssetCount > 0 {
            userAlbumsArray.append(object)
            albums.append(object)
        }
//        print(object.assetCollectionSubtype)
        print(object.localizedTitle)

    }
    // Fetch all smart albums from the photo library
    let smartAlbums = PHAssetCollection.fetchAssetCollections(with: .smartAlbum, subtype: .any, options: nil)
    smartAlbums.enumerateObjects { object, _, _ in
        print(object.localizedTitle)
        
        if object.estimatedAssetCount > 0 {
            albums.append(object)
            defaultAlbumsArray.append(object)

        }
    }
    
    
    if by == .USER{
       return userAlbumsArray
    }
    else if by == .DEFAULT{
        return defaultAlbumsArray
    }
   
    return albums
}



//fetchAssetsFromAlbum
func fetchAssetsFromAlbum(album: PHAssetCollection) -> [PHAsset] {
    let fetchOptions = PHFetchOptions()
    fetchOptions.predicate = NSPredicate(format: "mediaType == %d", PHAssetMediaType.image.rawValue)

    let assets = PHAsset.fetchAssets(in: album, options: nil)
    var assetArray = [PHAsset]()
    assets.enumerateObjects { (asset, index, stop) in
        assetArray.append(asset)
    }

    return assetArray
}
func fetchAssetsfrom(album: PHAssetCollection) -> PHFetchResult<PHAsset> {
    let fetchOptions = PHFetchOptions()
    fetchOptions.predicate = NSPredicate(format: "mediaType == %d", PHAssetMediaType.image.rawValue)

    let assets = PHAsset.fetchAssets(in: album, options: nil)
    var assetArray = [PHAsset]()
    assets.enumerateObjects { (asset, index, stop) in
        assetArray.append(asset)
    }

    return assets
}

//fetchAsset of specific album
func fetchAssetsFromAlbum(albumName: String) -> [PHAsset] {
    let fetchOptions = PHFetchOptions()
    fetchOptions.predicate = NSPredicate(format: "mediaType == %d || mediaType == %d",
                                         PHAssetMediaType.image.rawValue,
                                         PHAssetMediaType.video.rawValue)

    let albumFetchOptions = PHFetchOptions()
    albumFetchOptions.predicate = NSPredicate(format: "localizedTitle = %@", albumName)
    let albums = PHAssetCollection.fetchAssetCollections(with: .smartAlbum, subtype: .any, options: albumFetchOptions)

    if let album = albums.firstObject {
        let assets = PHAsset.fetchAssets(in: album, options: fetchOptions)
        var assetArray = [PHAsset]()
        assets.enumerateObjects { (asset, index, stop) in
            assetArray.append(asset)
        }
        return assetArray
    } else {
        return []
    }
}




// to album name of specific asset
func getAlbumName(for asset: PHAsset) -> String? {
    let options = PHFetchOptions()
    options.includeAssetSourceTypes = [.typeUserLibrary, .typeCloudShared, .typeiTunesSynced]
    let collections = PHAssetCollection.fetchAssetCollectionsContaining(asset, with: .album, options: options)
    guard let album = collections.firstObject else { return nil }
    return album.localizedTitle
}


// to album name of specific asset
//func getSmartAlbumName(for asset: PHAsset) -> String? {
//    let options = PHFetchOptions()
//    options.includeAssetSourceTypes = [.typeUserLibrary, .typeCloudShared, .typeiTunesSynced]
//    let collections = PHAssetCollection.fetchAssetCollections(withLocalIdentifiers: [asset.localIdentifier], options: nil) //fetchAssetCollectionsContaining(asset, with: .smartAlbum, options: nil)
//    guard let album = collections.firstObject else { return nil }
//    return album.localizedTitle
//}



//get video duration
func getVideoDuration(asset: PHAsset) -> TimeInterval? {
    guard asset.mediaType == .video else {
        return nil
    }
    
    
    return asset.duration
}



//extension of phasset
extension  PHAsset {
    
    //check is avilable on icloud
    
    func isAssetOnCloud() -> Bool {
        let options = PHImageRequestOptions()
        options.isSynchronous = true
        options.version = .current
        options.deliveryMode = .highQualityFormat
        
        var isInCloud = false
        PHCachingImageManager.default().requestImageDataAndOrientation(for: self, options: options,resultHandler:  { (_, _, _, info) in
            if let info = info, let isCloud = info[PHImageResultIsInCloudKey] as? Bool {
                isInCloud = isCloud
            }
        })
        
        return isInCloud
    }
    
    
    
    
    //get image from asset
    func fetchImage(displaySize : CGSize? = nil , _ option : PHImageRequestOptions? = nil,indexpath:IndexPath, completion : @escaping ((UIImage?,IndexPath,String)->()))->PHImageRequestID?{
       
        var options : PHImageRequestOptions = PHImageRequestOptions()
        if option == nil {
        options.resizeMode = .exact
        options.deliveryMode = .highQualityFormat
        options.isSynchronous = true
        options.isNetworkAccessAllowed = true
        }else{
            options = option!
        }
        // Whats the Aspect Ratio of Image
        let imageWidth:CGFloat = CGFloat(self.pixelWidth)
        let imageHeight:CGFloat = CGFloat(self.pixelHeight)
        var imageSize = CGSize(width: imageWidth, height: imageHeight)
        
        if let size_ = displaySize {
        // Should Be resized By Width Or Height
        var resizeWidth:CGFloat = size_.width
        var resizeHeight:CGFloat = resizeWidth * imageHeight/imageWidth
        if(resizeHeight>size_.height){
            resizeHeight = size_.height
            resizeWidth = resizeHeight * imageWidth/imageHeight
        }
            imageSize = CGSize(width: resizeWidth, height: resizeHeight)

        }
        if let manager = PHCachingImageManager.default() as? PHCachingImageManager {
            manager.startCachingImages(for: [self], targetSize: CGSize(width: 600, height: 600), contentMode: .aspectFit, options: options)
        }
      return  PHCachingImageManager.default().requestImage(for: self, targetSize: imageSize, contentMode: .aspectFit, options: options, resultHandler: {(resultImage, info) in
            
            if(resultImage == nil)
            {
                // This means ios could not get the image
                let optionsFast = PHImageRequestOptions()
                optionsFast.deliveryMode = .highQualityFormat
                optionsFast.isSynchronous = false
                optionsFast.isNetworkAccessAllowed = true
                
                PHImageManager.default().requestImage(for: self, targetSize: imageSize, contentMode: .aspectFit, options: optionsFast, resultHandler: {(resultImage2, info) in
                    
                   
                    if resultImage2 == nil {
                        completion(nil,indexpath,self.localIdentifier)
                    }else{
                        completion(resultImage2,indexpath,self.localIdentifier)

                    
                    }
                })
            } else
            {
                completion(resultImage,indexpath,self.localIdentifier)

            }
        })
    }
}


func getSmartAlbumName(for asset: PHAsset) -> String? {
    let options = PHFetchOptions()
    let smartAlbums = PHAssetCollection.fetchAssetCollections(with: .smartAlbum, subtype:.any, options: options)

    for i in 0..<smartAlbums.count {
        
        
        let smartAlbum = smartAlbums.object(at: i)
        if smartAlbum.localizedTitle != "Recents" {
            let assets = PHAsset.fetchAssets(in: smartAlbum, options: nil)
            
            let index = assets.index(of: asset)
            if index != NSNotFound {
                
                return smartAlbum.localizedTitle
            }
        }
        
        
       // print("smartAlbum: \(smartAlbum.localizedTitle)")
        
    }

    
    
    return nil
}

//
//func getSmartAlbumName(for asset: PHAsset) -> String? {
//    let collections = PHAssetCollection.fetchAssetCollectionsContaining(asset, with: .album, options: nil)
//
//    for i in 0..<collections.count {
//        let collection = collections.object(at: i)
//        if let smartAlbum = collection as? PHAssetCollection, smartAlbum.assetCollectionType == .smartAlbum {
//            return smartAlbum.localizedTitle
//        }
//    }
//
//    return nil
//}

    
    /*
     
     
     allPhotos = getAllPhotos()
     
     allPhotos[17].isselevted = true
     
     photos where album name == "AddWatermark Photos "
     photos.isSelected
     
     */
//}





//comment


// get asset from fetched Image at indexpath
// set images on imageView at indePath
//        DispatchQueue.global().async {
//            let asset = self.viewModel.allAssets[indexPath.row].fetchImage(displaySize: CGSize(width: 600, height: 600)) { img in
//                DispatchQueue.main.async {
//                    cell.imageView.image = img
//                }
//
//            }
//        }


// set asset idetifier into cell string
//        cell.representedAssetIdentifier = asset.localIdentifier

//
//        PHCachingImageManager.default().requestImage(for: asset, targetSize: CGSize(width: 200, height: 200), contentMode: .aspectFit, options: nil) { (image, _) in
//            if cell.representedAssetIdentifier == asset.localIdentifier {
//                cell.imageView.image = image
//            }
//        }
//        cacheManager.requestImage(for: asset, targetSize: CGSize(width: 200, height: 200), contentMode: .aspectFill) { (image, _) in
//            if cell.representedAssetIdentifier == asset.localIdentifier {
//                cell.imageView.image = image
//            }
//        }

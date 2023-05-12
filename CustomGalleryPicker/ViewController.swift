//
//  ViewController.swift
//  CustomGalleryPicker
//
//  Created by HKBeast on 20/04/23.
//

import UIKit
import Photos

class ViewController: UIViewController, IOSGalleryPickerDelegate, AlbumPickerDelegate {
    func onEndMultipleSelection(assets: [GPAsset], vc: IOSGalleryPickerViewController) {
        
    }
    
    func onEndSingleSelection(asset: GPAsset, vc: IOSGalleryPickerViewController) {
        
    }
    
    func onSelectAlbum(_ album: GPAlbum) {
        print("selected album",album.title)
    }
    
    func onAddPhotos(assets: [PHAsset], vc: IOSGalleryPickerViewController) {
        
    }
    
    func onReachVideoDureation(asset: PHAsset, vc: IOSGalleryPickerViewController) {
        
    }
    
    func onMaximumSelectionLimit(assets: [PHAsset], vc: IOSGalleryPickerViewController) {
        
    }
    
    func onEndMultipleSelection(assets: [PHAsset], vc: IOSGalleryPickerViewController) {
        
    }
    
    func onEndSingleSelection(asset: PHAsset, vc: IOSGalleryPickerViewController) {
        
    }
    
    func onCancel(vc: IOSGalleryPickerViewController) {
        
    }
    
    func onAddPhotos(assets: [PHAsset]) {
      
        let options = PHImageRequestOptions()
        options.deliveryMode = .highQualityFormat
        options.isNetworkAccessAllowed = true

        PHImageManager.default().requestImage(for: assets[0], targetSize: CGSize(width: 200, height: 200), contentMode: .aspectFit, options: options) { (image, info) in
            if let image = image {
                // Do something with the image, such as setting it to an image view
                self.imageView.image = image
            } else {
                print("Could not retrieve image from PHAsset")
            }
        }
    }
    

    @IBOutlet weak var imageView:UIImageView!
    override func viewDidLoad() {
        super.viewDidLoad()
        //        // Do any additional setup after loading the view.
        //        let x = fetchAssets(mediaType: .image)
        //        print(x[1].fetchImage(completion: { img in
        //           let image = img!
        //            self.imageView.image = image
        //        }))
        //
        //
        //        let y = getAlbumName(for: x[1])
        //        print(y)
        //        for album in fetchAlbums(){
        //           let x = fetchAssetsFromAlbum(album: album)
        //            print("albumPhoto: ",x)
        //            let y = getAlbumName(for: x[0])
        //            print(y)
        //        }
        //
        //
        //    }
        
//
//        let y = fetchAssetsFromAlbum(albumName: "AddWatermark Watermarks")
//        print("raw",y.count)
      //  let allPhotos = getArrayModelOfGPModel()
     //   fetchAlbums()
       // print("Model Array",x)
        
        
       
        
       // fetchAlbums(sortAlbum: .DEFAULT)
        
        
//
//        // get smart album list where count is not zero
//                let smartAlbumList = fetchSmartAlbumList()
//
//        // get photos list with assigned smart album
//        // make list of smart album from allPhotos belonging
//        let allPhotos = getArrayModelOfGPModel()
//        var albumList = [String]()
//        allPhotos.forEach { photoModel in
//            print(photoModel.smartAlbum as Any)
//            let filterArray = albumList.filter({$0 == photoModel.smartAlbum ?? ""})
//            if filterArray.isEmpty {
//                if photoModel.smartAlbum != nil && photoModel.smartAlbum != "" {
//                    albumList.append(photoModel.smartAlbum!)
//                }
//            }
//
//        }
//        // compare first and second array ( should be same )
        
//        print("SystemAlbum: ", smartAlbumList , "GPAlbum: ",albumList)
        
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
    
    /*
     fetchAllAsset() -> [GPModal]
     gpModal.asset.fetchImage
     print gpModal.albumName =
     modal.duration
     */
    
    /*
     GPAllAssets
     fetchAsswtsFor(albumName) -> [GPModal]
     
     filter - obj.albumname == albumname -> return
     */

    @IBAction func openGalleryDidPressed(_ sender:UIButton){
        
//        let vc = AlbumViewVC(delegate: self)
//        self.navigationController?.present(vc, animated: true)
        var config:IOSPickerConfiguration = IOSPickerConfiguration()
        config.assetMaaxSelection = 5
        config.assetMediaType = .image
        config.videoAssetDuration = 30.0
        let vc = IOSGalleryPickerViewController(config: config)
        vc.delegate = self
        self.navigationController?.present(vc, animated: true)
    }
//
//    userReachedMax(vc:IOSGalleryPickerViewController) {
//        vc.showAlert("purchase").callback { onPurchase , onCancel
//
//        }
//
//    }
}


//
//  CustomImagePicker.swift
//  AddWatermark
//
//  Created by HKBeast on 20/04/23.
//

import UIKit
import Photos


/* Class of Custom Image Picker to solve the bug because of apple default ph picker*/
class IOSGalleryPickerViewController: UIViewController, AlbumPickerDelegate {
    func onSelectAlbum(_ album: GPAlbum) {
        print("selected Album")
        selectedAlbum(album)
    }
    
    
 
    
     //MARK: - Variables
    var configuration = IOSPickerConfiguration()
    var model = PhotoDataSource()
    var viewModel = IOSGalleryPickerVM()
    var cacheManager = CacheManager.shared
    var delegate:IOSGalleryPickerDelegate?
    var isMultipleSelectionAllowed:Bool{
        get{
            return configuration.assetMaaxSelection > 1 ? true : false
        }
    }
    var selectedAssetsMap = [ String : GPAsset ]()
    var selectedAssets = [  GPAsset ]()
    var assetsPickerCollection:UICollectionView?
    var currentAlbum:GPAlbum?{
        didSet{
            assetsPickerCollection!.reloadData()
        }
    }
    
    //MARK: - Outlet
    
    @IBOutlet weak var cancelButton:UIButton!
    @IBOutlet weak var addButton:UIButton!
    @IBOutlet weak var collectionViewPlaceholder:UIView!
    @IBOutlet weak var albumCVButton:UIButton!
    
    //MARK: - init
    
    init(config:IOSPickerConfiguration){
        super.init(nibName: "IOSGalleryPickerViewController", bundle: nil)
        self.configuration = config
        GalleryManager.shared.configuration = config
        selectedAssets = config.selectedAsset
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
     addCollectionView()
        //manager.onAlbumLoaded { success
        //  selectAlbum(manager.albums[0])
        //}
        
        GalleryManager.shared.onAlbumLoaded = { [self] bool in
           let albumList = GalleryManager.shared.albumList
            let album = albumList.firstIndex(where: {$0.title == "Recents"})
            selectedAlbum(albumList[album ?? 0])
            print ("hello")
        }
        GalleryManager.shared.loadAlbum()
//        GalleryManager.shared permission
        
        if isMultipleSelectionAllowed{
            addButton.isHidden = false
        }
        else{
            addButton.isHidden = true
        }
    }

    //MARK: - Methods
    @IBAction func cancelDidPressed(_ sender:UIButton){
        GalleryManager.shared.stopCAchingForAllAssets()
        self.dismiss(animated: true)
    }
    @IBAction func addDidPressed(_ sender:UIButton){
//        self.delegate?.onAddPhotos(assets: model.selectedImages)
        self.dismiss(animated: true)
    }
    @IBAction func showAlbumDidPressed(_ sender:UIButton){
        openAlbumListVC()
    }
    
    func addCollectionView(){
        assetsPickerCollection = UICollectionView(frame: view.bounds, collectionViewLayout: UICollectionViewFlowLayout())
       assetsPickerCollection?.delegate = self
       assetsPickerCollection?.dataSource = self
       assetsPickerCollection?.allowsMultipleSelection = configuration.assetMaaxSelection > 1 ? true : false
       assetsPickerCollection?.register(ImagePickerCell.self, forCellWithReuseIdentifier: "cell")
       collectionViewPlaceholder.addSubview(assetsPickerCollection!)
    }
    
    func selectedAlbum(_ album:GPAlbum){
        currentAlbum = album
    }
  
    func openAlbumListVC() {
        
    let vc = AlbumViewVC(delegate: self)
       present(vc, animated: true)
//        vc.didMove(toParent: self)
//    albumPicker.albums = manager.albums
//    albumPicker.selectedALbum = currentALbum
    
    }
    
    func convertToGPAsset(asset:PHAsset)->GPAsset{
        let model = GPAsset(phAsset: asset)
        return model
    }
   
}


//didLoad() {
//// add assetPcikerCollectionView
//
////manager.permission { allow
//   !allow -> Show Alert
//    allow -> {
// manager.loadALbums()
//
//manager.onAlbumLoaded { success
//  selectAlbum(manager.albums[0])
//}
//
//
//func selectAlbum(album){
//    currentAlbum = album
//
//}
//
//func openAlbumListVC() {
//
//addChildVC(albumPickerVC)
//
//albumPicker.albums = manager.albums
//albumPicker.selectedALbum = currentALbum
//
//}
//
//
//func DoneClicked {
//  Delegate->InformSelectedASsets
//}
//
//numberOFItem = currentALbum.assetCount
//
//cellForITem = currentAlbum.asset(atIndex)
//
//willDisplay = currentAlbum.asset(atIndex) , tryToFetch
//
//didSelect = cell.asset -> GPAsset -> SelectedAssetsArray
//-> DelegateInform
//
//
//
//func onSelectOrRemoveAsset(Asset) {
//   // add asset , remove from selectedAssets
//  // call delgate about selection
//}
//
//func shoudSelect {
//// deelgate.shouldSelect
//}
//
//// Listner For ALBUM VC
//
//func onSelectAlbum(album){
//  // call selectAlbum(album)
//}
//}


extension IOSGalleryPickerViewController:UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout,UICollectionViewDataSourcePrefetching{
   
    
    //MARK: - Collection View Delegates
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        //get count of all images
        return currentAlbum?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, prefetchItemsAt indexPaths: [IndexPath]) {
        // arrray
        var array = [PHAsset]()
        // for each indexpath , get asset from album
        indexPaths.forEach { indexPath in
            if let asset = currentAlbum?.fetchResult.object(at: indexPath.item){
                // create list of [PHAssets]
                array.append(asset)
            }
        }
   
        // manager.startChaching(array , config.cac
        GalleryManager.shared.startCaching(assets: array)
    }
  
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        //create object of cell
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! ImagePickerCell
        
        //get asset from ArrayOfAasset
        if let asset = currentAlbum?.fetchResult.object(at: indexPath.item){
            cell.configure(at: indexPath, for: convertToGPAsset(asset: asset))
        }

//        cell.asset lies inside selectdAsset {
//            cell.isSelected = true
//        }false
        
        return cell
    }
    
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        if let cell = collectionView.cellForItem(at: indexPath) as? ImagePickerCell{
            if let asset = currentAlbum?.fetchResult.object(at: indexPath.item){
                cell.willDisplay(at: indexPath, for: convertToGPAsset(asset: asset))
            }

        }
    }
    


    func collectionView(_ collectionView: UICollectionView, didEndDisplaying cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        if let cell = collectionView.cellForItem(at: indexPath) as? ImagePickerCell{
            cell.cancelRequest(index:indexPath)
        }
    }
    
    
    func collectionView(_ collectionView: UICollectionView, shouldSelectItemAt indexPath: IndexPath) -> Bool {
        
        /*
         if mediaType is Video && configuration.limit == 1 && cell.asset.duration <= configuration.videoDuration
         
         */
       
        if selectedAssets.count > configuration.assetMaaxSelection {
            return false
        }
       // delegate?.onUserReachedMaxLimit(vc:self)
        return true
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        //create cell for indexpath
        if let cell = collectionView.cellForItem(at: indexPath) as? ImagePickerCell{
            //get asset from album at corresponding indexPath
           guard let asset = currentAlbum?.fetchResult.object(at: indexPath.item) else
            {
               return
           }
            //create GPAsset from asset
           let gpAsset = convertToGPAsset(asset: asset)
            //if multiple Asset is allowed then add asset as gpAsset in selected asset
            if isMultipleSelectionAllowed{
                cell.selectedCell()
                selectedAssets.append(gpAsset)
            }
            //else call delegate and pass asset and dismiss own vc and stop caching of images
            else{
                delegate?.onEndSingleSelection(asset: gpAsset, vc: self)
                GalleryManager.shared.stopCAchingForAllAssets()
                dismiss(animated: true)
            }
        }

    }
    
    func collectionView(_ collectionView: UICollectionView, didDeselectItemAt indexPath: IndexPath) {
        if let cell = collectionView.cellForItem(at: indexPath) as? ImagePickerCell{
            cell.deSelectedCell()
        }
    }
    
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = (collectionView.frame.width - 10) / 4
        return CGSize(width: width, height: width)
    }

    
}







//        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! ImagePickerCell
////        cell.onCellSelection(indexPath: indexPath)
//        print("Selected Dictonary",viewModel.selectedAssetsDict[indexPath.item])
        
//        if isMultipleSelectionAllowed {
//
//        }else{
//            let asset = currentAlbum?.fetchResult.object(at: indexPath.item)
//            selectedAssets = [convertToGPAsset(asset: asset!).iD:convertToGPAsset(asset: asset!)]
//            delegate?.onEndSingleSelection(asset: selectedAssets, vc: self)
//            self.dismiss(animated: true)
//        }
        
        //get asset at index
//        let asset = fetchAsset(at: indexPath.item)
//        //add asset in dictonary
//        viewModel.selectedAssetsDict = [asset.localIdentifier:asset]
//        print("selected asset",asset)
//
////        print("selected index ",indexPath)
//        let asset =
//        if isMultipleSelectionAllowed{
//
//            if let index = selectedAssets.firstIndex(of: asset) {
//                model.selectedImages.remove(at: index)
//            } else {
//                model.selectedImages.append(asset)
//            }
//            collectionView.reloadItems(at: [indexPath])
//        }else{
//            let asset = viewModel.allAssets[indexPath.row]
//            if let index = viewModel.selectedImages.firstIndex(of: asset) {
//                model.selectedImages.remove(at: index)
//            } else {
//                model.selectedImages.append(asset)
//            }
//            collectionView.reloadItems(at: [indexPath])
//            self.delegate?.onAddPhotos(assets: model.selectedImages)
//            self.dismiss(animated: true)
//
//        }
//
//        if (assetsPickerCollection!.allowsMultipleSelection){
//
//        }else{
//            if let asset =  currentAlbum?.fetchResult.object(at: indexPath.item){
//                selectedAssets.append(convertToGPAsset(asset:asset))
//                configuration.selectedAsset.append(asset)
//                print("asset",configuration.selectedAsset)
//                delegate?.onEndSingleSelection(asset:asset, vc: self)
//                self.dismiss(animated: true)
//            }
//        }
        
        
        
        
//

//
//  PhotoDataSource.swift
//  AddWatermark
//
//  Created by HKBeast on 20/04/23.
//

import UIKit
import Photos

class ImagePickerCell: UICollectionViewCell {
    
    var originalAsset:GPAsset?
    let imageView = UIImageView()
    let overlayView = UIView()
    var originalIndexPath:IndexPath = [0,0]
    //    let originalAssetId = 0
    let loader = UIActivityIndicatorView()
    var requestId : PHImageRequestID?
    override func awakeFromNib() {
        //imageView.image = nil
    }
    override init(frame: CGRect) {
        super.init(frame: frame)
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        loader.color = .white
        overlayView.backgroundColor = .green
        overlayView.alpha = 0.6
        overlayView.isHidden = true
        //        imageView.isUserInteractionEnabled = true
        //        loader.isUserInteractionEnabled = true
        contentView.addSubview(imageView)
        contentView.addSubview(loader)
        contentView.addSubview(overlayView)
        imageView.translatesAutoresizingMaskIntoConstraints = false
        loader.translatesAutoresizingMaskIntoConstraints = false
        overlayView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            imageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            imageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            imageView.topAnchor.constraint(equalTo: contentView.topAnchor),
            imageView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)
        ])
        //constarint for loader
        NSLayoutConstraint.activate([
            loader.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            loader.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            loader.topAnchor.constraint(equalTo: contentView.topAnchor),
            loader.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)
        ])
        //constaint for overlay
        NSLayoutConstraint.activate([
            overlayView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            overlayView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            overlayView.topAnchor.constraint(equalTo: contentView.topAnchor),
            overlayView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)
        ])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    
    //func to configure cell
    func configureCell(at indexPath:IndexPath,for asset:GPAsset){
       
        
        
    }
    
    func showLoader(){
     //   if imageView.image == nil {
            loader.isHidden = false
      //  }
    }
    
    func hideLoader(){
        loader.isHidden = true
    }
    
    
    func cancelRequest(index:IndexPath) {
        GalleryManager.shared.cancelFetching(index: index)
    }
    
//    func configure(at indexPath:IndexPath,for asset:GPAsset){
//        // show loader
//      //  showLoader()
////        self.imageView.image = nil
//        //store indexPath, and asset id in local variable to check
////        originalIndexPath = indexPath
////        originalAsset = asset
//        
//    }
    func configure(at indexPath:IndexPath,for asset:GPAsset){
//         show loader
        self.imageView.image = nil
        showLoader()
        
//        store indexPath, and asset id in local variable to check
        originalIndexPath = indexPath
        originalAsset = asset
        asset.fetchImage(with: indexPath) { image, error,index,localID in
            if index == self.originalIndexPath && localID == self.originalAsset!.iD{
                DispatchQueue.main.async {
                    self.hideLoader()
                    self.imageView.image = image
                }
            }
        }
    }
    func selectedCell(){
        overlayView.isHidden = false
        
    }
    func deSelectedCell(){
        overlayView.isHidden = true
//        self.isSelected = true
    }
    
}

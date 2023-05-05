//
//  CustomImagePicker.swift
//  AddWatermark
//
//  Created by HKBeast on 20/04/23.
//

import UIKit
import Photos

class CustomImagePickerViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {

    var images: [PHAsset] = []
    var selectedImages: [PHAsset] = []
    var cacheManager = CacheManager.shared

    override func viewDidLoad() {
        super.viewDidLoad()

        let collectionView = UICollectionView(frame: view.bounds, collectionViewLayout: UICollectionViewFlowLayout())
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(ImagePickerCell.self, forCellWithReuseIdentifier: "cell")
        view.addSubview(collectionView)

        fetchImages()
    }

    func fetchImages() {
        let allPhotosOptions = PHFetchOptions()
        allPhotosOptions.sortDescriptors = [NSSortDescriptor(key: "creationDate", ascending: false)]
        let allPhotos = PHAsset.fetchAssets(with: .image, options: allPhotosOptions)
        allPhotos.enumerateObjects({ (asset, count, stop) in
            self.images.append(asset)
        })
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return images.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! ImagePickerCell
        let asset = images[indexPath.row]
        cell.representedAssetIdentifier = asset.localIdentifier
        cacheManager.requestImage(for: asset, targetSize: CGSize(width: 200, height: 200), contentMode: .aspectFill) { (image, _) in
            if cell.representedAssetIdentifier == asset.localIdentifier {
                cell.imageView.image = image
            }
        }
        if selectedImages.contains(asset) {
            cell.imageView.alpha = 0.5
        } else {
            cell.imageView.alpha = 1.0
        }
        return cell
    }

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let asset = images[indexPath.row]
        if let index = selectedImages.firstIndex(of: asset) {
            selectedImages.remove(at: index)
        } else {
            selectedImages.append(asset)
        }
        collectionView.reloadItems(at: [indexPath])
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = (collectionView.frame.width - 3) / 4
        return CGSize(width: width, height: width)
    }

}

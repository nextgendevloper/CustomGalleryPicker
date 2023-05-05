//
//  CacheManager.swift
//  AddWatermark
//
//  Created by HKBeast on 20/04/23.
//


import Foundation
import UIKit
import Photos

class CacheManager {
    
    static let shared = CacheManager()
    
    private let cache = NSCache<NSString, UIImage>()
    
    private init() {}

        func requestImage(for asset: PHAsset, targetSize: CGSize, contentMode: PHImageContentMode, completion: @escaping (UIImage?, [AnyHashable : Any]?) -> Void) {
            let options = PHImageRequestOptions()
            options.isSynchronous = false
            options.deliveryMode = .highQualityFormat
            options.resizeMode = .exact
            PHImageManager.default().requestImage(for: asset, targetSize: targetSize, contentMode: contentMode, options: options) { (image, info) in
                guard let image = image else { return }
                self.cache.setObject(image, forKey: asset.localIdentifier as NSString)
                completion(image, info)
            }
        }

        func getCachedImage(for asset: PHAsset) -> UIImage? {
            return cache.object(forKey: asset.localIdentifier as NSString)
        }

}



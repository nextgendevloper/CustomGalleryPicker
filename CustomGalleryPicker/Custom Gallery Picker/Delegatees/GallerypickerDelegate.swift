//
//  GallerypickerDelegate.swift
//  CustomGalleryPicker
//
//  Created by HKBeast on 02/05/23.
//

import Foundation
import Photos

protocol IOSGalleryPickerDelegate{
    func onAddPhotos( assets:[PHAsset],vc:IOSGalleryPickerViewController)
    func onReachVideoDureation(asset:PHAsset,vc:IOSGalleryPickerViewController )
    func onMaximumSelectionLimit(assets:[PHAsset],vc:IOSGalleryPickerViewController )
    func onEndMultipleSelection(assets:[GPAsset],vc:IOSGalleryPickerViewController)
    func onEndSingleSelection(asset:GPAsset,vc:IOSGalleryPickerViewController)
    func onCancel(vc:IOSGalleryPickerViewController)
}

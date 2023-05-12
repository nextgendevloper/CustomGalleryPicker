//
//  AlbumViewVM.swift
//  CustomGalleryPicker
//
//  Created by HKBeast on 01/05/23.
//

import Foundation
import UIKit
import Photos


class AlbumViewVM{
    
    var albumlist = [PHAssetCollection]()
    
    init(){
       
        albumlist = fetchAlbums()
    }
    // create function to get count of albumList
    func getAlbumListCount()->Int{
        return albumlist.count
    }
    // create function to get assets of album
    func getAssetsfor(at indexPath:IndexPath)->[PHAsset]{
        fetchAssetsFromAlbum(album: albumlist[indexPath.item])
    }
    // create function to get thumbnail of album
    
//    func getThumbNails(at indexPath:IndexPath)->UIImage{
//        let asset = fetchThumbnails(for: <#T##[NSFileProviderItemIdentifier]#>, requestedSize: <#T##CGSize#>, perThumbnailCompletionHandler: <#T##(NSFileProviderItemIdentifier, Data?, Error?) -> Void#>, completionHandler: <#T##(Error?) -> Void#>)
//    }
    // crearte function to get List of Album
    func getNameOfAlbum(at indexPath:IndexPath)->String{
        let name = albumlist[indexPath.item].localizedTitle ?? " "
        return name
    }
}

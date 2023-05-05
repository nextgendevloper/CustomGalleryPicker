//
//  Fetch.swift
//  CustomGalleryPicker
//
//  Created by HKBeast on 03/05/23.
//

import Foundation
import UIKit
import Photos

class GalleryFetchService{
    // hashTable : [indexpath, PHRequestId]
    var hashTable = [IndexPath:PHImageRequestID]()

    // cancel Fetching ( indexpath )
    // if id available , rmove from table , log cancelled
    func cancelFetching(indexPath:IndexPath)->PHImageRequestID?{
        if let id = hashTable[indexPath] {
            hashTable.removeValue(forKey: indexPath)
            print("cancel item : ",id)
            return id
        }
        return nil
    }

    // registerFetching(id , indecpath )
    // add id at path in table // registered
    func registerFetching(id:PHImageRequestID,indexPath:IndexPath){
//        let dic = [indexPath:id]
        hashTable[indexPath] = id
        
    }

    // removeFetching(indexpath)
    // if id available , rmove from table // log finshied
    //

    func completeFetching(indexPath:IndexPath){
        if let id = hashTable[indexPath] {
            hashTable.removeValue(forKey: indexPath)
            print("remove item : ",id)
        }
    }
    
    // isFetching(inedexpath) {
    // return if table has id at indexpath
    func isFetching(indexPath:IndexPath)->Bool{
        if let id = hashTable[indexPath]{
            print("fetching item : ",id)
            return true
        }
        return false
    }
}

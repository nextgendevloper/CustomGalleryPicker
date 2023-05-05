//
//  CollectionViewCell.swift
//  CustomGalleryPicker
//
//  Created by HKBeast on 01/05/23.
//

import UIKit

class AlbumCVCell: UICollectionViewCell {

    @IBOutlet weak var imageView:UIImageView!
    @IBOutlet weak var albumNameLabel:UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    func config(album:GPAlbum,indexPath:IndexPath){
        albumNameLabel.text = album.title
    }
}

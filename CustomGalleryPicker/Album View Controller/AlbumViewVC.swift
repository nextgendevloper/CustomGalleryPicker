//
//  AlbumViewVC.swift
//  CustomGalleryPicker
//
//  Created by HKBeast on 01/05/23.
//

import UIKit

class AlbumViewVC: UIViewController {
    //MARK: - *** Outlet  ****
    @IBOutlet weak var CollectionViewPlaceholder:UIView!
    @IBOutlet weak var tapView:UIView!
    
    //MARK: - *** Variables  ****
    let viewModel = AlbumViewVM()
    var delegate:AlbumPickerDelegate
    var albumList = [GPAlbum](){
        didSet{
            collectioView.reloadData()
        }
    }
    
    var selectedAlbum : GPAlbum?

    init(delegate:AlbumPickerDelegate){
        self.delegate = delegate
        super.init(nibName: "AlbumViewVC", bundle: nil)
       
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - *** Lazy Variables  ****
    lazy  var collectioView : UICollectionView = {
//        let layout = UICollectionViewLayout()
        
        let collectionView = UICollectionView(frame: CollectionViewPlaceholder.bounds, collectionViewLayout: UICollectionViewFlowLayout())
        collectionView.isUserInteractionEnabled
        collectionView.delegate = self
        collectionView.dataSource = self
        let nib = UINib(nibName: "AlbumCVCell", bundle: .main)
        collectionView.register(nib, forCellWithReuseIdentifier: "cell")
        return collectionView
    }()
    
    
        //MARK: - *** Life Cycle  ****
    override func viewDidLoad() {
        super.viewDidLoad()
//        GalleryManager.shared.onAlbumLoaded = { [self] bool in
            albumList = GalleryManager.shared.albumList
//            selectedAlbum = GalleryManager.shared.albumList.first!
            addCVPlaceholder()
//            print ("hello")
//        }
//        GalleryManager.shared.loadAlbum()
    
        addTapView()
       
        
        
    }
    
    
    //MARK: - *** Private Methods  ****
    
    //add tap View on view
    func addTapView(){
        let tap = UITapGestureRecognizer(target: self, action: #selector(handleTap))
        tap.delegate = self
        self.tapView.addGestureRecognizer(tap)
    }
    
    @objc func handleTap(){
        self.dismiss(animated: true)
    }
    
   // add Placeholder for collectionView
    func addCVPlaceholder(){
        collectioView.backgroundColor = .red
        view.addSubview(collectioView)
        collectioView.translatesAutoresizingMaskIntoConstraints = false
            // add contratint for placeholder
        NSLayoutConstraint.activate([
            collectioView.leadingAnchor.constraint(equalTo: CollectionViewPlaceholder.leadingAnchor),
            collectioView.trailingAnchor.constraint(equalTo: CollectionViewPlaceholder.trailingAnchor),
            collectioView.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.4),
            collectioView.bottomAnchor.constraint(equalTo: CollectionViewPlaceholder.bottomAnchor)
        ])
    }
    
    
    
    
}
//MARK: - *** Extension CollectionView Delegate  ****

extension AlbumViewVC:UIGestureRecognizerDelegate, UICollectionViewDelegate, UICollectionViewDataSource,UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return albumList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! AlbumCVCell
        cell.config(album: albumList[indexPath.item], indexPath: indexPath)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        if let cell = collectionView.cellForItem(at: indexPath) as? AlbumCVCell {
            cell.config(album: albumList[indexPath.item], indexPath: indexPath)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
//        if GalleryManager.shared.configuration > {1
        let selectedAlbum = albumList[indexPath.item]
        delegate.onSelectAlbum(selectedAlbum)
        self.dismiss(animated: true)
//        print("AlbumName : \(  )" , viewModel.getAssetsfor(at: indexPath).count)
    }
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 100, height: 120)
    }
    
}

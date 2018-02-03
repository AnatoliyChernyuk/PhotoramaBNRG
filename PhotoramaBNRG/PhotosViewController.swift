//
//  ViewController.swift
//  PhotoramaBNRG
//
//  Created by Anatoliy Chernyuk on 1/28/18.
//  Copyright © 2018 Anatoliy Chernyuk. All rights reserved.
//

import UIKit

class PhotosViewController: UIViewController, UICollectionViewDelegate {
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    var store: PhotoStore!
    let photoDatasource = PhotoDataSource()

    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.dataSource = photoDatasource
        collectionView.delegate = self
        store.fetchInterstingPhotos {
            (photosResult) -> Void in
            switch photosResult {
            case let .success(photos):
                print("Successfully found \(photos.count) photos")
                self.photoDatasource.photos = photos
            case let .failure(error):
                print("Error fetching interesting photos \(error)")
                self.photoDatasource.photos.removeAll()
            }
            self.collectionView.reloadSections(IndexSet(integer: 0))
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        let photo = photoDatasource.photos[indexPath.row]
        
        //Download the image data which, could take some time
        store.fetchImage(for: photo) {
            (result) -> Void in
            //The index path for the photo might have changed between the time the request started and finished, so find the most recent index path
            guard let photoIndex = self.photoDatasource.photos.index(of: photo), case let .success(image) = result else {
                return
            }
            let photoIndexPath = IndexPath(item: photoIndex, section: 0)
            
            //When request finishes, only update the cell if it's still visible
            if let cell = self.collectionView.cellForItem(at: photoIndexPath) as? PhotoCollectionViewCell {
                cell.update(with: image)
            }
        }
    }
}
















































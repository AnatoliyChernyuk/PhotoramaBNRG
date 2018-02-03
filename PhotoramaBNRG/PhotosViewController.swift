//
//  ViewController.swift
//  PhotoramaBNRG
//
//  Created by Anatoliy Chernyuk on 1/28/18.
//  Copyright © 2018 Anatoliy Chernyuk. All rights reserved.
//

import UIKit

class PhotosViewController: UIViewController {
    
    @IBOutlet weak var imageView: UIImageView!
    
    //Chapter 20 Silver Challenge
    @IBOutlet weak var photoSwitch: UISegmentedControl!
    
    var store: PhotoStore!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        loadPhotos()
        photoSwitch.addTarget(self, action: #selector(loadPhotos), for: .valueChanged)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func updateImageView(for photo: Photo) {
        store.fetchImage(for: photo) {
            (imageResult) -> Void in
            switch imageResult {
            case let .success(image):
                self.imageView.image = image
            case let .failure(error):
                print("Error downloading an image: \(error)")
            }
        }
    }
    
    //Chapter 20 Silver Challenge
    @objc private func loadPhotos() {
        let photoType: PhotoType
        switch photoSwitch.selectedSegmentIndex {
        case 0:
            photoType = .interesting
            print("$$$$$$$ Interesting $$$$$$$")
        case 1:
            photoType = .recent
            print("@@@@@@@ Recent @@@@@@@")
        default:
            preconditionFailure("Code must not get here - uselected photo type")
        }
        
        store.fetchPhotos(of: photoType) {
            (photosResult) -> Void in
            switch photosResult {
            case let .success(photos):
                print("Successfully found \(photos.count) photos")
                if let firstPhoto = photos.first {
                    self.updateImageView(for: firstPhoto)
                }
            case let .failure(error):
                print("Error fetching interesting photos \(error)")
            }
        }
    }
}
















































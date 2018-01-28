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
    var store: PhotoStore!

    override func viewDidLoad() {
        super.viewDidLoad()
        store.fetchInterstingPhotos()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}


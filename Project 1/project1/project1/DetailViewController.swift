//
//  DetailViewController.swift
//  project1
//
//  Created by Alexander Thompson on 19/1/21.
//

import UIKit

class DetailViewController: UIViewController {
    
    var pictureNumber = 0
    var totalPictures = 0
    
    @IBOutlet var imageView: UIImageView!
    var selectedImage: String?
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.largeTitleDisplayMode = .never
        title = "Picture \(pictureNumber) of \(totalPictures)"
        if let imageToLoad = selectedImage {
            imageView.image = UIImage(named: imageToLoad)
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.hidesBarsOnTap = true
    }
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.hidesBarsOnTap = false
        
    }
}

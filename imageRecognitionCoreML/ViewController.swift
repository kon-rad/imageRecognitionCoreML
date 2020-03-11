//
//  ViewController.swift
//  imageRecognitionCoreML
//
//  Created by Konrad Gnat on 3/10/20.
//  Copyright © 2020 Konrad Gnat. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var pictureImageView :UIImageView!
    @IBOutlet weak var titleLabel :UILabel!
    
    let images = ["cat.jpg", "dog.jpg", "banana.jpg", "lion.jpg"]
    var index = 0;

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    @IBAction func nextButtonPressed() {
        
        if index > self.images.count - 1 {
            index = 0
        }
        let img = UIImage(named: images[index])
        self.pictureImageView.image = img
        index = index + 1;
    }


}


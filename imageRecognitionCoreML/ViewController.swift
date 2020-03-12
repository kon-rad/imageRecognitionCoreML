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
    
    private var model :Inceptionv3 = Inceptionv3()
    
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
        
        let resizedImage = img?.resizeTo(size: CGSize(width: 299, height: 299))
        
        let buffer = resizedImage?.toBuffer()
        
        let prediction = try! self.model.prediction(image: buffer!)
        
        self.titleLabel.text = prediction.classLabel
        
        index = index + 1;
    }


}


//
//  ViewController.swift
//  imageRecognitionCoreML
//
//  Created by Konrad Gnat on 3/10/20.
//  Copyright © 2020 Konrad Gnat. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    @IBOutlet weak var pictureImageView :UIImageView!
    @IBOutlet weak var titleLabel :UILabel!
    
    private var model :Inceptionv3 = Inceptionv3()
    
    let images = ["cat.jpg", "dog.jpg", "banana.jpg", "lion.jpg"]
    var index = 0;

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    @IBAction func chooseImagePressed(sender: Any) {
        
        let imagePickerController = UIImagePickerController()
        print("chooseImagePressed!")
        
        
        let actionSheet = UIAlertController(title: "Photo source", message: "Choose a source", preferredStyle: .actionSheet)
        
        actionSheet.addAction(UIAlertAction(title: "Camera", style: .default, handler: { (action: UIAlertAction) in
            
            if UIImagePickerController.isSourceTypeAvailable(.camera) {
                imagePickerController.sourceType = .camera
//                self.present(imagePickerController, animated: true, completion: nil)
                self.getImage(fromSourceType: .camera)
                print("camera is picked!")
            } else {
                print("Camera not available!")
            }
            
        }))
        
        actionSheet.addAction(UIAlertAction(title: "Photo Library", style: .default, handler: { (action: UIAlertAction) in
        imagePickerController.sourceType = .photoLibrary
//            self.present(imagePickerController, animated: true, completion: nil)
            self.getImage(fromSourceType: .photoLibrary)
            print("inside picker")
        }))
        
        actionSheet.addAction(UIAlertAction(title: "Cancel", style: .default, handler: nil))
        
        self.present(actionSheet, animated: true, completion: nil)
    }

    // this handles what happens after taking a photo
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        print("imagePickerController has run!!")
        
        let image = info[UIImagePickerController.InfoKey.originalImage] as! UIImage
        self.pictureImageView.image = image
        self.runImageRecognition(image: image)
        
        picker.dismiss(animated: true, completion: nil)
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true, completion: nil)
    }
    
    func runImageRecognition(image :UIImage) {
        
        let resizedImage = image.resizeTo(size: CGSize(width: 299, height: 299))

        let buffer = resizedImage.toBuffer()

        let prediction = try! self.model.prediction(image: buffer!)

        self.titleLabel.text = prediction.classLabel
    }

    //get image from source type
    func getImage(fromSourceType sourceType: UIImagePickerController.SourceType) {
        print("inside getImage");

        //Check is source type available
        if UIImagePickerController.isSourceTypeAvailable(sourceType) {

            let imagePickerController = UIImagePickerController()
            imagePickerController.delegate = self
            imagePickerController.sourceType = sourceType
            self.present(imagePickerController, animated: true, completion: nil)
        }
    }
}


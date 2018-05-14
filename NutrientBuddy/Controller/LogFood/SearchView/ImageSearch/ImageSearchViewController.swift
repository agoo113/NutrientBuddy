//
//  ImageSearchViewController.swift
//  NutrientBuddy
//
//  Created by Gemma Jing on 26/02/2018.
//  Copyright © 2018 Gemma Jing. All rights reserved.
//

import UIKit

class ImageSearchViewController: UIViewController,     UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    @IBOutlet weak var imagePicked: UIImageView!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    @IBAction func openCameraButtonTapped(sender: AnyObject) {
        if UIImagePickerController.isSourceTypeAvailable(.camera) {
            let imagePicker = UIImagePickerController()
            imagePicker.delegate = self
            imagePicker.sourceType = .camera
            imagePicker.allowsEditing = false
            self.present(imagePicker, animated: true, completion: nil)
        }
    }
    
    @IBAction func openPhotoLibraryButtonTapped(sender: AnyObject) {
        if UIImagePickerController.isSourceTypeAvailable(.photoLibrary) {
            let imagePicker = UIImagePickerController()
            imagePicker.delegate = self
            imagePicker.sourceType = .photoLibrary;
            imagePicker.allowsEditing = true
            self.present(imagePicker, animated: true, completion: nil)
        }
    }
    

    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        let image = info[UIImagePickerControllerOriginalImage] as! UIImage
        imagePicked.image = image
        dismiss(animated:true, completion: nil)
    }
    
    @IBAction func saveItemTapped(sender: AnyObject) {
        let imageData = UIImageJPEGRepresentation(imagePicked.image!, 0.6)
        let compressedJPGImage = UIImage(data: imageData!)
       
        let alert = UIAlertController(title: "Nutrient Buddy", message: "Your image has been saved to Photo Library!", preferredStyle: .alert)
        let actionOK = UIAlertAction(title: "OK", style: .default) { (_) in
            UIImageWriteToSavedPhotosAlbum(compressedJPGImage!, nil, nil, nil)
            self.navigationController?.popToRootViewController(animated: true)
        }
        let actionCancel = UIAlertAction(title: "Cancel", style: .cancel) { (_) in
            self.navigationController?.popToRootViewController(animated: true)
        }
        alert.addAction(actionCancel)
        alert.addAction(actionOK)
        present(alert, animated: true, completion: nil)
    }
    
    @IBAction func SearchButtonTapped(sender: AnyObject) {
        let alert = UIAlertController(title: "Nutrient Buddy", message: "Sorry, this function is coming soon...", preferredStyle: .alert)
        let action = UIAlertAction(title: "OK", style: .cancel)
        alert.addAction(action)
        present(alert, animated: true, completion: nil)
    }

}

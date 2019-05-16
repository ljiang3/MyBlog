//
//  PhotoViewController.swift
//  MyBlog
//
//  Created by Liyao Jiang on 5/13/19.
//  Copyright © 2019 Liyao Jiang. All rights reserved.
//

import UIKit

class PhotoViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    var imagePicker = UIImagePickerController()
    var resizedPhoto: UIImageView!
    var alertController = UIAlertController()
    
    
    @IBOutlet weak var previewImage: UIImageView!
    @IBOutlet weak var caption: UITextField!
    
    @IBAction func shareAction(_ sender: Any) {
        PostImage.postUserImage(image: previewImage.image, withCaption: caption.text, withCompletion: ({ (success, error) in
            if (success) {
                self.alertController = UIAlertController(title: "Success", message: "Image Successfully Uploaded", preferredStyle: .alert)
                let cancelAction = UIAlertAction(title: "Ok", style: .cancel) { (action) in
                    
                    // handle cancel response here. Doing nothing will dismiss the view.
                    // Go back to home page.
                    let homePage = self.storyboard?.instantiateViewController(withIdentifier: "HomeTabBarController")
                    let appDelegate = UIApplication.shared.delegate
                    appDelegate?.window??.rootViewController = homePage
                }
                self.alertController.addAction(cancelAction)
                DispatchQueue.global().async(execute: {
                    DispatchQueue.main.sync{
                        self.present(self.alertController, animated: true, completion: nil)
                        
                    }
                })
            } else {
                // There was a problem, check error.description
                self.alertController = UIAlertController(title: "Error", message: "\(String(describing: error?.localizedDescription))", preferredStyle: .alert)
                let cancelAction = UIAlertAction(title: "Ok", style: .cancel) { (action) in
                    // handle cancel response here. Doing nothing will dismiss the view.
                }
                self.alertController.addAction(cancelAction)
                DispatchQueue.global().async(execute: {
                    DispatchQueue.main.sync{
                        self.present(self.alertController, animated: true, completion: nil)
                        
                    }
                })
            }
        }))
    }
    
    @IBAction func takePicture(_ sender: Any) {
        if UIImagePickerController.isSourceTypeAvailable(.camera) {
            print("Camera is available 📸")
            imagePicker.sourceType = .camera
        } else {
            print("Camera 🚫 available so we will use photo library instead")
            imagePicker.sourceType = .photoLibrary
        }
        imagePicker.allowsEditing = true
        self.present(imagePicker, animated: true, completion: nil)
    }
    
    
    @IBAction func chooseFromLibrary(_ sender: Any) {
        imagePicker.sourceType = UIImagePickerController.SourceType.photoLibrary
        imagePicker.allowsEditing = true
        self.present(imagePicker, animated: true, completion: nil)
    }
    
    
    @IBAction func addLocation(_ sender: Any) {
    }
    
    func imagePickerController(_ picker: UIImagePickerController,
                               didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        //Parse has a limit of 10MB for uploading photos so you'll want to the code snippet below to resize the image before uploading to Parse.
        previewImage.image = info[(UIImagePickerController.InfoKey.editedImage)] as! UIImage?
        
        // Dismiss UIImagePickerController to go back to your original view controller
        dismiss(animated: true, completion: nil)
    }
    
     func resize(image: UIImage, newSize: CGSize) -> UIImage {
        let resizeImageView = UIImageView(frame: CGRect(x: 0, y: 0, width: newSize.width, height: newSize.height))
        _ = UIImageView(frame: CGRect(x: 0, y: 0, width: newSize.width, height: newSize.height))
        resizeImageView.contentMode = UIView.ContentMode.scaleAspectFill
        resizeImageView.image = image
     
        UIGraphicsBeginImageContext(resizeImageView.frame.size)
        resizeImageView.layer.render(in: UIGraphicsGetCurrentContext()!)
        let newImage = UIGraphicsGetImageFromCurrentImageContext()!
        UIGraphicsEndImageContext()
        return newImage
     }
 
//    override func viewWillAppear(_ animated: Bool) {
//        super.viewWillDisappear(animated)
//        self.navigationController?.navigationBar.isHidden = false
//
//    }
//
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        imagePicker.delegate = self
        imagePicker.allowsEditing = true
    }
}

//
//  ImagePickerHandler.swift
//  CountryInfo
//
//  Created by vako on 28.04.24.
//

import UIKit

class ImagePickerHandler: NSObject, UIImagePickerControllerDelegate & UINavigationControllerDelegate {
    
    var viewController: UIViewController
    
    init(viewController: UIViewController) {
        self.viewController = viewController
    }
    
    func showImagePickerController() {
        let imagePicker = UIImagePickerController()
        imagePicker.delegate = self
        imagePicker.allowsEditing = true
        viewController.present(imagePicker, animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let pickedImage = info[UIImagePickerController.InfoKey.editedImage] as? UIImage,
           let viewController = viewController as? LoginPageViewController {
            viewController.imageView.setImage(pickedImage, for: .normal)
            // Save image to Documents directory
            if let data = pickedImage.jpegData(compressionQuality: 0.8),
               let url = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first?.appendingPathComponent("profileImage.jpg") {
                try? data.write(to: url)
            }
        }
        picker.dismiss(animated: true, completion: nil)
    }
}

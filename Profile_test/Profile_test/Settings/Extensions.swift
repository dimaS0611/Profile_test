//
//  Extension.swift
//  Profile_test
//
//  Created by Dzmitry Semenovich on 28.06.21.
//

import Foundation
import UIKit

extension SettingsViewController: UIImagePickerControllerDelegate {
    
    func chooseImage() {
        let actionSheet = UIAlertController(title: "Photo Source", message: "Choose a source", preferredStyle: .actionSheet)
        
        actionSheet.addAction(UIAlertAction(title: "Camera", style: .default, handler: { (action: UIAlertAction) in
            guard UIImagePickerController.isSourceTypeAvailable(.camera) else {
                
                self.showAlertWith(title: "Camera doesn't exist", message: "")
                return
            }
            self.imagePicker.sourceType = .camera
            self.present(self.imagePicker, animated: true, completion: nil)
        }))
        
        actionSheet.addAction(UIAlertAction(title: "Photo Library", style: .default, handler: { (action: UIAlertAction) in
            self.imagePicker.sourceType = .photoLibrary
            self.present(self.imagePicker, animated: true, completion: nil)
        }))
        
        actionSheet.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        
        self.present(actionSheet, animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        guard let selectedImage = info[.originalImage] as? UIImage  else {
            print("Image not found!")
            return
        }
        
        accountImage.image = selectedImage
        
        imagePicker.dismiss(animated: true, completion: nil)
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true, completion: nil)
    }
    
    func checkData() -> Bool {
        if self.accountName.text == "" {
            self.showAlertWith(title: "The name cannot be empty", message: "")
            return false
        }
        
        if self.accountHeight.text == "" {
            self.showAlertWith(title: "The height cannot be empty", message: "")
            return false
        }
        
        if self.accountDBirth.date > Date() {
            self.showAlertWith(title: "The date is greater than the current", message: "")
            return false
        }
        
        if self.accountDBirth.date < dateFormatter.date(from: "Jan 01, 1900")! {
            self.showAlertWith(title: "the date cannot be less than 01.01.1900", message: "")
            return false
        }
        
        return true
    }
    
    func showAlertWith(title: String, message: String){
        let ac = UIAlertController(title: title, message: message, preferredStyle: .alert)
        ac.addAction(UIAlertAction(title: "OK", style: .default))
        present(ac, animated: true)
    }
}

extension UIViewController {
    func hideKeyboardWhenTappedAround() {
        let tap = UITapGestureRecognizer(target: self, action: #selector(UIViewController.dismissKeyboard))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }
    
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
}

//
//  SettingsViewController.swift
//  Profile_test
//
//  Created by Dzmitry Semenovich on 27.06.21.
//

import UIKit

class SettingsViewController: UIViewController, UINavigationControllerDelegate {

    @IBOutlet weak var accountImage: UIImageView!
    @IBOutlet weak var accountName: UITextField!
    @IBOutlet weak var accountDBirth: UITextField!
    @IBOutlet weak var accountHeight: UITextField!
    @IBOutlet weak var accountBio: UITextField!
    
    var imagePicker: UIImagePickerController!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        imagePicker = UIImagePickerController()
        imagePicker.delegate = self
        
    }
    @IBAction func takeImage(_ sender: Any) {
        chooseImage()
    }
    
    func showAlertWith(title: String, message: String){
        let ac = UIAlertController(title: title, message: message, preferredStyle: .alert)
        ac.addAction(UIAlertAction(title: "OK", style: .default))
        present(ac, animated: true)
    }
}

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
    
}

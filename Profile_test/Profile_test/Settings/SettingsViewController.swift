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
    @IBOutlet weak var accountDBirth: UIDatePicker!
    @IBOutlet weak var accountHeight: UITextField!
    @IBOutlet weak var accountBio: UITextField?
    
    let dateFormatter = DateFormatter()
    
    let save = StoreData()
    
    var imagePicker: UIImagePickerController!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        imagePicker = UIImagePickerController()
        imagePicker.delegate = self
        
        dateFormatter.dateFormat = "MMM d, yyyy"
        
    }
    @IBAction func takeImage(_ sender: Any) {
        chooseImage()
    }
    
    @IBAction func save(_ sender: Any) {
        
        if checkData() {
            let name = self.accountName.text!
            let dbirth = dateFormatter.string(from: self.accountDBirth.date)
            let height = self.accountHeight.text! + "cm"
            let bio = (self.accountBio?.text)!
            let image = self.accountImage.image
            
            save.saveData(name, dbirth, height, bio, ((image ?? UIImage(named: "camera"))!))
        }
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

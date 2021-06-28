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
    
    var imagePicker: UIImagePickerController!
    
    let dateFormatter = DateFormatter()
    let save = StoreData()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        imagePicker = UIImagePickerController()
        imagePicker.delegate = self
        
        dateFormatter.dateFormat = "MMM d, yyyy"
        
        self.hideKeyboardWhenTappedAround()
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
            
            showAlertWith(title: "Data has succesfully saved!", message: "")
        }
    }
}

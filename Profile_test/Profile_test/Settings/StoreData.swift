//
//  StoreData.swift
//  Profile_test
//
//  Created by Dzmitry Semenovich on 28.06.21.
//

import Foundation
import UIKit
import CoreData

class StoreData {
    
    let appDelegate: AppDelegate
    let context: NSManagedObjectContext
    let entity: NSEntityDescription?
    
    init() {
        appDelegate = UIApplication.shared.delegate as! AppDelegate
        context = appDelegate.persistentContainer.viewContext
        entity = NSEntityDescription.entity(forEntityName: "Profile", in: context) ?? nil
    }
    
    func saveData(_ name: String, _ dbirth: String, _ height: String, _ bio: String, _ image: UIImage) {
        let userData = NSManagedObject(entity: entity!, insertInto: context)
        
        userData.setValue(name, forKey: "name")
        userData.setValue(dbirth, forKey: "dbirth")
        userData.setValue(height, forKey: "height")
        userData.setValue(bio, forKey: "bio")
        
        let imageInstance = Profile(context: context)
        imageInstance.image = image.pngData()
        
        do {
            try context.save()
        } catch {
            print(error.localizedDescription)
        }
    }
}

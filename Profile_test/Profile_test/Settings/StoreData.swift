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

    let fetchRequest: NSFetchRequest<NSFetchRequestResult>

    
    init() {
        appDelegate = UIApplication.shared.delegate as! AppDelegate
        context = appDelegate.persistentContainer.viewContext
        entity = NSEntityDescription.entity(forEntityName: "Profile", in: context) ?? nil

        fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Profile")
    }
    
    func saveData(_ name: String, _ dbirth: String, _ height: String, _ bio: String, _ image: UIImage) {
        
        do {
            let userData = try context.fetch(fetchRequest) as? [NSManagedObject]
            userData?[0].setValue(name, forKey: "name")
            userData?[0].setValue(dbirth, forKey: "dbirth")
            userData?[0].setValue(height, forKey: "height")
            userData?[0].setValue(bio, forKey: "bio")
            userData?[0].setValue(image.jpegData(compressionQuality: 1.0), forKey: "image")
            
        } catch {
            print(error.localizedDescription)
        }

    }
    
    func getCoreDataDBPath() {
            let path = FileManager
                .default
                .urls(for: .applicationSupportDirectory, in: .userDomainMask)
                .last?
                .absoluteString
                .replacingOccurrences(of: "file://", with: "")
                .removingPercentEncoding

            print("Core Data DB Path :: \(path ?? "Not found")")
        }

}

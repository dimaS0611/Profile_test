//
//  FetchData.swift
//  Profile_test
//
//  Created by Dzmitry Semenovich on 28.06.21.
//

import Foundation
import UIKit
import CoreData

class FetchData {
    let appDelegate: AppDelegate
    let context: NSManagedObjectContext
    let entity: NSEntityDescription?
    let request: NSFetchRequest<NSFetchRequestResult>
    
    init() {
        appDelegate = UIApplication.shared.delegate as! AppDelegate
        context = appDelegate.persistentContainer.viewContext
        entity = NSEntityDescription.entity(forEntityName: "Profile", in: context) ?? nil
        request = NSFetchRequest<NSFetchRequestResult>(entityName: "Profile")
    }
    
    func fetchData() -> ProfileData? {
        do {
            let result = try context.fetch(request)
            
            let data = result as! [NSManagedObject]
            
            if data.count != 0 {
                let name = data[0].value(forKey: "name") as! String
                let dbirth = data[0].value(forKey: "dbirth") as! String
                let height = data[0].value(forKey: "height") as! String
                let bio = data[0].value(forKey: "bio") as? String
                let image = UIImage(data: (data[0].value(forKey: "image") as! Data))
                
                return ProfileData(name: name, dbirth: dbirth, height: height, bio: bio, image: ((image ?? UIImage(named: "camera"))!))
            } else {
                return ProfileData(name: "John Appleseed", dbirth: "01 Jan, 2000", height: "183cm", bio: "Hello,I’m John!", image: UIImage(named: "camera")!)
            }
            
        } catch {
            print(error.localizedDescription)
        }
        
        return nil
    }
}

struct ProfileData {
    var name: String
    var dbirth: String
    var height: String
    var bio: String?
    let image: UIImage
}



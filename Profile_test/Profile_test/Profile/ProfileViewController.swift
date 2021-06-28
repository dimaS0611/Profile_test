//
//  ProfileViewController.swift
//  Profile_test
//
//  Created by Dzmitry Semenovich on 27.06.21.
//

import UIKit

class ProfileViewController: UIViewController {

    let fetch = FetchData()
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var dbirth: UILabel!
    @IBOutlet weak var height: UILabel!
    @IBOutlet weak var bio: UILabel?
    @IBOutlet weak var image: UIImageView?
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    override func viewWillAppear(_ animated: Bool) {
        let profile = fetch.fetchData()
        
        self.name.text = profile?.name
        self.dbirth.text = profile?.dbirth
        self.height.text = profile?.height
        self.bio?.text = profile?.bio
        
        self.image?.image = profile?.image
    }
    
    func showAlertWith(title: String, message: String){
        let ac = UIAlertController(title: title, message: message, preferredStyle: .alert)
        ac.addAction(UIAlertAction(title: "OK", style: .default))
        present(ac, animated: true)
    }
}


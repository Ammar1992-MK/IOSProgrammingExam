//
//  UpdateSeedViewController.swift
//  RandomUser
//
//  Created by Ammar Khalil on 16/11/2021.
//

import UIKit

class UpdateSeedViewController: UIViewController {

    @IBOutlet weak var newSeedTextField: UITextField!
    
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext

    var seedManager = SeedManager()
    var userManager = UserManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    

    @IBAction func saveSeedPressed(_ sender: UIButton) {
        
        seedManager.UpdateSeed(newSeed: newSeedTextField.text!)
        //userManager.fetchUserData()
    }
 
}

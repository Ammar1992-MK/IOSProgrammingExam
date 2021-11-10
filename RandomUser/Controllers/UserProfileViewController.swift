//
//  UserProfileViewController.swift
//  RandomUser
//
//  Created by Ammar Khalil on 02/11/2021.
//

import UIKit

class UserProfileViewController: UIViewController {
   
    

    
    @IBOutlet weak var profileImage: UIImageView?
    
    @IBOutlet weak var nameLabel: UILabel!
    
    @IBOutlet weak var emailLabel: UILabel!
    
    @IBOutlet weak var ageLabel: UILabel!
    @IBOutlet weak var dateOfBirthLabel: UILabel!
    
    @IBOutlet weak var cityLabel: UILabel!
    @IBOutlet weak var stateLabel: UILabel!
    
    
    
    var user : User! = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        DispatchQueue.main.async {  
            let url = URL(string: (self.user?.picture.large)!)
            if let data = try? Data(contentsOf: url!)
            {
                self.profileImage?.image = UIImage(data: data)!
                
            }
        }
        
        nameLabel.text = ("\(user?.name.first ?? "default value") \(user?.name.last ?? "no last name") ")
        emailLabel.text = user?.email
       // ageLabel.text = String(user?.dob.age)
        dateOfBirthLabel.text = user?.dob.date
        cityLabel.text = user?.location.city
        stateLabel.text = user?.location.state
        
        
        
        
        }
    
    
    

        @IBAction func showOnMapPressed(_ sender: UIButton) {
            
            self.performSegue(withIdentifier: "fromProfileToMap", sender: self)
            
        }
    
        override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
            
            if segue.identifier == "fromProfileToMap"{
                
                let destinationVC = segue.destination as! MapViewController
                destinationVC.showOneUser = true
                destinationVC.users.append(user)
                
            }
        }
    
    }
    



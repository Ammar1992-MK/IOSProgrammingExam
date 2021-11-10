//
//  UsersTableViewController.swift
//  RandomUser
//
//  Created by Ammar Khalil on 03/11/2021.
//

import UIKit
import CoreData
class UsersTableViewController: UITableViewController {

    

    
    var userManager = UserManager()
    var users : [User] = []
    var userImage : UIImage?
    var imageToPass = UIImage()
    
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.register(UINib(nibName: "UserCell", bundle: nil), forCellReuseIdentifier: "ReusableCell")
        
        userManager.fetchUserData()
        
        loadUsers()
        
    }
    
    
    func loadUsers(){
        
        let request : NSFetchRequest<User> = User.fetchRequest()
        
        do{
            users = try context.fetch(request)
            tableView.reloadData()
        }catch{
            print("error fetching data from DB \(error)")
        }
        
        
    }
    

    

    // MARK: - Table view data source


    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return users.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ReusableCell", for: indexPath) as! UserCell

        cell.label.text = "\(users[indexPath.row].firstName ?? "No first Name were found") \(users[indexPath.row].lastName ?? "no last name were found")"
        
        DispatchQueue.main.async { [self] in
            let url = URL(string: self.users[indexPath.row].imageMedium!)
               if let data = try? Data(contentsOf: url!)
               {
                userImage = UIImage(data: data)
                cell.userImage.image = self.userImage
               }
        }
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        if let vc = storyboard?.instantiateViewController(identifier: "UserProfile") as? UserProfileViewController{
            self.navigationController?.pushViewController(vc, animated: true)
            
         
            vc.user = users[indexPath.row]
        

        }
        
        
    }
    
}








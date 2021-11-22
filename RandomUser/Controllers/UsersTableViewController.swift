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
    var fetchedResultsController : NSFetchedResultsController<User>!
    var userImage : UIImage?
    var imageToPass = UIImage()
    
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    var refreshControll = UIRefreshControl()
    
    var seedManager = SeedManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        seedManager.isFirstLaunch()
        seedManager.storeFirstLaunch()
        userManager.fetchUserData()
        tableView.register(UINib(nibName: "UserCell", bundle: nil), forCellReuseIdentifier: "ReusableCell")
        setupFetchedResultsController()
        
        refreshControll.addTarget(self, action: #selector(self.updateTable(refrechController:)), for: UIControl.Event.valueChanged)
              tableView.addSubview(refreshControll)
    }
    
    @objc func updateTable(refrechController : UIRefreshControl){
        DispatchQueue.main.async {
            self.userManager.fetchUserData()
            self.refreshControll.endRefreshing()
        }
    }
    
    func setupFetchedResultsController(){
        fetchedResultsController = loadUsers()
        fetchedResultsController.delegate = self
        
        do{
            try fetchedResultsController.performFetch()
        }catch{
            print("error")
        }
    }
    
    
    func loadUsers() -> NSFetchedResultsController <User>{
        
        let request : NSFetchRequest<User> = User.fetchRequest()
        let sortDescriptor = NSSortDescriptor(keyPath: \User.age, ascending: false)
        request.sortDescriptors = [sortDescriptor]
            
        return NSFetchedResultsController(fetchRequest: request, managedObjectContext: context, sectionNameKeyPath: nil, cacheName: nil)
       
    }
    

    // MARK: - Table view data source


    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let users = fetchedResultsController.sections![section]
        return users.numberOfObjects
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ReusableCell", for: indexPath) as! UserCell
        
        let user = fetchedResultsController.object(at: indexPath)

        cell.label.text = "\(user.firstName ?? "No first Name were found") \(user.lastName ?? "no last name were found")"
        
        DispatchQueue.main.async { [self] in
            
            if let image = user.imageMedium {
                if let url = URL(string: image){
                    if let data = try? Data(contentsOf: url){
                        
                        userImage = UIImage(data: data)
                        cell.userImage.image = self.userImage
                    }
                    
                }
            }

        }
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        if let vc = storyboard?.instantiateViewController(identifier: "UserProfile") as? UserProfileViewController{
            self.navigationController?.pushViewController(vc, animated: true)
            
            let user = fetchedResultsController.object(at: indexPath)
         
            vc.user = user
        

        }
        
        
    }
    
    
}

// MARK:- NSFetchedResultsController Delegates
extension UsersTableViewController : NSFetchedResultsControllerDelegate{
    
    func controllerWillChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        tableView.beginUpdates()
    }
    
    func controllerDidChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        tableView.endUpdates()
    }
    
    func controller(_ controller: NSFetchedResultsController<NSFetchRequestResult>, didChange anObject: Any, at indexPath: IndexPath?, for type: NSFetchedResultsChangeType, newIndexPath: IndexPath?) {
        
        switch type {
        case .insert:
            tableView.insertRows(at: [newIndexPath!], with: .automatic)
        case .delete:
            tableView.deleteRows(at: [indexPath!], with: .automatic)
        case .update:
            tableView.reloadRows(at: [indexPath!], with: .automatic)
//        case .move:
//            tableView.moveRow(at: indexPath!, to: newIndexPath!)
        default:
            tableView.reloadData()
        }
    }
}








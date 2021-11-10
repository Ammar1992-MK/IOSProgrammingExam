////
////  ViewController.swift
////  RandomUser
////
////  Created by Ammar Khalil on 01/11/2021.
////
//
//import UIKit
//
//class UsersListViewController: UIViewController{
//
//    
//
//
//
//    @IBOutlet weak var tableView: UITableView!
//
//
//    var userManager = UserManager()
//    var users : [User] = []
//    var userImage : UIImage?
//    var imageToPass = UIImage()
//
//
//    override func viewDidLoad() {
//        super.viewDidLoad()
//
//        tableView.register(UINib(nibName: "UserCell", bundle: nil), forCellReuseIdentifier: "ReusableCell")
//        userManager.delegate = self
//        tableView.delegate = self
//        tableView.dataSource = self
//        userManager.fetchUserData()
//
//    }
//
//
//
//
//}
//
//
//extension UsersListViewController : UITableViewDataSource{
//
//     func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//
//        return users.count
//    }
//
//     func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        let cell = tableView.dequeueReusableCell(withIdentifier: "ReusableCell", for: indexPath) as! UserCell
//
//        cell.label.text = "\(users[indexPath.row].name.first) \(users[indexPath.row].name.last)"
//
//        DispatchQueue.main.async { [self] in
//            let url = URL(string: self.users[indexPath.row].picture.medium)
//               if let data = try? Data(contentsOf: url!)
//               {
//                userImage = UIImage(data: data)
//                cell.userImage.image = self.userImage
//               }
//        }
//        return cell
//    }
//
//
//}
//
//extension UsersListViewController : UITableViewDelegate {
//
//     func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//
//        if let vc = storyboard?.instantiateViewController(identifier: "UserProfile") as? UserProfileViewController{
//            self.navigationController?.pushViewController(vc, animated: true)
//
//
//
//
//            vc.userImage = users[indexPath.row].picture.large
//            vc.name = "\(users[indexPath.row].name.first) \(users[indexPath.row].name.last)"
//            vc.email = users[indexPath.row].email
//            vc.age = users[indexPath.row].dob.age
//            vc.city = users[indexPath.row].location.city
//            vc.state = users[indexPath.row].location.state
//            vc.dob = users[indexPath.row].dob.date
//
//
//        }
//
//
//    }
//}
//
//
//
//extension UsersListViewController : UserManagerDelegate {
//    func didUpdateUser(_ userManager: UserManager, user: [User]) {
//        users = user
//
//        DispatchQueue.main.async {
//            self.tableView.reloadData()
//        }
//    }
//
//    func didFailWithError(error: Error) {
//
//        print(error)
//    }
//
//
//
//}
//


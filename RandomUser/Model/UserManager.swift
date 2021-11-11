//
//  UserManager.swift
//  RandomUser
//
//  Created by Ammar Khalil on 01/11/2021.
//

import Foundation
import UIKit
import CoreData

protocol UserManagerDelegate {
   
    func didFailWithError (error : Error)
}


struct UserManager{
    
    let randomUserURL = "https://randomuser.me/api/?results=100&seed=ios"
    
    var delegate : UserManagerDelegate?
    
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    func fetchUserData (){
        
        let urlString = randomUserURL
        
        performRequest(with: urlString)
    }
    
    
    func performRequest(with urlString : String){
        
        if let url = URL(string : urlString) {
            let session = URLSession(configuration: .default)
            let task =  session.dataTask(with: url) { data, response, error in
                if error != nil {
                    self.delegate?.didFailWithError(error: error!)
                    return
                }
                
                if let safeData = data {
                    self.parseJSON(safeData)
                }
               
            }
            //start task
            task.resume()
        }
    }
    
    func parseJSON( _ userData : Data) {
     
        let decoder = JSONDecoder()
        
        do{
            let decodedData = try decoder.decode(UserData.self, from : userData )
            
            let fetchedUsers = decodedData.results
            
            
//            for user in fetchedUsers{
//                let newUser = User(context: context)
//                newUser.firstName = user.name.first
//                newUser.lastName = user.name.last
//                newUser.email = user.email
//                newUser.city = user.location.city
//                newUser.state = user.location.state
//                newUser.dateOfBirth = user.dob.date
//                newUser.age = Int16(user.dob.age)
//                newUser.imageLarge = user.picture.large
//                newUser.imageMedium = user.picture.medium
//                newUser.latitude = user.location.coordinates.latitude
//                newUser.longitude = user.location.coordinates.longitude
//
//
//            }
                //saveUserToDB()
            
            
        } catch{
            delegate?.didFailWithError(error: error)
            print(error)
            
        }
    }
    
    func saveUserToDB()  {
        
        do{
            try context.save()
        }catch{
            print("Error saving \(error)")
        }
    }
    
    
    func loadUsers() -> Int{
        
        let request : NSFetchRequest<User> = User.fetchRequest()
        
        do{
            let users = try context.fetch(request)
            print(users.count)
            return users.count
        }catch{
            print("error fetching data from DB \(error)")
        }
        
        return 0
        
    }

}

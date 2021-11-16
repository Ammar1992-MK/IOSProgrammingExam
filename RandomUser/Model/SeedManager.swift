//
//  SeedManager.swift
//  RandomUser
//
//  Created by Ammar Khalil on 16/11/2021.
//

import Foundation
import UIKit
import CoreData

struct SeedManager {
    
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    func isFirstLaunch() {
        let launchedBefore = UserDefaults.standard.bool(forKey: "hasBeenLaunchedBefore")
        if !launchedBefore  {
         
            let seed = Seed(context: context)
            seed.name = "ios"
            
            do{
                saveUserToDB()
            }catch{
                print(error)
            }
        }
    }
    
    func storeFirstLaunch(){
          
        UserDefaults.standard.set(true, forKey: "hasBeenLaunchedBefore")
    }

    
    func UpdateSeed(newSeed : String){
        
        deleteUnchangesUsers()
        
        let reuqest : NSFetchRequest<Seed> = Seed.fetchRequest()
        do{
            let fetchedSeed = try context.fetch(reuqest)
            fetchedSeed.first?.name = newSeed
            saveUserToDB()
        }catch{
            print(error)
        }
    }
    
    func deleteUnchangesUsers(){
        
        let request : NSFetchRequest<User> = User.fetchRequest()
        
        do{
           let fetchedUsers = try context.fetch(request)
            
            for user in fetchedUsers {
                
                if !user.isChanged {
                    
                    context.delete(user)
                    saveUserToDB()
                }
            }
        }catch{
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
}


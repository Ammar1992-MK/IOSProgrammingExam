//
//  UserManager.swift
//  RandomUser
//
//  Created by Ammar Khalil on 01/11/2021.
//

import Foundation


protocol UserManagerDelegate {
    func didUpdateUser( _ userManager : UserManager ,user: [User])
    func didFailWithError (error : Error)
}


struct UserManager{
    
    let randomUserURL = "https://randomuser.me/api/?results=100&seed=ios"
    
    var delegate : UserManagerDelegate?
    
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
                    if let user =  self.parseJSON(safeData){
                        self.delegate?.didUpdateUser(self, user : user)
                    }
                }
            }
            //start task
            task.resume()
        }
    }
    
    func parseJSON( _ userData : Data) -> [User]? {
     
        let decoder = JSONDecoder()
        
        do{
            let decodedData = try decoder.decode(UserData.self, from : userData )
            
            let fetchedUsers = decodedData.results
            
           return fetchedUsers
            
        } catch{
            delegate?.didFailWithError(error: error)
            print(error)
            return nil
        }
    }
}

//
//  UserModel.swift
//  RandomUser
//
//  Created by Ammar Khalil on 01/11/2021.
//

import Foundation

struct UserModel {
    
    let users : [userData]
}

struct userData {
    let firstName : String
    let lastName : String
    let email : String
    let city : String
    let state : String
    let dob : String
    let age : Int
    let latitude : String
    let longitude : String
    let image : String
}

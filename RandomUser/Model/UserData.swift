//
//  UserData.swift
//  RandomUser
//
//  Created by Ammar Khalil on 01/11/2021.
//

import Foundation

struct UserData : Decodable {
    
    let results : [UserApi]
}

struct UserApi  : Decodable{
    
    let name : Name
    let email : String
    let location : Location
    let dob :Dob
    let picture :Image
}

struct Name : Decodable {
    let first : String
    let last : String
}

struct Location : Decodable {
    
    let city : String
    let state : String
    let coordinates : Coordinates
}

struct Coordinates : Decodable {
    
    let latitude : String
    let longitude : String
}

struct Dob : Decodable {
    
    let date : String
    let age : Int
}

struct Image : Decodable {
    
    let medium : String
    let large : String
}


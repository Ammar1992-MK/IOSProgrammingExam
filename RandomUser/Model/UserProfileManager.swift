//
//  UserProfileManager.swift
//  RandomUser
//
//  Created by Ammar Khalil on 21/11/2021.
//

import Foundation
import UIKit

struct UserProfileManager {
    
    func checkBirthdayCelebration(date : String) -> Bool{
        
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        
        let userBirthday = dateFormatter.date(from: date)
        
        let currentWeek = NSCalendar.current.component(.weekOfYear, from: Date())
     
        if let birthdayWeek = userBirthday{
            
            let week = NSCalendar.current.component(.weekOfYear, from: birthdayWeek)
            
            if currentWeek == week{
                return true
            }
            
        }
        
       return false
    }
    
    func getFormatedDate(date_string:String,dateFormat:String)-> String{

       let dateFormatter = DateFormatter()
       dateFormatter.locale = Locale(identifier: "en_US_POSIX")
       dateFormatter.dateFormat = dateFormat

       let dateFromInputString = dateFormatter.date(from: date_string)
       dateFormatter.dateFormat = "yyyy-MM-dd" // Here you can use any dateformate for output date
       if(dateFromInputString != nil){
           return dateFormatter.string(from: dateFromInputString!)
       }
       else{
           debugPrint("could not convert date")
           return "N/A"
       }
   }
    
    
}

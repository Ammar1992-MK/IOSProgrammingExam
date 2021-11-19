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
    
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    var user : User! = nil
    
    var emojiLabel1 = UILabel.init(frame: .init(x: 100,y: 100,width: 200,height: 200))
    var emojiLabel2 = UILabel.init(frame: .init(x: 100,y: 100,width: 200,height: 200))
    var emojiLabel3 = UILabel.init(frame: .init(x: 100,y: 100,width: 200,height: 200))
    var emojiLabel4 = UILabel.init(frame: .init(x: 100,y: 100,width: 200,height: 200))
    var emojiLabel5 = UILabel.init(frame: .init(x: 100,y: 100,width: 200,height: 200))
    var emojiLabel6 = UILabel.init(frame: .init(x: 100,y: 100,width: 200,height: 200))
    var emojiLabel7 = UILabel.init(frame: .init(x: 100,y: 100,width: 200,height: 200))
    var emojiLabel8 = UILabel.init(frame: .init(x: 100,y: 100,width: 200,height: 200))
   
    
    override func viewDidLoad() {
        super.viewDidLoad()
        DispatchQueue.main.async {  
            let url = URL(string: (self.user?.imageLarge)!)
            if let data = try? Data(contentsOf: url!)
            {
                self.profileImage?.image = UIImage(data: data)!
                
            }
            
            
        }
        
        nameLabel.text = ("\(user?.firstName ?? "default value") \(user?.lastName ?? "no last name") ")
        emailLabel.text = user?.email
        // TODO
        ageLabel.text = String(user.age)
    
        dateOfBirthLabel.text = user.dateOfBirth
    
        cityLabel.text = user.city
        stateLabel.text = user.state
        
        emojiLabel1.text = "🧁"
        emojiLabel2.text = "🍰"
        emojiLabel3.text = "🎂"
        emojiLabel4.text = "🍰"
        emojiLabel5.text = "🎂"
        emojiLabel6.text = "🍰"
        emojiLabel7.text = "🧁"
        emojiLabel8.text = "🎉"
        
        emojiLabel1.frame.origin = CGPoint(x: 50, y: 150)
        emojiLabel2.frame.origin = CGPoint(x: 250, y: 100)
        emojiLabel3.frame.origin = CGPoint(x: 250, y: 100)
        emojiLabel4.frame.origin = CGPoint(x: 200, y: 200)
        emojiLabel5.frame.origin = CGPoint(x: 220, y: 300)
        emojiLabel6.frame.origin = CGPoint(x: 270, y: 300)
        emojiLabel7.frame.origin = CGPoint(x: 300, y: 400)
        
       

        
        checkBirthdayCelebration()
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
   
    
    func checkBirthdayCelebration(){
        
        var date = ""
        
        if user.isChanged {
            date = user.dateOfBirth!
        } else {
             date = getFormatedDate(date_string: dateOfBirthLabel.text!, dateFormat: "yyyy-MM-dd'T'HH:mm:ss.SSSZ")
        }
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        
        let userBirthday = dateFormatter.date(from: date)
        
        let currentWeek = NSCalendar.current.component(.weekOfYear, from: Date())
     
        if let birthdayWeek = userBirthday{
            
            let week = NSCalendar.current.component(.weekOfYear, from: birthdayWeek)
            
            if currentWeek == week{
                showBirthdayCelebration()
            }
        }
    }
    
    func showBirthdayCelebration(){
        view.addSubview(emojiLabel1)
        view.addSubview(emojiLabel2)
        view.addSubview(emojiLabel3)
        view.addSubview(emojiLabel4)
        view.addSubview(emojiLabel5)
        view.addSubview(emojiLabel6)
        view.addSubview(emojiLabel7)
        
        UIView.animate(withDuration: 30, delay: 0, options: [.repeat], animations: {
            var fram = self.emojiLabel2.frame
            fram.origin.y += 600
            //fram.origin.x = 10
            self.emojiLabel2.frame = fram
           
            var fram1 = self.emojiLabel1.frame
            fram1.origin.y += 600
            //fram1.origin.x = 100
            self.emojiLabel1.frame = fram1
            
            var fram2 = self.emojiLabel3.frame
            fram2.origin.y += 600
            //fram2.origin.x = 50
            self.emojiLabel3.frame = fram2
            
            var fram3 = self.emojiLabel4.frame
            fram3.origin.y += 600
            //fram3.origin.x = 150
            self.emojiLabel4.frame = fram3
            
            var fram4 = self.emojiLabel5.frame
            fram4.origin.y += 600
           // fram4.origin.x = 130
            self.emojiLabel5.frame = fram4
            
            var fram5 = self.emojiLabel6.frame
            fram5.origin.y += 600
            //fram5.origin.x = 200
            self.emojiLabel6.frame = fram5
            
            var fram6 = self.emojiLabel7.frame
            fram6.origin.y += 600
            //fram6.origin.x = 180
            self.emojiLabel7.frame = fram6
            
        }){_ in
            
            
            
        }
    }
    
    
    @IBAction func deleteUserPressed(_ sender: UIButton) {
        
        context.delete(user)
        do{
            try context.save()
        }catch{
            print("Error saving \(error)")
        }
    }
    
    

        @IBAction func showOnMapPressed(_ sender: UIButton) {
            
            self.performSegue(withIdentifier: "fromProfileToMap", sender: self)
            
        }
    
    
    @IBAction func showOnUpdatePressed(_ sender: UIButton) {
        
        self.performSegue(withIdentifier: "fromProfileToUpdate", sender: self)
    }
    
    
    
        override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
            
            if segue.identifier == "fromProfileToMap"{
                
                let destinationVC = segue.destination as! MapViewController
                destinationVC.showOneUser = true
                destinationVC.users.append(user)
                
            } else if segue.identifier == "fromProfileToUpdate"{
                
                let destiniationVC = segue.destination as! UpdateUserViewController
                destiniationVC.firstName = user.firstName!
                destiniationVC.lastName = user.lastName!
                destiniationVC.email = user.email!
                destiniationVC.dob = user.dateOfBirth!
            }
        }
    
    }
    



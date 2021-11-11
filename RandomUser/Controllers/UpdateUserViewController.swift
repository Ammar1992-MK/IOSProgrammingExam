//
//  UpdateUserViewController.swift
//  RandomUser
//
//  Created by Ammar Khalil on 11/11/2021.
//

import UIKit
import CoreData

class UpdateUserViewController: UIViewController {

    
    @IBOutlet weak var firstNameTextField: UITextField!
    
    @IBOutlet weak var lastNameTextField: UITextField!
    
    @IBOutlet weak var dateOfBirthTextField: UITextField!
    
    @IBOutlet weak var emailTextField: UITextField!
    
    var datePicker : UIDatePicker?
    
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    var firstName = ""
    var lastName = ""
    var email = ""
    var dob = ""
    override func viewDidLoad() {
        super.viewDidLoad()
        
        firstNameTextField.text = firstName
        lastNameTextField.text = lastName
        emailTextField.text = email
        dateOfBirthTextField.text = dob

        datePicker = UIDatePicker()
        datePicker?.datePickerMode = .date
        datePicker?.addTarget(self, action: #selector(self.dateChanges(datePicker:)), for: .valueChanged)
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(self.viewTappedGestureRecognizer(gestureRecognizer:)))
        
        view.addGestureRecognizer(tapGesture)
        
        dateOfBirthTextField.inputView = datePicker
        
        
    }
    
    @objc func viewTappedGestureRecognizer( gestureRecognizer : UITapGestureRecognizer){
        
        view.endEditing(true)
    }
    
    
    @objc func dateChanges(datePicker : UIDatePicker){
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        
        dateOfBirthTextField.text = dateFormatter.string(from: datePicker.date)
        
    }
    
    
    
    @IBAction func updateUserPressed(_ sender: UIButton) {
        
        let request : NSFetchRequest<User> = User.fetchRequest()
        request.predicate = NSPredicate(format : "firstName LIKE %@", "\(firstName)")
        
        do{
            let fetchedUser = try context.fetch(request)
            fetchedUser.first?.firstName = firstNameTextField.text
            fetchedUser.first?.lastName = lastNameTextField.text
            fetchedUser.first?.dateOfBirth = dateOfBirthTextField.text
            fetchedUser.first?.email = emailTextField.text
            //Update age
            
            let birthday  = datePicker?.date
            let now = Date()
            let ageComponents = Calendar.current.dateComponents([.year,.month,.day], from: birthday!, to: now)
            fetchedUser.first?.age = Int16(ageComponents.year!)
            
            
            saveUserToDB()
        }catch{
            print("error fetching data from DB \(error)")
        }
        
    }
    
    override func viewDidLayoutSubviews() {
        let screenWidth = self.view.frame.width
        let screenHeight = self.view.frame.height
        datePicker?.frame = CGRect(x: 0, y: screenHeight - 216 - 44, width: screenWidth, height: 216)
    }
    
    func saveUserToDB()  {
        
        do{
            try context.save()
        }catch{
            print("Error saving \(error)")
        }
    }
    
}

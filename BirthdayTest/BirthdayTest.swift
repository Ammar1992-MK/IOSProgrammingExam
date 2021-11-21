//
//  BirthdayTest.swift
//  BirthdayTest
//
//  Created by Ammar Khalil on 19/11/2021.
//

import XCTest
@testable import RandomUser
class BirthdayTest: XCTestCase {

    var sut : UserProfileManager?
    
    override func setUpWithError() throws {
        
        try super.setUpWithError()
        sut = UserProfileManager()
       
    }

    override func tearDownWithError() throws {
        
        sut = nil
    }


    func test_userHasBirthday(){
        let today = Date()
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-yy"
        let stringDate = dateFormatter.string(from: today)
        
        let result = sut?.checkBirthdayCelebration(date: stringDate)
        XCTAssertEqual(result, true)
    }
    
    func test_userHasNotBirthday(){
        
        let result = sut?.checkBirthdayCelebration(date: "2021-07-30")
        XCTAssertEqual(result, false)
    }
}

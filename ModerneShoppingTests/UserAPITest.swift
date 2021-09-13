//
//  UserAPITest.swift
//  ModerneShoppingTests
//
//  Created by Djallil Elkebir on 2021-09-12.
//

import XCTest
@testable import ModerneShopping
class UserAPITest: XCTestCase {

    var mockUsers: MockAPIServices!
    var users: UserViewModel!
   
    
    override func setUp() {
        mockUsers = MockAPIServices()
        users = .init(userServices: mockUsers)
    }
    
    func testLoadingUser(){
    }
    
    override func tearDown() {

    }

}

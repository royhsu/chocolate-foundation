//
//  WebServiceTests.swift
//  CHFoundation
//
//  Created by 許郁棋 on 2016/7/5.
//  Copyright © 2016年 Tiny World. All rights reserved.
//

@testable import CHFoundation
import XCTest

class User {
    
    let name: String
    
    init(name: String) {
        
        self.name = name
        
    }
    
}

class WebServiceTests: XCTestCase {
    
    var webService: WebService<User>? = nil
    var mockUserData: Data {
        
        return try! JSONSerialization.data(
            withJSONObject: [ "name": "Roy" ],
            options: []
        )
        
    }
    
    override func setUp() {
        super.setUp()
        
        let url = URL(string: "https://example.com")!
        let urlRequest = URLRequest(url: url)
        webService = WebService(urlRequest: urlRequest) { data in
            
            let json = data as! NSDictionary
            let name = json["name"] as! String
            let user = User(name: name)
            
            return user
            
        }
        
    }
    
    override func tearDown() {
    
        webService = nil
        
        super.tearDown()
    }
    
    func testRequestAndParsingModel() {
    
        let expectation = self.expectation(description: "Request data with web service.")
        let mockSession = MockURLSession()
        mockSession.data = mockUserData
        
        let _ = webService!
            .request(with: mockSession)
            .then { user -> Void in
                
                let expectedUser = User(name: "Roy")
                
                XCTAssertEqual(user.name, expectedUser.name)
                
            }
            .always { expectation.fulfill() }
        
        waitForExpectations(timeout: 5.0, handler: nil)
        
    }
    
}

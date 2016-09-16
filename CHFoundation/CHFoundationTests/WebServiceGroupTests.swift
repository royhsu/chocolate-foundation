//
//  WebServiceGroupTests.swift
//  CHFoundation
//
//  Created by 許郁棋 on 2016/9/16.
//  Copyright © 2016年 Tiny World. All rights reserved.
//

@testable import CHFoundation
import XCTest

class WebServiceGroupTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
        
        
        
    }
    
    override func tearDown() {
        
        
        
        super.tearDown()
    }
    
    func testRequesting() {
        
        let url1 = URL(string: "https://example.com")!
        let urlRequest1 = URLRequest(url: url1)
        var webService1 = WebService<Any>(urlRequest: urlRequest1)
        
        let jsonObject1: [String: String] = [ "name": "Roy" ]
        let mockSession1 = MockURLSession()
        mockSession1.data = try! JSONSerialization.data(
            withJSONObject: jsonObject1,
            options: []
        )
        
        webService1.urlSession = mockSession1
        
        let url2 = URL(string: "https://example2.com")!
        let urlRequest2 = URLRequest(url: url2)
        var webService2 = WebService<Any>(urlRequest: urlRequest2)
        
        let mockSession2 = MockURLSession()
        let jsonObject2: [String: [String]] = [ "hobbies": [ "drawing", "basketball" ] ]
        mockSession2.data = try! JSONSerialization.data(
            withJSONObject: jsonObject2,
            options: []
        )
        
        webService2.urlSession = mockSession2
        
        let webServiceGroup = WebServiceGroup(
            services: [ webService1, webService2 ]
        )
        
        let expectation = self.expectation(description: "Request data with web service group.")
        
        let _ = webServiceGroup
            .request()
            .then { objects -> Void in
                
                let object1 = objects[0] as! [String: Any]
                
                let expectedName = object1["name"] as? String
                let name = jsonObject1["name"]
                XCTAssertEqual(name, expectedName, "The name doesn't match.")
                
                let object2 = objects[1] as! [String: Any]
                let expectedHobbies = jsonObject2["hobbies"]!
                let hobbies = object2["hobbies"] as! [String]
                XCTAssertEqual(expectedHobbies, hobbies, "The hobbies don't match.")
                
            }
            .catch { error in
                
                XCTAssert(false, "Should not have an error. \(error)")
            
            }
            .always { expectation.fulfill() }
        
        waitForExpectations(timeout: 5.0, handler: nil)

    }
    
}

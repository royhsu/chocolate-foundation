//
//  WebServiceTest.swift
//  CHFoundation
//
//  Created by 許郁棋 on 2016/7/5.
//  Copyright © 2016年 Tiny World. All rights reserved.
//

@testable import CHFoundation
import XCTest

class WebServiceTest: XCTestCase {
    
//    var webService: WebService?
    
    override func setUp() {
        super.setUp()
        
//        let url = URL(string: "https://example.com")!
//        webService = WebService(urlRequest: URLRequest(url: url))
        
    }
    
    override func tearDown() {
    
//        webService = nil
        
        super.tearDown()
    }
    
//    func testSuccessfulResponse() {
//        
//        class MockURLSession: URLSession {
//            
//            override func dataTask(with url: URL, completionHandler: (Data?, URLResponse?, NSError?) -> Void) -> URLSessionDataTask {
//                
//                let dataObject: [NSObject: AnyObject] = [
//                    "data": [
//                        [ "id": "001", "name": "Allen" ],
//                        [ "id": "002", "name": "Bob" ],
//                        [ "id": "003", "name": "Chris" ],
//                        [ "id": "004", "name": "David" ],
//                        [ "id": "005", "name": "Emily" ]
//                    ]
//                ]
//                
//                let jsonData = try! JSONSerialization.data(withJSONObject: dataObject, options: .prettyPrinted)
//                
//                let response = HTTPURLResponse(url: url, statusCode: 200, httpVersion: "1.1", headerFields: nil)
//                
//                completionHandler(jsonData, response, nil)
//                
//                return URLSessionDataTask()
//                
//            }
//            
//        }
//        
//        let expectation = self.expectation(withDescription: "Request data with web service.")
//        
//        webService!.request(
//            with: MockURLSession(),
//            successHandler: { json in
//                
//                let jsonObject = json as? [NSObject: AnyObject]
//                
//                XCTAssertNotNil(jsonObject, "Should get json object.")
//                
//                let bobName = jsonObject!["data"]?[2]?["name"]
//                
//                XCTAssertEqual(bobName, "Bob", "The result doesn't match.")
//                
//                expectation.fulfill()
//                
//            },
//            failHandler: { error in
//            
//                XCTAssertNil(error, "Should not catch an error.")
//                
//                expectation.fulfill()
//                
//            }
//        )
//        
//        waitForExpectations(withTimeout: 3.0, handler: nil)
//        
//    }
    
}

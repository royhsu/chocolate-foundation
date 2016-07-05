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
    
    var webService: WebService?
    
    override func setUp() {
        super.setUp()
        
        webService = WebService(urlRequest: URLRequest(url: URL(string: "")!))
        
    }
    
    override func tearDown() {
    
        webService = nil
        
        super.tearDown()
    }
    
    func testInitWithURLRequest() {
        
        XCTAssertNotNil(webService, "Cannot initialize web service with url request.")
        
    }
    
    func testSuccessfulResponse() {
        
        class mockURLSession: URLSession {
            
            override func dataTask(with url: URL, completionHandler: (Data?, URLResponse?, NSError?) -> Void) -> URLSessionDataTask {
                
                let dataObject: [NSObject: AnyObject] = [
                    "data": [
                        [ "id": "001", "name": "Allen" ],
                        [ "id": "002", "name": "Bob" ],
                        [ "id": "003", "name": "Chris" ],
                        [ "id": "004", "name": "David" ],
                        [ "id": "005", "name": "Emily" ]
                    ]
                ]
                
                let jsonData = try! JSONSerialization.data(withJSONObject: dataObject, options: .prettyPrinted)
                
                let response = HTTPURLResponse(url: url, statusCode: 200, httpVersion: "1.1", headerFields: nil)
                
                completionHandler(jsonData, response, nil)
                
                return URLSessionDataTask()
                
            }
            
        }
        
        webService!.request(
            with: URLSession(configuration: .default()),
            successHandler: { json in
                
                let jsonObject = json as? [NSObject: AnyObject]
                
                XCTAssertNotNil(jsonObject, "Should get json object.")
                
                let bobName = jsonObject!["data"]?[2]?["name"]
                
                XCTAssertEqual(bobName, "Bob", "The result doesn't match.")
                
            },
            failHandler: { error in
            
                XCTAssertNil(error, "Should not catch an error.")
                
            }
        )
        
    }
    
}

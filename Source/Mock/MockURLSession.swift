//
//  MockURLSession.swift
//  CHFoundation
//
//  Created by 許郁棋 on 2016/9/11.
//  Copyright © 2016年 Tiny World. All rights reserved.
//

import Foundation

internal class MockURLSession: URLSession {
    
    internal var data: Data? = nil
    
    internal override func dataTask(with request: URLRequest, completionHandler: @escaping (Data?, URLResponse?, Error?) -> Swift.Void) -> URLSessionDataTask {
        
        completionHandler(data, nil, nil)
        
        return MockURLSessionDataTask()
        
    }
    
}

internal class MockURLSessionDataTask: URLSessionDataTask {
    
    internal override func resume() { }
    
}

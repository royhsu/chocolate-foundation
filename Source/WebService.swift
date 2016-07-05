//
//  WebService.swift
//  CHFoundation
//
//  Created by 許郁棋 on 2016/7/5.
//  Copyright © 2016年 Tiny World. All rights reserved.
//

import Foundation

public struct WebService {
    
    public enum WebServiceError: ErrorProtocol {
        case InvalidResponse
        case NoResponseData
        case Server(statusCode: Int, message: String)
    }
    
    
    // Property
    
    public let urlRequest: URLRequest
    
    public typealias ErrorParser = (data: Data?, urlResponse: URLResponse?, error: NSError?) -> ErrorProtocol
    public typealias SuccessHandler = (jsonObject: AnyObject) -> Void
    public typealias FailHandler = (error: ErrorProtocol) -> Void
    
    
    // MARK: Request
    
    public func request(with urlSession: URLSession, errorParser: ErrorParser? = nil, successHandler: SuccessHandler, failHandler: FailHandler? = nil) -> URLSessionTask {
        
        let sessionTask = urlSession.dataTask(with: urlRequest) { data, response, error in
            
            if let parsedError = errorParser?(data: data, urlResponse: response, error: error) {
                
                failHandler?(error: parsedError)
                
                return
                
            }
                
            guard let response = response as? HTTPURLResponse else {
                
                failHandler?(error: WebServiceError.InvalidResponse)
                
                return
                
            }
            
            if let error = error {
                
                let message = error.localizedDescription
                let serverError: WebServiceError = .Server(statusCode: response.statusCode, message: message)
                
                failHandler?(error: serverError)
                
                return
            
            }
            
            guard let data = data else {
                
                failHandler?(error: WebServiceError.NoResponseData)
                
                return
                
            }
            
            do {
                
                let jsonObject = try JSONSerialization.jsonObject(with: data, options: [])
                
                successHandler(jsonObject: jsonObject)
                
            }
            catch { failHandler?(error: error) }
        
        }
        
        sessionTask.resume()
        
        return sessionTask
        
    }
    
}

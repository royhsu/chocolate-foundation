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
        case invalidResponse
        case message(String)
        case data(Data?)
    }
    
    public typealias ErrorParser = (data: Data?, urlResponse: URLResponse?, error: NSError?) -> ErrorProtocol
    public typealias SuccessHandler = (jsonObject: AnyObject) -> Void
    public typealias FailHandler = (statusCode: Int, error: ErrorProtocol) -> Void
    
    
    // Property
    
    public let urlRequest: URLRequest
    
    
    // MARK: Request
    
    public func request(with urlSession: URLSession, errorParser: ErrorParser? = nil, successHandler: SuccessHandler, failHandler: FailHandler? = nil) -> URLSessionTask {
        
        let sessionTask = urlSession.dataTask(with: urlRequest) { data, response, error in
            
            guard let response = response as? HTTPURLResponse else {
                
                assert(false, "The response should be a HTTPURLResponse.")
                
                failHandler?(statusCode: 500, error: WebServiceError.invalidResponse)
                
                return
                
            }
            
            let statusCode = response.statusCode
            
            if let parsedError = errorParser?(data: data, urlResponse: response, error: error) {
                
                failHandler?(statusCode: statusCode, error: parsedError)
                
                return
                
            }
            
            if let error = error {
                
                let serverError: WebServiceError = .message(error.localizedDescription)
                
                failHandler?(statusCode: statusCode, error: serverError)
                
                return
            
            }
            
            if !self.validate(withStatusCode: statusCode) {
             
                let serverError: WebServiceError = .message(NSLocalizedString("Unaccepted status code.", comment: ""))
                
                failHandler?(statusCode: statusCode, error: serverError)
                
                return
                
            }
            
            do {
                
                let data = data ?? Data()
                let jsonObject = try JSONSerialization.jsonObject(with: data, options: [])
                
                successHandler(jsonObject: jsonObject)
                
            }
            catch { failHandler?(statusCode: statusCode, error: error) }
        
        }
        
        sessionTask.resume()
        
        return sessionTask
        
    }
    
    
    // MARK: Validate
    
    private func validate(withStatusCode statusCode: Int) -> Bool {
        
        switch statusCode {
        case 200..<300: return true
        default: return false
        }
        
    }
    
}

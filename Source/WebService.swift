//
//  WebService.swift
//  CHFoundation
//
//  Created by 許郁棋 on 2016/7/5.
//  Copyright © 2016年 Tiny World. All rights reserved.
//

import Foundation

public enum WebServiceError: Error {
    case invalidResponse
    case message(String)
    case data(Data?)
    case modelParsing
}

public struct WebService<Model>: Equatable {
    
    public typealias ErrorParser = (_ data: Data?, _ urlResponse: URLResponse?, _ error: Error?) -> Error
    public typealias SuccessHandler = (Model) -> Void
    public typealias FailHandler = (_ statusCode: Int?, _ error: Error) -> Void
    
    
    // MARK: Property

    public let webResource: WebResource<Model>
    
    
    // MARK: Init
    
    public init(webResource: WebResource<Model>) { self.webResource = webResource }
    
    
    // MARK: Request
    
    // TODO:
    // 1. Option for go back to main queue automatically.
    // 2. Option for errorParser.
    
    public func request(with urlSession: URLSession, errorParser: ErrorParser? = nil, successHandler: @escaping SuccessHandler, failHandler: FailHandler? = nil) -> URLSessionTask {
        
        let sessionTask = urlSession.dataTask(with: webResource.urlRequest) { data, response, error in
            
            guard let response = response as? HTTPURLResponse else {
                
                failHandler?(nil, WebServiceError.invalidResponse)
                
                return
                
            }
            
            let statusCode = response.statusCode
            
            if let errorParsingError = errorParser?(data, response, error) {
                
                failHandler?(statusCode, errorParsingError)
                
                return
                
            }
            
            if let error = error {
                
                let serverError: WebServiceError = .message(error.localizedDescription)
                
                failHandler?(statusCode, serverError)
                
                return
            
            }
            
            if !self.validate(withStatusCode: statusCode) {
             
                let serverError: WebServiceError = .message(NSLocalizedString("Unaccepted status code.", comment: ""))
                
                failHandler?(statusCode, serverError)
                
                return
                
            }
            
            do {
                
                let data = data ?? Data()
                let jsonObject = try JSONSerialization.jsonObject(with: data, options: [])
                
                guard let model = self.webResource.parse(jsonObject) else {
                    
                    let error: WebServiceError = .modelParsing
                    
                    failHandler?(nil, error)
                    
                    return
                    
                }
                
                successHandler(model)
                
            }
            catch { failHandler?(statusCode, error) }
        
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


// MARK: Equatable

public func ==<Model>(lhs: WebService<Model>, rhs: WebService<Model>) -> Bool {
    
    return lhs.webResource == rhs.webResource
    
}

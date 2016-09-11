//
//  URL+Extensions.swift
//  CHFoundation
//
//  Created by 許郁棋 on 2016/6/27.
//  Copyright © 2016年 Tiny World. All rights reserved.
//

import Foundation

public extension URL {
    
    /**
     A convenience method that returns complete file path in specific directory.
     
     - Author: Roy Hsu.
     
     - Parameter filename: The file name.
     
     - Parameter extension: The file extension.
     
     - Parameter directory: The directory.
     
     - returns: The specific file path in document directory.
     
     - Important: If you need to get the file path from the returned URL, please access self.path instead of self.absoluteString.
    */
    // Reference: http://stackoverflow.com/questions/32716895/error-the-file-doesnt-exist-when-calling-writetofile-on-imagedata
    
    static func fileURL(filename: String, withExtension `extension`: String, `in` directory: Directory) -> URL {
    
        return
            directory
            .url
            .appendingPathComponent(filename)
            .appendingPathExtension(`extension`)
    
    }
    
}

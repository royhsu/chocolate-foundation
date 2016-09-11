//
//  IntTests.swift
//  CHFoundation
//
//  Created by 許郁棋 on 2016/7/4.
//  Copyright © 2016年 Tiny World. All rights reserved.
//

@testable import CHFoundation
import XCTest

class IntTests: XCTestCase {
    
    
    // MARK: Random number
    
    func testRandomNumberGeneratorInRange() {
        
        for _ in 0..<1000 {
            
            let range: Range<Int> = 0..<20
            
            let randomNumber = Int.random(in: range)
            
            XCTAssertTrue(range.contains(randomNumber), "The generated number is out of the given range.")
            
        }
        
    }
    
}

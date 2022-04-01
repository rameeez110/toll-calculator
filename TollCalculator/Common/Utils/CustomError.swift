//
//  CustomError.swift
//  TollCalculator
//
//  Created by Rameez Hasan on 01/04/2022.
//

import Foundation

class CustomError {
    var errorCode : Int!
    var errorString : String!
    
    init(errorCode:Int? = nil,errorString: String) {
        self.errorCode = errorCode
        self.errorString = errorString
    }
    
    init()
    {
    
    }
}

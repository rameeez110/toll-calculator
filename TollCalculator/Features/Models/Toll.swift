//
//  Toll.swift
//  TollCalculator
//
//  Created by Rameez Hasan on 01/04/2022.
//

import UIKit

struct TollModel {
    var entryDate = Date()
    var exitDate = Date()
    var numberPlate = String()
    var entryInterchange = String()
    var exitInterchange = String()
    var totalCost = String()
    var tripStatus = TripStatus.Active
    var id = String()
    var entryDistance = Int()
    var exitDistance = Int()
    var discount = String()
    
    init() {
        
    }
    
    var dictionary: [String: Any] {
      return [
        "entryDate": self.entryDate.getDateInString(),
        "exitDate": self.exitDate.getDateInString(),
        "numberPlate": self.numberPlate,
        "entryInterchange": self.entryInterchange,
        "exitInterchange": self.exitInterchange,
        "totalCost": self.totalCost,
        "discount": self.discount,
        "tripStatus": self.tripStatus.rawValue,
      ]
    }
}

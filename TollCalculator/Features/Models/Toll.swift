//
//  Toll.swift
//  TollCalculator
//
//  Created by Rameez Hasan on 01/04/2022.
//

import UIKit

struct TollRequestModel {
    var entryDate = String()
    var exitDate = String()
    var numberPlate = String()
    var entryInterchange = String()
    var exitInterchange = String()
    var totalCost = String()
    var tripStatus = TripStatus.Active
    var id = String()
    
    init() {
        
    }
    
    var dictionary: [String: Any] {
      return [
        "entryDate": self.entryDate,
        "exitDate": self.exitDate,
        "numberPlate": self.numberPlate,
        "entryInterchange": self.entryInterchange,
        "exitInterchange": self.exitInterchange,
        "totalCost": self.totalCost,
        "tripStatus": self.tripStatus.rawValue,
      ]
    }
}

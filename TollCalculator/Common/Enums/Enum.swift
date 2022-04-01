//
//  Enum.swift
//  TollCalculator
//
//  Created by Rameez Hasan on 01/04/2022.
//

import UIKit

enum TollScreenType: Int {
    case Entry = 0,Exit
}

enum ApiType: String {
    case Post = "Post"
    case Get = "Get"
    case Put = "Put"
    case Delete = "Delete"
}

enum TripStatus: String {
    case Active = "Active"
    case Completed = "Completed"
}

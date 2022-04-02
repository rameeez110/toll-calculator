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

enum InterchangeTypes: String {
    case ZeroPoint = "Zero point"
    case NS = "NS Interchange"
    case Ph4 = "Ph4 Interchange"
    case Ferozpur = "Ferozpur Interchange"
    case LakeCity = "Lake City Interchange"
    case Raiwand = "Raiwand Interchange"
    case Bahria = "Bahria Interchange"
}

enum InterchangeDistanceTypes: Int {
    case ZeroPoint = 0,NS = 5,Ph4 = 10,Ferozpur = 17,LakeCity = 24,Raiwand = 29,Bahria = 34
}

//
//  DateExtension.swift
//  TollCalculator
//
//  Created by Rameez Hasan on 01/04/2022.
//

import UIKit

extension Date {
    func getDateInString() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MM dd yyyy, hh mm a"
        let dateStr = dateFormatter.string(from: self)
        return dateStr
    }
}

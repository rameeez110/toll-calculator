//
//  CommonClass.swift
//  TollCalculator
//
//  Created by Rameez Hasan on 02/04/2022.
//

import UIKit

class CommonClass {
    static let sharedInstance = CommonClass()
}

extension CommonClass {
    func showSheet(sheet: UIAlertController, sender: UIView, owner: UIViewController) {
        
        switch UIDevice.current.userInterfaceIdiom {
        case .phone:
            owner.present(sheet, animated: true, completion: nil)
        case .pad:
            let popOver = sheet.popoverPresentationController
            
            popOver?.sourceRect = CGRect(x: UIScreen.main.bounds.width / 2, y: UIScreen.main.bounds.height / 2, width: 0, height: 0)
            popOver?.sourceView = sender
            popOver?.permittedArrowDirections = UIPopoverArrowDirection(rawValue: 0)
            
            owner.present(sheet, animated: true, completion: nil)
        case .unspecified:
            owner.present(sheet, animated: true, completion: nil)
        default:
            print("")
        }
        
    }
    func isValidNumberPlate(_ number: String) -> Bool {
        let plateRegEx = "[A-Z]{3}[-][0-9]{3}"

        let platePred = NSPredicate(format:"SELF MATCHES %@", plateRegEx)
        return platePred.evaluate(with: number)
    }
}

//MARK: Bussiness Rules
extension CommonClass {
    func mapBussinessRules(model: TollModel) -> (String,String){
        var cost = Double(20) // Base Rate
        let cal = Calendar.current
        
        let weekdayExit = cal.component(.weekday, from: model.exitDate)
        let weekdayEntry = cal.component(.weekday, from: model.entryDate)
        var perHourRate = Double(0.2)
        var discountInPercent = Int()
        let numberPlateOnlyNumberPart = Int(model.numberPlate.components(separatedBy: "-").last ?? "0") ?? Int()
        
        // applying perhour rate on basis of weekends
        switch weekdayExit {
        case 1: // Sunday
            perHourRate = Double(0.2 * 1.5)
        case 7: // Saturday
            perHourRate = Double(0.2 * 1.5)
        default:
            print("")
        }
        // applying discount on base of weekdays like monday or wed, tues or thurs
        switch weekdayEntry {
        case 2: // Monday
            if numberPlateOnlyNumberPart % 2 == 0 {
                discountInPercent = 10
            }
        case 3: // Tuesday
            if numberPlateOnlyNumberPart % 2 != 0 {
                discountInPercent = 10
            }
        case 4: // Wednesday
            if numberPlateOnlyNumberPart % 2 == 0 {
                discountInPercent = 10
            }
        case 5: // Thursday
            if numberPlateOnlyNumberPart % 2 != 0 {
                discountInPercent = 10
            }
        default:
            print("")
        }
        
        cost = cost + (perHourRate * Double(abs(model.exitDistance - model.entryDistance)))
        
        if self.checkIfNationalHoliday(date: model.exitDate) {
            discountInPercent = 50 // for national holicays
        }
        
        // applied discount if there is
        if discountInPercent > Int() {
            cost = cost - (cost * Double((discountInPercent/100)))
        }
        
        return (String(cost),String(discountInPercent))
    }
    
    func checkIfNationalHoliday(date: Date) -> Bool{
        let dayComponent = Calendar.current.component(.day, from: date)
        let monthComponent = Calendar.current.component(.month, from: date)
        var dayComponentString = "\(dayComponent)"
        var monthComponentString = "\(monthComponent)"
        if dayComponent < 10 {
            dayComponentString = "0\(dayComponent)"
        }
        if monthComponent < 10 {
            monthComponentString = "0\(monthComponent)"
        }
        
        if let selectedDate = self.getDateFromString(dateString: "\(monthComponentString) \(dayComponentString)") {
            if let date = self.getDateFromString(dateString: "03 23") { // 23rd march
                return date == selectedDate
            }
            if let date = self.getDateFromString(dateString: "08 14") { // 14th august
                return date == selectedDate
            }
            if let date = self.getDateFromString(dateString: "12 25") { // 25th dec
                return date == selectedDate
            }
        }
        return false
    }
    
    func getDateFromString(dateString: String) -> Date? {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MM dd"
        let dateStr = dateFormatter.date(from: dateString)
        return dateStr
    }
}

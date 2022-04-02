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
    func mapBussinessRules(model: TollModel) -> String{
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
        
        // applied discount if there is
        if discountInPercent > Int() {
            cost = cost - (cost * Double((discountInPercent/100)))
        }
        
        return String(cost)
    }
}

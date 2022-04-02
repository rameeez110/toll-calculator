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

//
//  UIFontExtension.swift
//  TollCalculator
//
//  Created by Rameez Hasan on 01/04/2022.
//

import UIKit

extension UIFont {
    enum FontSize {
        case standard(StandardSize)
        case custom(CGFloat)
        var value: CGFloat {
            switch self {
            case .standard(let size):
                return size.rawValue
            case .custom(let customSize):
                return customSize
            }
        }
    }

    enum FontName: String {
        case avenirCondensedDemiBold = "AvenirNextCondensed-DemiBold"
        case avenirDemiBold = "AvenirNext-DemiBold"
    }

    enum StandardSize: CGFloat {
        case h1 = 24.0
        case h2 = 22.0
        case h3 = 20.0
        case h4 = 18.0
        case h5 = 16.0
        case h6 = 14.0
    }

    convenience init(_ name: FontName, size: FontSize) {
        self.init(name: name.rawValue, size: size.value)!
    }
}

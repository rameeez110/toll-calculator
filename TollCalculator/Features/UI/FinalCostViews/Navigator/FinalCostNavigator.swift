//
//  FinalCostNavigator.swift
//  TollCalculator
//
//  Created by Rameez Hasan on 01/04/2022.
//

import UIKit

protocol FinalCostNavigatorProtocol {
    
}


class FinalCostNavigator: FinalCostNavigatorProtocol {
    private weak var navigationController: UINavigationController?

    init(navigationController: UINavigationController) {
        navigationController.navigationBar.isHidden = false
        navigationController.title = "Final Costing"
        self.navigationController = navigationController
    }
}

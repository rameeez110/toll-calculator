//
//  EntryNavigator.swift
//  TollCalculator
//
//  Created by Rameez Hasan on 01/04/2022.
//

import UIKit

protocol EntryNavigatorProtocol {
    func navigateToSubmit()
}


class EntryNavigator: EntryNavigatorProtocol {
    private weak var navigationController: UINavigationController?

    init(navigationController: UINavigationController) {
        navigationController.navigationBar.isHidden = true
        self.navigationController = navigationController
    }

    func navigateToSubmit() {
        // controller create & setup
        let storyboard = UIStoryboard(storyboard: .main)
//        let registerVC: RegisterViewController = storyboard.instantiateViewController()
        //View Model create & setup
        if let nc = self.navigationController {
//            let navigator = RegisterNavigator(navigationController: nc)
//            let viewModel = RegisterViewModel(navigator: navigator)
//            registerVC.viewModel = viewModel
//            viewModel.delegate = registerVC
//            navigationController?.pushViewController(registerVC, animated: true)
        }
    }
}

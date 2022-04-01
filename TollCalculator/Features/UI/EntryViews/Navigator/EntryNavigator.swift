//
//  EntryNavigator.swift
//  TollCalculator
//
//  Created by Rameez Hasan on 01/04/2022.
//

import UIKit

protocol EntryNavigatorProtocol {
    func navigateToSubmit()
    func navigateToCalculate()
}


class EntryNavigator: EntryNavigatorProtocol {
    private weak var navigationController: UINavigationController?

    init(navigationController: UINavigationController) {
        navigationController.navigationBar.isHidden = false
        navigationController.title = "Entry"
        self.navigationController = navigationController
    }

    func navigateToSubmit() {
        // controller create & setup
        let storyboard = UIStoryboard(storyboard: .main)
        let exitVC: ViewController = storyboard.instantiateViewController()
        // View Model create & setup
        if let nc = self.navigationController {
            let navigator = EntryNavigator(navigationController: nc)
            let remoteDataSource = TripRemoteDataStore()
            let repository = TripRepository.init(remoteTripDataSource: remoteDataSource)
            let service = TripsService.init(tripRepository: repository)
            let viewModel = EntryViewModel(service: service, type: .Exit, navigator: navigator)
            exitVC.viewModel = viewModel
            viewModel.delegate = exitVC
            navigationController?.pushViewController(exitVC, animated: true)
        }
    }
    func navigateToCalculate() {
        // controller create & setup
        let storyboard = UIStoryboard(storyboard: .main)
        let costVC: FinalCostViewController = storyboard.instantiateViewController()
        // View Model create & setup
        if let nc = self.navigationController {
            let navigator = FinalCostNavigator(navigationController: nc)
            let viewModel = FinalCostViewModel(navigator: navigator)
            costVC.viewModel = viewModel
            viewModel.delegate = costVC
            navigationController?.pushViewController(costVC, animated: true)
        }
    }
}

//
//  EntryNavigator.swift
//  TollCalculator
//
//  Created by Rameez Hasan on 01/04/2022.
//

import UIKit

protocol EntryNavigatorProtocol {
    func navigateToSubmit(model: TollModel)
    func navigateToCalculate(model: TollModel)
}


class EntryNavigator: EntryNavigatorProtocol {
    private weak var navigationController: UINavigationController?

    init(navigationController: UINavigationController) {
        navigationController.navigationBar.isHidden = false
        navigationController.title = "Entry"
        self.navigationController = navigationController
    }

    func navigateToSubmit(model: TollModel) {
        // controller create & setup
        let storyboard = UIStoryboard(storyboard: .main)
        let exitVC: ViewController = storyboard.instantiateViewController()
        // View Model create & setup
        if let nc = self.navigationController {
            let navigator = EntryNavigator(navigationController: nc)
            let remoteDataSource = TripRemoteDataStore()
            let repository = TripRepository.init(remoteTripDataSource: remoteDataSource)
            let service = TripsService.init(tripRepository: repository)
            let viewModel = EntryViewModel(model: model, service: service, type: .Exit, navigator: navigator)
            remoteDataSource.delegate = repository
            repository.delegate = service
            service.delegate = viewModel
            exitVC.viewModel = viewModel
            viewModel.delegate = exitVC
            navigationController?.pushViewController(exitVC, animated: true)
        }
    }
    func navigateToCalculate(model: TollModel) {
        // controller create & setup
        let storyboard = UIStoryboard(storyboard: .main)
        let costVC: FinalCostViewController = storyboard.instantiateViewController()
        // View Model create & setup
        if let nc = self.navigationController {
            let remoteDataSource = TripRemoteDataStore()
            let repository = TripRepository.init(remoteTripDataSource: remoteDataSource)
            let service = TripsService.init(tripRepository: repository)
            let navigator = FinalCostNavigator(navigationController: nc)
            let viewModel = FinalCostViewModel(model: model, service: service, navigator: navigator)
            remoteDataSource.delegate = repository
            repository.delegate = service
            service.delegate = viewModel
            costVC.viewModel = viewModel
            viewModel.delegate = costVC
            navigationController?.pushViewController(costVC, animated: true)
        }
    }
}

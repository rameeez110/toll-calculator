//
//  AppNavigator.swift
//  TollCalculator
//
//  Created by Rameez Hasan on 01/04/2022.
//

import UIKit

struct AppNavigator {

    func installRoot(into window: UIWindow) {
        // controller create & setup
        let storyboard = UIStoryboard(storyboard: .main)
        let vc: ViewController = storyboard.initialViewController()
        let rootController = AppNavigationController(rootViewController: vc)
        // View Model create & setup
        let remoteDataSource = TripRemoteDataStore()
        let repository = TripRepository.init(remoteTripDataSource: remoteDataSource)
        let service = TripsService.init(tripRepository: repository)
        let navigator = EntryNavigator(navigationController: rootController)
        let viewModel = EntryViewModel(service: service, type: .Entry, navigator: navigator)
        
//        service.delegate = viewModel
        viewModel.delegate = vc
        vc.viewModel = viewModel
        
        window.rootViewController = rootController
    }
}

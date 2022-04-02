//
//  FinalCostViewModel.swift
//  TollCalculator
//
//  Created by Rameez Hasan on 01/04/2022.
//

import UIKit

protocol FinalCostViewModelDelegate: class {
    func alert(with title: String, message: String)
    func updateUI(trip: Trips,model: TollModel)
}

// Protocol for view model will use it for wiring
protocol FinalCostViewModelProtocol {
    var delegate: FinalCostViewModelDelegate? { get set }
    func getTrips()
}

final class FinalCostViewModel: FinalCostViewModelProtocol {

    weak var delegate: FinalCostViewModelDelegate?
    private let navigator: FinalCostNavigatorProtocol
    private let service: TripsServiceProtocol
    var tollModel: TollModel
    var trips = [Trips]()
    
    init(model: TollModel,service: TripsServiceProtocol,navigator: FinalCostNavigatorProtocol, delegate: FinalCostViewModelDelegate? = nil) {
        self.delegate = delegate
        self.navigator = navigator
        self.service = service
        self.tollModel = model
    }
    
    func getTrips() {
        self.service.getTrips()
    }
}

extension FinalCostViewModel: TripsServiceDelegate {
    func didFetchTrips(trips: [Trips]) {
        self.trips = trips.filter({$0.id == self.tollModel.id})
        if let trip = self.trips.first {
            self.delegate?.updateUI(trip: trip, model: self.tollModel)
        }
    }
    
    func didAddUpdateTrip(toll: TollModel) {
    }
    
    func didFailWithError(error: CustomError) {
        self.delegate?.alert(with: "Alert!", message: error.errorString ?? "")
    }
}

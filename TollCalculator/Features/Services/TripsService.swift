//
//  TripsService.swift
//  TollCalculator
//
//  Created by Rameez Hasan on 01/04/2022.
//

import UIKit

protocol TripsServiceDelegate: class {
    func didAddUpdateTrip(toll: TollModel)
    func didFailWithError(error: CustomError)
    func didFetchTrips(trips: [Trips])
}

protocol TripsServiceProtocol {
    var delegate: TripsServiceDelegate? { get set }
    func addUpdateToll(toll: TollModel)
    func getTrips()
}

final class TripsService: TripsServiceProtocol {

    weak var delegate: TripsServiceDelegate?
    private let tripRepository: TripRepositoryProtocol

    init(tripRepository: TripRepositoryProtocol) {
        self.tripRepository = tripRepository
    }
    
    func addUpdateToll(toll: TollModel) {
        self.tripRepository.addUpdateToll(parameters: toll)
    }
    func getTrips() {
        self.tripRepository.getTrips()
    }
}

extension TripsService: TripRepositoryDelegate {
    // MARK:- MoviesRepositoryDelegate
    func didFetchTrips(trips: [Trips]) {
        self.delegate?.didFetchTrips(trips: trips)
    }
    func didFailWithError(error: CustomError) {
        delegate?.didFailWithError(error: error)
    }
    func didAddUpdateTrip(toll: TollModel) {
        self.delegate?.didAddUpdateTrip(toll: toll)
    }

}

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
}

protocol TripsServiceProtocol {
    var delegate: TripsServiceDelegate? { get set }
    func addUpdateToll(toll: TollModel)
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
}

extension TripsService: TripRepositoryDelegate {

    // MARK:- MoviesRepositoryDelegate
    func didFailWithError(error: CustomError) {
        delegate?.didFailWithError(error: error)
    }
    func didAddUpdateTrip(toll: TollModel) {
        self.delegate?.didAddUpdateTrip(toll: toll)
    }

}

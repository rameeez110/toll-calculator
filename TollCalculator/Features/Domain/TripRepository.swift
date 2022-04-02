//
//  TripRepository.swift
//  TollCalculator
//
//  Created by Rameez Hasan on 01/04/2022.
//

import Foundation

protocol TripRepositoryDelegate: class {
    func didAddUpdateTrip(toll: TollModel)
    func didFailWithError(error: CustomError)
    func didFetchTrips(trips: [Trips])
}

protocol TripRepositoryProtocol {
    var delegate: TripRepositoryDelegate? { get set }
    func addUpdateToll(parameters: TollModel)
    func getTrips()
}

final class TripRepository: TripRepositoryProtocol {
    weak var delegate: TripRepositoryDelegate?
    private let remoteTripDataSource: TripRemoteDataStoreProtocol

    init(remoteTripDataSource: TripRemoteDataStoreProtocol, delegate: TripRepositoryDelegate? = nil) {
        self.remoteTripDataSource = remoteTripDataSource
        self.delegate = delegate
    }

    func addUpdateToll(parameters: TollModel) {
        self.remoteTripDataSource.addUpdateTrip(parameters: parameters)
    }
    func getTrips() {
        self.remoteTripDataSource.getTrips()
    }
}

extension TripRepository: TripRemoteDataStoreDelegate {

    // MARK:- Trip RemoteDataStoreDelegate
    func didFetchTrips(trips: [Trips]) {
        self.delegate?.didFetchTrips(trips: trips)
    }
    func didAddUpdateTrip(toll: TollModel){
        self.delegate?.didAddUpdateTrip(toll: toll)
    }
    func didFailWithError(error: CustomError){
        self.delegate?.didFailWithError(error: error)
    }
}

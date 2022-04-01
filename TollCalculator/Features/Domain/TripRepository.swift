//
//  TripRepository.swift
//  TollCalculator
//
//  Created by Rameez Hasan on 01/04/2022.
//

import Foundation

protocol TripRepositoryDelegate: class {
    func didAddUpdateTrip(toll: TollRequestModel)
    func didFailWithError(error: CustomError)
}

protocol TripRepositoryProtocol {
    var delegate: TripRepositoryDelegate? { get set }
    func addUpdateToll(parameters: TollRequestModel)
}

final class TripRepository: TripRepositoryProtocol {
    weak var delegate: TripRepositoryDelegate?
    private let remoteTripDataSource: TripRemoteDataStoreProtocol

    init(remoteTripDataSource: TripRemoteDataStoreProtocol, delegate: TripRepositoryDelegate? = nil) {
        self.remoteTripDataSource = remoteTripDataSource
        self.delegate = delegate
    }

    func addUpdateToll(parameters: TollRequestModel) {
        remoteTripDataSource.addUpdateTrip(parameters: parameters)
    }

}

extension TripRepository: TripRemoteDataStoreDelegate {

    // MARK:- Trip RemoteDataStoreDelegate
    func didAddUpdateTrip(toll: TollRequestModel){
        self.delegate?.didAddUpdateTrip(toll: toll)
    }
    func didFailWithError(error: CustomError){
        self.delegate?.didFailWithError(error: error)
    }
}

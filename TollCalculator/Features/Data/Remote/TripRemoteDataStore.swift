//
//  TripRemoteDataStore.swift
//  TollCalculator
//
//  Created by Rameez Hasan on 01/04/2022.
//

import SwiftyJSON

protocol TripRemoteDataStoreDelegate: class {
    func didAddUpdateTrip(toll: TollModel)
    func didFailWithError(error: CustomError)
    func didFetchTrips(trips: [Trips])
}

protocol TripRemoteDataStoreProtocol {
    var delegate: TripRemoteDataStoreDelegate? { get set }
    func addUpdateTrip(parameters: TollModel)
    func getTrips()
}

final class TripRemoteDataStore: TripRemoteDataStoreProtocol {

    weak var delegate: TripRemoteDataStoreDelegate?

    init(delegate: TripRemoteDataStoreDelegate? = nil) {
        self.delegate = delegate
    }

    func addUpdateTrip(parameters: TollModel) {
        TollService.sharedInstance.addOrEditMyTrip(toll: parameters){ (response, error) in
            if error == nil{
                if let id = response as? String {
                    var model = parameters
                    model.id = id
                    self.delegate?.didAddUpdateTrip(toll: model)
                }
            } else {
                self.delegate?.didFailWithError(error: error ?? CustomError.init(errorCode: 0, errorString: "Unknown error"))
            }
        }
    }
    func getTrips() {
        TollService.sharedInstance.getTrips { (response, error) in
            if error == nil{
                if let trips = response as? [Trips] {
                    self.delegate?.didFetchTrips(trips: trips)
                }
            } else {
                self.delegate?.didFailWithError(error: error ?? CustomError.init(errorCode: 0, errorString: "Unknown error"))
            }
        }
    }
}

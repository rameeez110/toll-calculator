//
//  TripRemoteDataStore.swift
//  TollCalculator
//
//  Created by Rameez Hasan on 01/04/2022.
//

import SwiftyJSON

protocol TripRemoteDataStoreDelegate: class {
    func didAddUpdateTrip(toll: TollRequestModel)
    func didFailWithError(error: CustomError)
}

protocol TripRemoteDataStoreProtocol {
    var delegate: TripRemoteDataStoreDelegate? { get set }
    func addUpdateTrip(parameters: TollRequestModel)
}

final class TripRemoteDataStore: TripRemoteDataStoreProtocol {

    weak var delegate: TripRemoteDataStoreDelegate?

    init(delegate: TripRemoteDataStoreDelegate? = nil) {
        self.delegate = delegate
    }

    func addUpdateTrip(parameters: TollRequestModel) {
        TollService.sharedInstance.addOrEditMyTrip(toll: parameters){ (response, error) in
            if error == nil{
                if let id = response as? String {
                    self.delegate?.didAddUpdateTrip(toll: parameters)
                }
            } else {
                self.delegate?.didFailWithError(error: error ?? CustomError.init(errorCode: 0, errorString: "Unknown error"))
            }
        }
    }
}

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
}

protocol TripRemoteDataStoreProtocol {
    var delegate: TripRemoteDataStoreDelegate? { get set }
    func addUpdateTrip(parameters: TollModel)
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
}

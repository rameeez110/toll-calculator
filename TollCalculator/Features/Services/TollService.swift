//
//  TollService.swift
//  TollCalculator
//
//  Created by Rameez Hasan on 01/04/2022.
//

import SwiftyJSON

class TollService {
    static let sharedInstance = TollService()
    
    func getTrips(completionHandler:@escaping (AnyObject?,CustomError?) -> Void)
    {
        var parameters = [String: AnyObject]()
    }
    func addOrEditMyTrip(toll: TollRequestModel,completionHandler:@escaping (AnyObject?,CustomError?) -> Void)
    {
        var path = Constants.Endpoint.getTrips
        var type = ApiType.Post
        if toll.id != "" {
            path = "\(Constants.Endpoint.getTrips)/\(toll.id)"
            type = .Put
        }
        NetworkManager.sharedInstance.sentRequestToServer(apiName: path, params: toll.dictionary, apiType: type,true, completionHandler: { (response) in
            
            switch(response){
            case .Success(let json):
                print("Success with JSON: \(String(describing: json))")
                let swiftyJson = JSON(json?.value as Any)
                if swiftyJson["failure"] != JSON.null {
                    let error = CustomError.init(errorCode: swiftyJson["code"].intValue, errorString: "APi Error")
                    error.errorString = swiftyJson["failure"].string ?? "Api Error"
                    completionHandler(nil,error)
                } else {
                    if let value = swiftyJson["success"].string{
                        completionHandler(value as AnyObject,nil)
                    }
                }
                break
            case .FailureDueToService(let error):
                completionHandler(nil,error)
                break
            case .Failure(_):
                let error2 = CustomError.init(errorCode: 250, errorString: "Failure")
                completionHandler(nil,error2)
                break
            }
        })
    }
}

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
        let parameters = [String: AnyObject]()
        NetworkManager.sharedInstance.sentRequestToServer(apiName: Constants.Endpoint.getTrips, params: parameters, apiType: ApiType.Get, completionHandler: { (response) in

            switch(response){
            case .Success(let json):
                print("Success with JSON: \(String(describing: json))")
                let swiftyJson = JSON(json?.value as Any)
                if swiftyJson.array?.count == 0 {
                    let error = CustomError.init(errorCode: swiftyJson["code"].intValue, errorString: "APi Error")
                    error.errorString = swiftyJson["message"].string ?? "Api Error"
                    completionHandler(nil,error)
                } else {
                    if let data = swiftyJson.array {
                        var array = [Trips]()
                        for each in data {
                            var tag = Trips()
                            if let value = each["totalCost"].string {
                                tag.totalCost = value
                            }
                            if let value = each["_id"].string{
                                tag.id = value
                            }
                            if let value = each["tripStatus"].string{
                                tag.tripStatus = TripStatus(rawValue: value) ?? .Completed
                            }
                            array.append(tag)
                        }
                        completionHandler(array as AnyObject,nil)
                    } else {
                        completionHandler("" as AnyObject,nil)
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
    func addOrEditMyTrip(toll: TollModel,completionHandler:@escaping (AnyObject?,CustomError?) -> Void)
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
                    if let value = swiftyJson["_id"].string{
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

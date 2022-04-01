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
        
//        NetworkManager.sharedInstance.sentRequestToServer(apiName: Constants.Endpoint.getTrips, params: parameters, apiType: ApiType.Get, completionHandler: { (response) in
//
//            switch(response){
//            case .Success(let json):
//                print("Success with JSON: \(String(describing: json))")
//                let swiftyJson = JSON(json?.value as Any)
//                if swiftyJson["failure"] != JSON.null {
//                    let error = CustomError.init(errorCode: swiftyJson["code"].intValue, errorString: "APi Error")
//                    error.errorString = swiftyJson["failure"].string ?? "Api Error"
//                    completionHandler(nil,error)
//                } else {
//                    let privacy = MyPrivacy()
//                    let userType = swiftyJson["whoCanSeeMyInfo"].intValue
//                    privacy.type = PrivacyTypes(rawValue: userType) ?? .OnlyMe
//                    privacy.id = swiftyJson["id"].stringValue
//                    privacy.userId = swiftyJson["userId"].stringValue
//                    privacy.appearInSuggestions = swiftyJson["appearInSuggestions"].boolValue
//
//                    if let value = swiftyJson["exceptionCount"].int {
//                        privacy.exceptionCount = value
//                    }
//                    if let value = swiftyJson["additionalCount"].int {
//                        privacy.additionalCount = value
//                    }
//                    if let value = swiftyJson["myPrivacyCustomizedArray"].array{
//                        var details = [MyPrivacyAdditionals]()
//                        for each in value {
//                            let detail = MyPrivacyAdditionals()
//                            let userType = each["type"].intValue
//                            detail.type = PrivacyViewTypes(rawValue: userType) ?? .Exceptions
//
//                            detail.id = each["id"].stringValue
//                            detail.userId = privacy.userId
//                            if let value = each["userId"].int{
//                                detail.userId = "\(value)"
//                            }
//                            if let value = each["myPrivacyId"].int {
//                                detail.myPrivacyId = "\(value)"
//                            }
//                            details.append(detail)
//                        }
//                        privacy.modelArray = details
//                    }
//                    completionHandler(privacy as AnyObject,nil)
//                }
//                break
//            case .FailureDueToService(let error):
//                completionHandler(nil,error)
//                break
//            case .Failure(_):
//                let error2 = CustomError.init(errorCode: 250, errorString: "Failure")
//                completionHandler(nil,error2)
//                break
//            }
//        })
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

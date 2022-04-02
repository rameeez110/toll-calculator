//
//  NetworkManager.swift
//  TollCalculator
//
//  Created by Rameez Hasan on 01/04/2022.
//

import Foundation
import Alamofire
import SwiftyJSON

typealias CompletionHandlerType1 = (Result1) -> Void
typealias CompletionHandlerType = (Result) -> Void
typealias CompletionHandler = (_ success:Bool,_ errorString: String?) -> Void

enum Result1 {
    case Success(AFDataResponse<Data?>)
    case FailureDueToService(CustomError)
    case Failure(CustomError)
}

enum Result {
    case Success(AFDataResponse<Any>?)
    case FailureDueToService(CustomError)
    case Failure(CustomError)
}

class NetworkManager: NSObject {
    
    static let sharedInstance = NetworkManager()
    var manager = Alamofire.Session.init()
    
    func sentRequestToServer(apiName: String, params: Any?, apiType : ApiType,_ bodyparam: Bool = false, completionHandler:@escaping CompletionHandlerType)
    {
        if let url =  URL.init(string: "\(Constants.API.baseURL)\(apiName)") {
            var request = URLRequest(url: url)
            self.sentRequestToServer(request : &request, apiName: apiName, params: params, apiType: apiType,bodyparam, completionHandler: completionHandler)
        }
    }
    
    func sentRequestToServer( request : inout URLRequest, apiName: String, params: Any?, apiType : ApiType,_ bodyparam: Bool = false, completionHandler:@escaping CompletionHandlerType)
    {
        let url =  URL.init(string: "\(Constants.API.baseURL)\(Constants.API.apiKey)\(apiName)")
        
        let param = params as? [String: Any]
        var arrayPrm = [AnyObject]()
        if let prm = params as? [AnyObject] {
            arrayPrm = prm
        }
        
        let headers: HTTPHeaders = [
            "access_token": ""
        ]
        
        print("Params: \(param)")
        if param == nil {
            print("Array Params: \(arrayPrm)")
        }
        print("URL: \(url as Any)")
        
        var methodType = HTTPMethod.post
        var methodString = "POST"
        switch apiType {
        case .Put:
            methodType = .put
            methodString = "PUT"
        case .Get:
            methodType = .get
            methodString = "GET"
        case .Delete:
            methodType = .delete
            methodString = "DELETE"
        default:
            methodType = .post
            methodString = "POST"
        }
        
        if bodyparam {
            var jsonData = try? JSONSerialization.data(withJSONObject: param ?? [String: AnyObject]())
            
            if param == nil {
                jsonData = try? JSONSerialization.data(withJSONObject: arrayPrm)
            }
            
            var request = URLRequest(url: url!)
            request.httpMethod = methodString
            request.addValue("application/json", forHTTPHeaderField: "Content-Type")
            request.httpBody = jsonData
            request.timeoutInterval = 50
            
            do {
                // make sure this JSON is in the format we expect
                if let json = try JSONSerialization.jsonObject(with: jsonData!, options: []) as? [String: Any] {
                    // try to read out a string array
                    print(json)
                }
            } catch let error as NSError {
                print("Failed to load: \(error.localizedDescription)")
            }
            
            AF.request(request).responseJSON {
                (response) in
                switch response.result
                {
                case .success(_):
                    print("Response of API: \(url!), \nPayload: \(response)")
                    completionHandler(Result.Success(response))
                case .failure(let error):
                    print("Failure of API: \(url!), \nPayload: \(error)")
                    completionHandler(Result.Failure(CustomError.init(errorCode: error.responseCode ?? 0, errorString: error.localizedDescription)))
                }
            }
        } else {
            AF.request(url!, method: methodType, parameters: param, headers: headers).validate(statusCode: 200..<300)
                .validate(contentType: ["application/json"])
                .responseJSON {(response) in
                    switch response.result
                    {
                    case .success(_):
                        print("Response of API: \(url!), \nPayload: \(response)")
                        completionHandler(Result.Success(response))
                    case .failure(let error):
                        print("Failure of API: \(url!), \nPayload: \(error)")
                        completionHandler(Result.Failure(CustomError.init(errorCode: error.responseCode ?? 0, errorString: error.localizedDescription)))
                    }
                }
        }
    }
}

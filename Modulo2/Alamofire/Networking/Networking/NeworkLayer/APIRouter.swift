//
//  APIRouter.swift
//  Networking
//
//  Created by Israel Torres Alvarado on 25/03/21.
//

import Foundation
import Alamofire

enum APIRouter: APIConfiguration {
    
    case covidInfo(_ country: String)
    case teams
    
    var method: HTTPMethod {
        switch self {
        case .covidInfo:
            return .get
        case .teams:
            return .get
        }
    }
    
    var path: String {
        switch self {
        case .covidInfo(let country):
            return "/v1/stats?country=\(country)"
        case .teams:
            return "/373be070-31f6-47b0-b333-e2b169753b7d"
        }
    }
    
    var parameters: RequestParams {
        switch self {
        case .covidInfo:
            return .url(["x-rapidapi-key":"21a50811d3msh1a576f0fa3c46a7p116485jsn5c9817617d48",
                         "x-rapidapi-host":"covid-19-coronavirus-statistics.p.rapidapi.com",
                         "useQueryString":"true"])
        case .teams:
            return .url([:])
        }
    }
    
    func asURLRequest() throws -> URLRequest {
        
        let url = try Constants.ProductionServer.baseURL.asURL()
        
        var urlRequest = URLRequest(url: url.appendingPathComponent(path))
        
        // HTTP Method
        urlRequest.httpMethod = method.rawValue
        
        // Common Headers
        urlRequest.setValue(ContentType.json.rawValue, forHTTPHeaderField: HTTPHeaderField.acceptType.rawValue)
        urlRequest.setValue(ContentType.json.rawValue, forHTTPHeaderField: HTTPHeaderField.contentType.rawValue)
        
        // Parameters
        switch parameters {
        
        case .body(let params):
            urlRequest.httpBody = try JSONSerialization.data(withJSONObject: params, options: [])
            
        case .url(let params):
            
            if params.count > 0 {
                
                let queryParams = params.map { pair  in
                    return URLQueryItem(name: pair.key, value: "\(pair.value)")
                }
                var components = URLComponents(string:url.appendingPathComponent(path).absoluteString)
                components?.queryItems = queryParams
                urlRequest.url = components?.url
                
            }
        }
        return urlRequest
    }
        
}

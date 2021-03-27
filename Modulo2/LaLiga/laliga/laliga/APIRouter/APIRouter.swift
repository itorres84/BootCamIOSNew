//
//  APIRouter.swift
//  CoreNetwork
//
//  Created by Israel Torres Alvarado on 26/03/21.
//

import Foundation
import Alamofire
import CoreNetwork

enum APIRouter: APIConfiguration {
    
    case teams
    case players
    case login
    
    var method: HTTPMethod {
        switch self {
        case .teams, .players:
            return .get
        case .login :
            return .post
        }
    }
    
    var path: String {
        switch self {
        case .teams:
            return "/373be070-31f6-47b0-b333-e2b169753b7d"
        case .players:
            return "/6fa00be6-cb23-4d59-acd6-49b559d535fa"
        case .login :
            return ""
        }
    }
    
    var parameters: CoreNetworkConstants.RequestParams {
        switch self {
        case .teams, .players:
            return .url([:])
        default:
            return .body([:])
        }
    }
    
    func asURLRequest() throws -> URLRequest {
        
        let url = try CoreNetworkConstants.ProductionServer.baseURL.asURL()
        
        var urlRequest = URLRequest(url: url.appendingPathComponent(path))
        
        // HTTP Method
        urlRequest.httpMethod = method.rawValue
        
        // Common Headers
        urlRequest.setValue(CoreNetworkConstants.ContentType.json.rawValue, forHTTPHeaderField: CoreNetworkConstants.HTTPHeaderField.acceptType.rawValue)
        urlRequest.setValue(CoreNetworkConstants.ContentType.json.rawValue, forHTTPHeaderField: CoreNetworkConstants.HTTPHeaderField.contentType.rawValue)
        
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

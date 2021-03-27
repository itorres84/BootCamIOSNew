//
//  CoreNetworkConstants.swift
//  CoreNetwork
//
//  Created by Israel Torres Alvarado on 26/03/21.
//

import Foundation
import Alamofire

public struct CoreNetworkConstants {
    
    public struct ProductionServer {
        public static var baseURL = "https://run.mocky.io/v3"
    }
    
    public enum HTTPHeaderField: String {
        case authentication = "Authorization"
        case contentType = "Content-Type"
        case acceptType = "Accept"
        case acceptEncoding = "Accept-Encoding"
        case x_rapidapi_key = "x-rapidapi-key"
        case x_rapidapi_host = "x-rapidapi-host"
        case useQueryString = "useQueryString"
        
    }
    
    public enum ContentType: String {
        case json = "Application/json"
        case formEncode = "application/x-www-form-urlencoded"
    }
    
    public enum RequestParams {
        case body(_:Parameters)
        case url(_:Parameters)
    }

}

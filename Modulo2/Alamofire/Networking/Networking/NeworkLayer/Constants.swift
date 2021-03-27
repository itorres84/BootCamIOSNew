//
//  Constants.swift
//  Networking
//
//  Created by Israel Torres Alvarado on 25/03/21.
//

import Foundation
import Alamofire

struct Constants {
    struct ProductionServer {
        static let baseURL = "https://run.mocky.io/v3"
    }
}

enum HTTPHeaderField: String {
    case authentication = "Authorization"
    case contentType = "Content-Type"
    case acceptType = "Accept"
    case acceptEncoding = "Accept-Encoding"
    case x_rapidapi_key = "x-rapidapi-key"
    case x_rapidapi_host = "x-rapidapi-host"
    case useQueryString = "useQueryString"
    
}

enum ContentType: String {
    case json = "Application/json"
    case formEncode = "application/x-www-form-urlencoded"
}

enum RequestParams {
    case body(_:Parameters)
    case url(_:Parameters)
}

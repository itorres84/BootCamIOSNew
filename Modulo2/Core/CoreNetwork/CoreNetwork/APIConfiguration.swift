//
//  APIConfiguration.swift
//  CoreNetwork
//
//  Created by Israel Torres Alvarado on 26/03/21.
//

import Foundation
import Alamofire

public protocol APIConfiguration: URLRequestConvertible {
    var method: HTTPMethod { get }
    var path: String { get }
    var parameters: CoreNetworkConstants.RequestParams { get }
}

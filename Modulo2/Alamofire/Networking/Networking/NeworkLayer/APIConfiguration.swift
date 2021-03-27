//
//  APIConfiguration.swift
//  Networking
//
//  Created by Israel Torres Alvarado on 26/03/21.
//

import Foundation
import Alamofire

protocol APIConfiguration: URLRequestConvertible {
    var method: HTTPMethod { get }
    var path: String { get }
    var parameters: RequestParams { get }
}

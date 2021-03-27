//
//  APIClient.swift
//  CoreNetwork
//
//  Created by Israel Torres Alvarado on 26/03/21.
//

import Foundation
import Alamofire

public class APIClient {
    
    public static func performRequest<T:Decodable>(route: APIConfiguration, decoder: JSONDecoder = JSONDecoder(), completion:@escaping (Result<T, AFError>)->Void) {
        
        AF.request(route).responseDecodable(of: T.self) { (response) in
            completion(response.result)
        }
    }
    
}

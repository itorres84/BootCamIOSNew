//
//  NetworkManager.swift
//  TeamsFootball
//
//  Created by Israel Torres Alvarado on 18/03/21.
//

import Foundation

protocol NetworkManager {
    func getTeams(completion: @escaping ([Team]) -> ())
}

enum httpMethod: String {
    case GET
    case POST
}

class NetworkManagerImp: NetworkManager {
    
    let teams = [Team(name: "Atletico de Madrid", imageName: "Atletico de Madrid", type: "large"),
                 Team(name: "Barcelona", imageName: "Barcelona", type: "small"),
                 Team(name: "Deportivo de la Coruña", imageName: "Deportivo de la Coruña", type: "small"),
                 Team(name: "Las Palmas", imageName: "Las Palmas", type: "large"),
                 Team(name: "Malaga", imageName: "Malaga", type: "small")]
    
    
    func getTeams(completion: @escaping ([Team]) -> ()) {
        
        guard let url = URL(string: "https://run.mocky.io/v3/373be070-31f6-47b0-b333-e2b169753b7d") else {
            return
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = httpMethod.GET.rawValue
        
        let session = URLSession.shared
        
        let task = session.dataTask(with: request) { (data, response, error) in
            
            if let error = error {
                print(error.localizedDescription)
            } else if let data = data {
                
//                let decoder = JSONDecoder()
//
//                do {
//                    let teams = try decoder.decode([Team].self, from: data)
//                    print(teams)
//                } catch {
//                    print(error.localizedDescription)
//                }
                
                if let json = try? JSONSerialization.jsonObject(with: data, options: []) as? [String: Any],
                   let teamsDic = json["teams"] as? [[String: Any]] {
                   completion(teamsDic.map({Team(team: $0)}))
                }
                
            } else {
                completion(self.teams)
            }
            
        }
        
        task.resume()
        
    }
            
}

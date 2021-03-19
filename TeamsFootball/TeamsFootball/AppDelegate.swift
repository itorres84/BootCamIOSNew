//
//  AppDelegate.swift
//  TeamsFootball
//
//  Created by Israel Torres Alvarado on 17/03/21.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    let storage = StorageManagerImp()
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        if storage.getTeams().count == 0 {
           storage.saveTeams(teams: createTeams())
        }
    
        return true
    }
    
    func createTeams() -> [Team] {
       
        let teams = [Team(name: "Atletico de Madrid", imageName: "Atletico de Madrid", type: "large"),
                     Team(name: "Barcelona", imageName: "Barcelona", type: "small"),
                     Team(name: "Deportivo de la Coruña", imageName: "Deportivo de la Coruña", type: "small"),
                     Team(name: "Las Palmas", imageName: "Las Palmas", type: "large"),
                     Team(name: "Malaga", imageName: "Malaga", type: "small")]
        
        return teams
        
    }

    // MARK: UISceneSession Lifecycle

    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        // Called when a new scene session is being created.
        // Use this method to select a configuration to create the new scene with.
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }

    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
        // Called when the user discards a scene session.
        // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
        // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
    }


}


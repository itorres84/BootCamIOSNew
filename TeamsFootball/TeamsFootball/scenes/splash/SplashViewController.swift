//
//  SplashViewController.swift
//  TeamsFootball
//
//  Created by Israel Torres Alvarado on 18/03/21.
//

import UIKit

class SplashViewController: UIViewController {
    
    let viewModel = SplashViewModel(repository: SplashRepositoryImp(networkManager: NetworkManagerImp(), storageManager: StorageManagerImp()))
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)

        viewModel.syncTeams { [weak self] (response) in
            
            guard let self = self else { return }
            
            if response {
                DispatchQueue.main.async {
                    self.performSegue(withIdentifier: "goToHome", sender: nil)
                }
            }
        }
    }

}

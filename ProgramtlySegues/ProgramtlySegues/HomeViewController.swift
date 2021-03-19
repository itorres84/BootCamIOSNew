//
//  HomeViewController.swift
//  ProgramtlySegues
//
//  Created by Israel Torres Alvarado on 11/03/21.
//

import UIKit

class HomeViewController: UIViewController {

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .blue
        title = "Inicio"
    }
    
    
    @IBAction func goToDetail(_ sender: UIButton) {
        
        if let nav = self.navigationController {
            nav.pushViewController(HomeDetailViewController(), animated: true)
        }
        
        
        //self.present(HomeDetailViewController(), animated: true, completion: nil)
        
    }
    
}

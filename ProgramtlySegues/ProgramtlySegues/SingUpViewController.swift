//
//  SingUpViewController.swift
//  ProgramtlySegues
//
//  Created by Israel Torres Alvarado on 10/03/21.
//

import UIKit

class SingUpViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "Registro"
    
    }
            
    @IBAction func goBack(_ sender: UIButton) {
        
        navigationController?.popViewController(animated: true)
        
    }
    
}

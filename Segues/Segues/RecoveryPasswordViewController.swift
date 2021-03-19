//
//  RecoveryPasswordViewController.swift
//  Segues
//
//  Created by Israel Torres Alvarado on 09/03/21.
//

import UIKit

class RecoveryPasswordViewController: UIViewController {
    
    @IBOutlet weak var txtEmail: UITextField!
    
    var email: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        if let em = self.email {
            txtEmail.text = em
        }
    
    }

}

//
//  LoginViewController.swift
//  TableSimple
//
//  Created by Israel Torres Alvarado on 12/03/21.
//

import UIKit

class LoginViewController: UIViewController {
    
    @IBOutlet weak var txtEmail: UITextField!
    @IBOutlet weak var TxtPassword: UITextField!
    
    let userRepository =  UserRepository(storgeManager: StorageManagerImp())
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func login(_ sender: UIButton) {
        
        guard let textEmail = txtEmail.text, let textPassword = TxtPassword.text else {
            return
        }
        
        if userRepository.login(email: textEmail, password: textPassword) {
            dismiss(animated: true)
        }
    
    }
    
}

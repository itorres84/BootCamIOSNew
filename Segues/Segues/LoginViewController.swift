//
//  ViewController.swift
//  Segues
//
//  Created by Israel Torres Alvarado on 09/03/21.
//

import UIKit

class LoginViewController: UIViewController {

    @IBOutlet weak var txtEmail: UITextField!
    @IBOutlet weak var txtPassword: UITextField!
    
    let userRepository = UserRepository()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
          
        if let identifier = segue.identifier,
               identifier.elementsEqual("goToHome") {
            return
        }
        
        guard let text = txtEmail.text,
              !text.isEmpty,
              let identifier = segue.identifier,
              identifier.elementsEqual("passwordRecovery"),
              let recoveryPasswordVC = segue.destination as? RecoveryPasswordViewController else {
            
            print("las condiciones no se cumplen..")
            
            return
        
        }
        
        recoveryPasswordVC.email = text
                        
    }
    
    @IBAction func SingIn(_ sender: UIButton) {
            
        guard let email = txtEmail.text, let password = txtPassword.text else {
            return
        }
        
        if userRepository.login(userParam: email , passwordParam: password) {
            performSegue(withIdentifier: "goToHome", sender: nil)
        }
        
    }
    
}


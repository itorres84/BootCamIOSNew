//
//  ViewController.swift
//  LoginFacebook
//
//  Created by Israel Torres Alvarado on 13/04/21.
//

import UIKit
import FBSDKLoginKit

class ViewController: UIViewController {

    @IBOutlet weak var lblOther: UILabel!
    
    private lazy var loginButton: FBLoginButton = {
        let button = FBLoginButton()
        button.permissions = ["public_profile", "email"]
        button.delegate = self
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupLoginButton()
        
        if let token = AccessToken.current, !token.isExpired {
            print(token)
            performSegue(withIdentifier: "goToHome", sender: nil)
        }
        
      
        
    }
    
    private func setupLoginButton() {
        
        view.addSubview(loginButton)
        NSLayoutConstraint.activate([
            loginButton.topAnchor.constraint(equalTo: lblOther.bottomAnchor, constant: 20),
            loginButton.leftAnchor.constraint(equalTo: view.layoutMarginsGuide.leftAnchor, constant: 20),
            loginButton.rightAnchor.constraint(equalTo: view.layoutMarginsGuide.rightAnchor, constant: -20),
            loginButton.heightAnchor.constraint(equalToConstant: 50)
        ])
    
    }

}

extension ViewController: LoginButtonDelegate {
   
    func loginButtonDidLogOut(_ loginButton: FBLoginButton) {
        
        print("logOut")
        
    }
    
    func loginButton(_ loginButton: FBLoginButton, didCompleteWith result: LoginManagerLoginResult?, error: Error?) {
        
        if let err = error {
            print(err.localizedDescription)
            return
        }
        
        guard let _ = result?.authenticationToken else {
            return
        }
        performSegue(withIdentifier: "goToHome", sender: nil)
        
    }
    
}


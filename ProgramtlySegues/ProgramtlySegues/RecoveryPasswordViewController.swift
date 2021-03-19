//
//  RecoveryPasswordViewController.swift
//  ProgramtlySegues
//
//  Created by Israel Torres Alvarado on 10/03/21.
//

import UIKit

class RecoveryPasswordViewController: UIViewController {

    private lazy var txtEmail: UITextField = {
        let email = UITextField()
        email.translatesAutoresizingMaskIntoConstraints = false
        email.placeholder = "Email"
        email.keyboardType = .emailAddress
        email.backgroundColor = UIColor.gray
        return email
    }()
    
    private lazy var btnRecovery: UIButton = {
      
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.backgroundColor = .blue
        button.setTitle("Recuperar contraseña", for: .normal)
        button.setTitleColor(.white, for: .normal)
        //button.addTarget(self, action: #selector(TapButtonAction(_:)), for: .touchUpInside)
        button.tag = 1
        return button
    }()
    
    var email: String?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        title = "Recuperacion Contraseña"
        view.addSubview(txtEmail)
        view.addSubview(btnRecovery)
        
        if let em = email {
           txtEmail.text = em
        }
        
        addConstraints()
    }
    
    func addConstraints() {
        
        let layaout = view.layoutMarginsGuide
        
        NSLayoutConstraint.activate([
            txtEmail.topAnchor.constraint(equalTo: layaout.topAnchor, constant: 100),
            txtEmail.leftAnchor.constraint(equalTo: layaout.leftAnchor),
            txtEmail.rightAnchor.constraint(equalTo: layaout.rightAnchor),
            txtEmail.heightAnchor.constraint(equalToConstant: 50)
        ])
        
        NSLayoutConstraint.activate([
            btnRecovery.bottomAnchor.constraint(equalTo: layaout.bottomAnchor, constant: -100),
            btnRecovery.leftAnchor.constraint(equalTo: layaout.leftAnchor),
            btnRecovery.rightAnchor.constraint(equalTo: layaout.rightAnchor),
            btnRecovery.heightAnchor.constraint(equalToConstant: 50)
        ])
        
    }
    
}

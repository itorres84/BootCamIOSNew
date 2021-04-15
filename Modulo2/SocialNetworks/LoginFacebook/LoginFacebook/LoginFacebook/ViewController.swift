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
            getInfoUser(token: token.tokenString) { (profile) in
                self.performSegue(withIdentifier: "goToHome", sender: profile)
            }
        
        }
        
    }
    
    
    private func getInfoUser(token: String, clousure: @escaping (Profile) -> Void ) {
        
        
        let request = FBSDKLoginKit.GraphRequest(graphPath: "me",
                                                 parameters: ["fields" : "id,email,picture{url},name"],
                                                 tokenString: token,
                                                 version: nil, httpMethod: .get)
        
        request.start { (conn, result, error) in
            
            if let err = error {
                debugPrint(err.localizedDescription)
                return
            }
            
            if let response = result as? [String: Any] {
            
                dump(response)
                do {
                    
                    let profile = try DictionaryDecoder().decode(Profile.self, from: response)
                    
                    dump(profile)
                    
                    clousure(profile)
                    
                } catch {
                    
                    debugPrint(error.localizedDescription)
                    
                }
                
            }
            
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
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if let identifier = segue.identifier,
           identifier.elementsEqual("goToHome"),
           let destination = segue.destination as? UITabBarController,
           let home = destination.viewControllers?.first as? HomeViewController,
           let profile = sender as? Profile {
        
           home.profile = profile
            
        }
        
    }

}

extension ViewController: LoginButtonDelegate {
   
    func loginButtonDidLogOut(_ loginButton: FBLoginButton) {
        
        print("logOut")
        
    }
    
    func loginButton(_ loginButton: FBLoginButton, didCompleteWith result: LoginManagerLoginResult?, error: Error?) {
        
        guard let token = result?.token else {
            return
        }
        
        getInfoUser(token: token.tokenString) { (profile) in
            self.performSegue(withIdentifier: "goToHome", sender: profile)
        }
        
    }
    
}

class DictionaryDecoder {

    private let decoder = JSONDecoder()

    var dateDecodingStrategy: JSONDecoder.DateDecodingStrategy {
        set { decoder.dateDecodingStrategy = newValue }
        get { return decoder.dateDecodingStrategy }
    }

    var dataDecodingStrategy: JSONDecoder.DataDecodingStrategy {
        set { decoder.dataDecodingStrategy = newValue }
        get { return decoder.dataDecodingStrategy }
    }

    var nonConformingFloatDecodingStrategy: JSONDecoder.NonConformingFloatDecodingStrategy {
        set { decoder.nonConformingFloatDecodingStrategy = newValue }
        get { return decoder.nonConformingFloatDecodingStrategy }
    }

    var keyDecodingStrategy: JSONDecoder.KeyDecodingStrategy {
        set { decoder.keyDecodingStrategy = newValue }
        get { return decoder.keyDecodingStrategy }
    }

    func decode<T>(_ type: T.Type, from dictionary: [String: Any]) throws -> T where T : Decodable {
        let data = try JSONSerialization.data(withJSONObject: dictionary, options: [])
        return try decoder.decode(type, from: data)
    }
}



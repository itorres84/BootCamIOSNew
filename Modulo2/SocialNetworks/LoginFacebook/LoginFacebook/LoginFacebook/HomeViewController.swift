//
//  HomeViewController.swift
//  LoginFacebook
//
//  Created by Israel Torres Alvarado on 14/04/21.
//

import UIKit
import Alamofire

class HomeViewController: UIViewController {

    
    @IBOutlet weak var pictureProfile: UIImageView!{
        didSet {
            pictureProfile.layer.cornerRadius = 25
            pictureProfile.clipsToBounds = true
        }
    }
    
    
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var email: UILabel!
    
    var profile: Profile?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        guard let user = profile else {
            return
        }
        
        name.text = user.name
        email.text = user.email
        
        AF.request(user.picture.data.url, method: .get).response { (response) in
            
            switch response.result {
                
            case .failure(let error):
                print(error.localizedDescription)
            case .success(let data):
                guard let image = data else {
                    return
                }
                self.pictureProfile.image = UIImage(data: image)
            }
            
        }
        
    }

}

//
//  TeamDetailViewController.swift
//  TableSimple
//
//  Created by Israel Torres Alvarado on 16/03/21.
//

import UIKit

class TeamDetailViewController: UIViewController {

    @IBOutlet weak var teamImage: UIImageView!
    @IBOutlet weak var teamTitle: UILabel!
    @IBOutlet weak var teamDescription: UITextView!
    
    var teamSegue: Team?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let team = teamSegue {
        
            teamImage.image = UIImage(named: team.nameImage)
            teamTitle.text = team.name
            teamTitle.isHidden = true
            teamDescription.text = team.description
            
            title = team.name
            
        }
    
    }
    
}

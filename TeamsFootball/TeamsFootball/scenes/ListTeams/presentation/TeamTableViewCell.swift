//
//  TeamTableViewCell.swift
//  TeamsFootball
//
//  Created by Israel Torres Alvarado on 17/03/21.
//

import UIKit

class TeamTableViewCell: UITableViewCell {
    
    @IBOutlet weak var imageContent: UIImageView!
    @IBOutlet weak var lblName: UILabel!
    
    func configure(_ model: TeamViewData) {
    
        imageContent.image = UIImage(named: model.imageName)
        lblName.text = model.name
        
    }
    
}

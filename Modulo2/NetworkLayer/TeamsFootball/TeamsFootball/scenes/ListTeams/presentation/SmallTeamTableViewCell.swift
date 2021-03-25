//
//  SmallTeamTableViewCell.swift
//  TeamsFootball
//
//  Created by Israel Torres Alvarado on 17/03/21.
//

import UIKit

class SmallTeamTableViewCell: UITableViewCell {

    @IBOutlet weak var contentImage: UIImageView!
    @IBOutlet weak var lblTitle: UILabel!
    
    func configure(_ model: TeamViewData) {
            
        contentImage.image = UIImage(named: model.imageName)
        lblTitle.text = model.name
        
    }

}

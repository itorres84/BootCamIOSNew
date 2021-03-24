//
//  ViewController.swift
//  UIComponets
//
//  Created by Israel Torres Alvarado on 02/03/21.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var imageHeader: UIImageView!
    
    let imageRepository = ImageRepository()
    
    //1. Crear
    lazy var imageViewBottom: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.backgroundColor = .black
        imageView.image = UIImage(named: "pacman2")
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        imageHeader.backgroundColor = .blue
        imageHeader.layer.cornerRadius = 185
        
        //2. agregarlo a la vista padre
        view.addSubview(imageViewBottom)
        addConstraintsImageBootom()
        
    }
    
    func addConstraintsImageBootom()  {
           
        //2. agregar constraints
        let layautMargin = view.layoutMarginsGuide
        
        NSLayoutConstraint.activate([
            
            imageViewBottom.bottomAnchor.constraint(equalTo: layautMargin.bottomAnchor),
            imageViewBottom.widthAnchor.constraint(equalToConstant: 200),
            imageViewBottom.heightAnchor.constraint(equalToConstant: 200),
            imageViewBottom.centerXAnchor.constraint(equalTo: layautMargin.centerXAnchor)
        ])
        
    }
    
    @IBAction func getImageRemote(_ sender: Any) {
        let image = UIImage(named: imageRepository.getNameImage())
        imageHeader.image = image
    }

}


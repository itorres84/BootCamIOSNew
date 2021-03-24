//
//  ViewController.swift
//  HelloWord
//
//  Created by Israel Torres Alvarado on 26/02/21.
//

import UIKit

/*
 //MVC
 
 //VIPER
 //MVP
 //MVVM
 //CLEAN ARCHITECTURE

CAPAS DE PATRON DE DISEÑO MVC
 
• Model
• View
• Controller
  
 */
//CAPA CONTROLADOR
class ViewController: UIViewController {

    //Ejemplo de uso de optionales
    ///@IBOutlet weak var lblNameScreenDos: UILabel!
    
    @IBOutlet weak var lblNameScreen: UILabel!
    @IBOutlet weak var btnGetNameScreen: UIButton!
    
    //var lblHeader: UILabel!
    //Crear un label de forma programatica.
    lazy var lblHeader: UILabel = {
        let label = UILabel()
        label.backgroundColor = .cyan
        label.text = "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum."
        label.textAlignment = .justified
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    lazy var textView: UITextView = {
        let text = UITextView()
        text.backgroundColor = .cyan
        text.text = "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum. \n Contrary to popular belief, Lorem Ipsum is not simply random text. It has roots in a piece of classical Latin literature from 45 BC, making it over 2000 years old. Richard McClintock, a Latin professor at Hampden-Sydney College in Virginia, looked up one of the more obscure Latin words, consectetur, from a Lorem Ipsum passage, and going through the cites of the word in classical literature, discovered the undoubtable source. Lorem Ipsum comes from sections 1.10.32 and 1.10.33 of de Finibus Bonorum et Malorum (The Extremes of Good and Evil) by Cicero, written in 45 BC. This book is a treatise on the theory of ethics, very popular during the Renaissance. The first line of Lorem Ipsum, Lorem ipsum dolor sit amet.., comes from a line in section 1.10.32. The standard chunk of Lorem Ipsum used since the 1500 is reproduced below for those interested. Sections 1.10.32 and 1.10.33 from de Finibus Bonorum et Malorum by Cicero are also reproduced in their exact original form, accompanied by English versions from the 1914 translation by H. Rackham. \n Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum. \n Contrary to popular belief, Lorem Ipsum is not simply random text. It has roots in a piece of classical Latin literature from 45 BC, making it over 2000 years old. Richard McClintock, a Latin professor at Hampden-Sydney College in Virginia, looked up one of the more obscure Latin words, consectetur, from a Lorem Ipsum passage, and going through the cites of the word in classical literature, discovered the undoubtable source. Lorem Ipsum comes from sections 1.10.32 and 1.10.33 of de Finibus Bonorum et Malorum (The Extremes of Good and Evil) by Cicero, written in 45 BC. This book is a treatise on the theory of ethics, very popular during the Renaissance. The first line of Lorem Ipsum, Lorem ipsum dolor sit amet.., comes from a line in section 1.10.32. The standard chunk of Lorem Ipsum used since the 1500 is reproduced below for those interested. Sections 1.10.32 and 1.10.33 from de Finibus Bonorum et Malorum by Cicero are also reproduced in their exact original form, accompanied by English versions from the 1914 translation by H. Rackham."
        text.textAlignment = .justified
        text.translatesAutoresizingMaskIntoConstraints = false
        return text
    }()
    
    lazy var btnShowText: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Get name screen", for: .normal)
        button.backgroundColor = UIColor.black
        //button.titleLabel?.textColor = UIColor.white
        button.tintColor = UIColor.white
        button.layer.cornerRadius = 20
        button.clipsToBounds = true
        return button
    }()

    let repository = Repository()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        view.addSubview(lblHeader)
        view.addSubview(textView)
        view.addSubview(btnShowText)
        //lblNameScreenDos.text = "dsdhsds.."
        //setLabelConstraints()
        setLabelConstraintsDos()
       
        btnShowText.addTarget(self, action: #selector(self.pressed(sender:)), for: .touchUpInside)
    
    }
    
    @objc func pressed(sender: UIButton!) {
        
        guard let nameScreen: String = repository.getNameOfScreenOptional() else {
            return
        }
        
        lblHeader.text = nameScreen
    
    }

    //Forma uno
    func setLabelConstraints() {
        let horizontalConstraint = NSLayoutConstraint(item: lblHeader, attribute: NSLayoutConstraint.Attribute.centerX, relatedBy: NSLayoutConstraint.Relation.equal, toItem: view, attribute: NSLayoutConstraint.Attribute.centerX, multiplier: 1, constant: 0)
        
        let verticalConstraint = NSLayoutConstraint(item: lblHeader, attribute: NSLayoutConstraint.Attribute.top, relatedBy: NSLayoutConstraint.Relation.equal, toItem: btnGetNameScreen, attribute: NSLayoutConstraint.Attribute.bottom, multiplier: 1, constant: 10)
        
        let widthConstraint = NSLayoutConstraint(item: lblHeader, attribute: NSLayoutConstraint.Attribute.width, relatedBy: NSLayoutConstraint.Relation.equal, toItem: nil, attribute: NSLayoutConstraint.Attribute.notAnAttribute, multiplier: 1, constant: 200)
        
        let heightConstraint = NSLayoutConstraint(item: lblHeader, attribute: NSLayoutConstraint.Attribute.height, relatedBy: NSLayoutConstraint.Relation.equal, toItem: nil, attribute: NSLayoutConstraint.Attribute.notAnAttribute, multiplier: 1, constant: 50)
        NSLayoutConstraint.activate([horizontalConstraint, verticalConstraint, widthConstraint, heightConstraint])
    }
    
    //Forma dos
    func setLabelConstraintsDos() {
        
        let layoutMarginsGuide = view.safeAreaLayoutGuide
        NSLayoutConstraint.activate([
            lblHeader.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -10),
            lblHeader.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 10),
            lblHeader.topAnchor.constraint(equalTo: btnGetNameScreen.bottomAnchor, constant: 200),
            lblHeader.bottomAnchor.constraint(equalTo: layoutMarginsGuide.bottomAnchor, constant: 0)
        ])
        
        NSLayoutConstraint.activate([
            textView.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -10),
            textView.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 10),
            textView.topAnchor.constraint(equalTo: layoutMarginsGuide.topAnchor, constant: 0),
            textView.bottomAnchor.constraint(equalTo: lblNameScreen.topAnchor, constant: 0)
        ])
        
        NSLayoutConstraint.activate([
            btnShowText.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -10),
            btnShowText.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 10),
            btnShowText.topAnchor.constraint(equalTo: btnGetNameScreen.bottomAnchor, constant: 10),
            btnShowText.heightAnchor.constraint(equalToConstant: 50)
        ])
    }
    
    func getNameOfScreen() {
        //CAPA DE VISTA(VIEW)
        lblNameScreen.text = repository.getNameOfScrenn()
    }
    
    @IBAction func getNameScreen(_ sender: UIButton) {
        getNameOfScreen()
    }
    
}


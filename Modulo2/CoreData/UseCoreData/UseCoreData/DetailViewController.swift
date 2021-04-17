//
//  DetailViewController.swift
//  UseCoreData
//
//  Created by Israel Torres Alvarado on 16/04/21.
//

import UIKit

class DetailViewController: UIViewController {
    
    
    @IBOutlet weak var txtName: UITextField!
    @IBOutlet weak var txtTelephone: UITextField!
    
    var name: String?
    var telephone: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Detail People"
        txtName.text = name
        txtTelephone.text = telephone
    
    }
    
    @IBAction func edit(_ sender: UIButton) {
        
        
        
        
    }
    
    @IBAction func deletePerson(_ sender: UIButton) {
    
    
        
        
    }
    
}

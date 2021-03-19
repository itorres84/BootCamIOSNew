//
//  HomeViewController.swift
//  Segues
//
//  Created by Israel Torres Alvarado on 09/03/21.
//

import UIKit

class RegistroViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func back(_ sender: Any) {
//        dismiss(animated: true) {
//            print("se elimino la pantalla")
//        }
        
        self.navigationController?.popViewController(animated: true)
    
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    

}

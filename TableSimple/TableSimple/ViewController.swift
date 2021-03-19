//
//  ViewController.swift
//  TableSimple
//
//  Created by Israel Torres Alvarado on 12/03/21.
//

import UIKit

class ViewController: UIViewController {
   
    @IBOutlet weak var tableView: UITableView! {
        didSet {
            tableView.dataSource = self
            tableView.delegate = self
        }
    }
    
    var teams: [[String: Any]] = []
    var sesionName: String?
    
    let userRepository =  UserRepository(storgeManager: StorageManagerImp())
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let teamsOne: [String: Any] =
            [ "division" : "Primera division",
              "teams": [Team(name: "Atletico de Madrid", nameImage: "Atletico de Madrid"),
                        Team(name: "Barcelona", nameImage: "Barcelona"),
                        Team(name: "Deportivo de la Coruña", nameImage: "Deportivo de la Coruña"),
                        Team(name: "Las Palmas", nameImage: "Las Palmas"),
                        Team(name: "Malaga", nameImage: "Malaga")]]
        
        let teamsTwo: [String: Any] =
            [ "division" : "Segunda division",
              "teams": [Team(name: "Malaga", nameImage: "Malaga"),
                        Team(name: "Rayo Vallecano", nameImage: "Rayo Vallecano"),
                        Team(name: "Sporting", nameImage: "Sporting"),
                        Team(name: "Real Sociedad", nameImage: "Real Sociedad"),
                        Team(name: "Espanyol", nameImage: "Espanyol")]]
        
        teams = [teamsOne, teamsTwo]
        
        //teams = ["", "", "", "", "", "Mallorca", "Valladolid", "Eibar",  "Ponferradina", "Albacete"]
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        self.sesionName = userRepository.getNameUser()
        
        guard let name = sesionName else {
            performSegue(withIdentifier: "goToLogin", sender: nil)
            return
        }
        
        userAuthOk(name: name)
        
    }
    
    func userAuthOk(name: String)  {
        
        let alert = UIAlertController(title: "Sesion OK", message: "Hola \(name) Bienvenido", preferredStyle: .alert)

        alert.addAction(UIAlertAction(title: "ok", style: .default, handler: nil))
    
        self.present(alert, animated: true)
    
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if let detailVC = segue.destination as? TeamDetailViewController, let team = sender as? Team {
            detailVC.teamSegue = team
        }

    }
        
}

extension ViewController: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return teams.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if let teams = teams[section]["teams"] as? [Team] {
            return teams.count
        } else {
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    
        print("Seccion: \(indexPath.section) row: \(indexPath.row)")
        
        let cell: UITableViewCell = UITableViewCell(style: UITableViewCell.CellStyle.subtitle, reuseIdentifier: "mycell")
        
        cell.accessoryType = .disclosureIndicator
        
        if let teams = teams[indexPath.section]["teams"] as? [Team] {
            let team = teams[indexPath.row]
            cell.textLabel?.text  = team.name
            cell.imageView?.image = UIImage(named: team.nameImage)
            
        }
        
        return cell
    
    }
    
}

extension ViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        
        let lblTitleHeader = UILabel()
        lblTitleHeader.textColor = .white
        lblTitleHeader.backgroundColor = .blue
        if let title = teams[section]["division"] as? String {
            lblTitleHeader.text = title
        }
        return lblTitleHeader
            
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 50.0
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        print("Seccion: \(indexPath.section) row: \(indexPath.row)")
        if let teamsSeccion = teams[indexPath.section]["teams"] as? [Team] {
            
            let team = teamsSeccion[indexPath.row]
            print("Team name: \(team.name), image: \(team.nameImage)")
            performSegue(withIdentifier: "goToDetail", sender: team)
            
        }
        
    }
    
}


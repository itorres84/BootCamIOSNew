//
//  ViewController.swift
//  laliga
//
//  Created by Israel Torres Alvarado on 26/03/21.
//

import UIKit

class ListTeamsViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView! {
        didSet {
            tableView.dataSource = self
        }
    }
    
    let presenter = ListTeamsPresenter()
    
    var teams: [TeamViewData] = [] {
        didSet {
            tableView.reloadData()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter.stateDelegate = self
    }
    
}

extension ListTeamsViewController: UITableViewDataSource {
   
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return teams.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        cell.textLabel?.text = teams[indexPath.row].name
        cell.imageView?.image = teams[indexPath.row].image
        return cell
    }
    
}


extension ListTeamsViewController: ListTeamsPresenterOutput {
    
    func setState(state: stateTeamsPresenter) {
        
        switch state {
        case .loadig:
            print("ShowLoading..")
        case .setData(let models):
            self.teams = models
        }
        
    }

}


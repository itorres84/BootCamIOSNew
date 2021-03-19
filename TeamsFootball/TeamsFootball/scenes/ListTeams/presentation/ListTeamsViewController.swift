//
//  ListTeamsViewController.swift
//  TeamsFootball
//
//  Created by Israel Torres Alvarado on 17/03/21.
//

import UIKit

class ListTeamsViewController: UIViewController {

    private let nameCell = "cell"
    private let smallCell = "smallCell"
    
    private lazy var tableView: UITableView = {
        let table = UITableView()
        table.translatesAutoresizingMaskIntoConstraints = false
        let bundle = Bundle(for: ListTeamsViewController.self)
        table.register(UINib(nibName: "TeamTableViewCell", bundle: bundle), forCellReuseIdentifier: nameCell)
        table.register(UINib(nibName: "SmallTeamTableViewCell", bundle: bundle), forCellReuseIdentifier: smallCell)
        table.dataSource = self
        return table
    }()
    
    let viewModel: ListTeamsViewModel = ListTeamsViewModel(listRepository: ListRepositoryImp(storage: StorageManagerImp()))
    
    var teams: [TeamViewData] = [] {
        didSet {
            tableView.reloadData()
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(tableView)
        setConstraints()
        fetchData()
    }
    
    func fetchData() {
        self.teams = viewModel.getTeams()
    }

    func setConstraints() {
        
        let layaotMargin = view.layoutMarginsGuide
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: layaotMargin.topAnchor),
            tableView.leftAnchor.constraint(equalTo: layaotMargin.leftAnchor),
            tableView.rightAnchor.constraint(equalTo: layaotMargin.rightAnchor),
            tableView.bottomAnchor.constraint(equalTo: layaotMargin.bottomAnchor)
        ])
    }

}
extension ListTeamsViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return teams.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let team = teams[indexPath.row]
        
        switch team.type {
        case .large:
            
            guard let cell = tableView.dequeueReusableCell(withIdentifier: nameCell, for: indexPath) as? TeamTableViewCell else {
                return UITableViewCell()
            }
            
            cell.configure(teams[indexPath.row])
            return cell
            
        case .small:
            
            guard let cell = tableView.dequeueReusableCell(withIdentifier: smallCell, for: indexPath) as? SmallTeamTableViewCell else {
                return UITableViewCell()
            }
            
            cell.configure(teams[indexPath.row])
            return cell
            
        default:
            return UITableViewCell()
        }
        
    }
    
}

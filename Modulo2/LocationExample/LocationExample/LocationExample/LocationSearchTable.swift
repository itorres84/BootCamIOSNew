//
//  LocationSearchTable.swift
//  LocationExample
//
//  Created by Israel Torres Alvarado on 07/04/21.
//

import UIKit
import MapKit


// MARK: Protocolos
protocol Cart: Any {
    
    var ruedas: Int { get set }
    var puertas: Int { get }
    
    var color: String { get set }
    func acelerar()
}

extension Cart {
    var color: String  {
        get { return "default color" } set {}
    }
}

struct FordCart: Cart {

    var ruedas: Int
    var puertas: Int
    
    var seguro: Bool = false
    
    init(ruedas: Int, puertas: Int) {
        self.ruedas = ruedas
        self.puertas = puertas
    }
    
    func acelerar() {
        print("ford.. acelera")
    }
}

class AudiCart: Cart {
    
    var ruedas: Int
    var puertas: Int
    
    init(ruedas: Int, puertas: Int) {
        self.ruedas = ruedas
        self.puertas = puertas
    }
    
    func acelerar() {
        print("Audi.. acelera")
    }

}

class MazdaCart: Cart {
        
    var ruedas: Int
    var puertas: Int
    
    var color: String = "Negro"
    
    init(ruedas: Int, puertas: Int) {
        self.ruedas = ruedas
        self.puertas = puertas
    }
    
    func acelerar() {
        print("Mazda.. acelera")
        print("color: \(self.color)")
    }
}

//var cart: Cart = MazdaCart(ruedas: 4, puertas: 2)
//cart.puertas = 5
//cart.ruedas = 5

protocol LocationSearchTableShowResult {
    func showResult(placemark: MKPlacemark)
}

class LocationSearchTable: UITableViewController, UISearchResultsUpdating {
    
    var mapView: MKMapView? = nil
    
    var delegate: LocationSearchTableShowResult?
    
    var matchItems: [MKMapItem] = [] {
        didSet {
            self.tableView.reloadData()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }

    // MARK: - Table view data source
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return matchItems.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    
        let cell = UITableViewCell()
        let item = matchItems[indexPath.row].placemark
        let adress = "\(item.thoroughfare ?? ""), \(item.locality ?? ""), \(item.subLocality ?? ""), \(item.administrativeArea ?? "")"
        cell.textLabel?.text = "\(item.name ?? "") \n \(adress)"
        cell.textLabel?.numberOfLines = 0
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let placemark: MKPlacemark = matchItems[indexPath.row].placemark
        
        dismiss(animated: true) {
            self.delegate?.showResult(placemark: placemark)
        }
    
    }

    // MARK: - UISearchResultsUpdating
    func updateSearchResults(for searchController: UISearchController) {
        
        guard  let mapView = self.mapView, let searchText = searchController.searchBar.text else {
            return
        }
        
        //Step 1
        let request = MKLocalSearch.Request()
        request.naturalLanguageQuery = searchText
        request.region = mapView.region
        
        //Step 2
        let search = MKLocalSearch(request: request)
        
        //Step 3
        search.start { (res, _ ) in
            
            guard let response = res else {
                return
            }
            
            self.matchItems = response.mapItems
        }
        
        
        
    }

}

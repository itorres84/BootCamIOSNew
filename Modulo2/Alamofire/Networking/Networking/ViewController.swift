//
//  ViewController.swift
//  Networking
//
//  Created by Israel Torres Alvarado on 24/03/21.
//

import UIKit
import Alamofire

struct CovidResponse: Codable {
    
    let error: Bool
    let statusCode: Int
    let message: String
    let data: DataResponse

}

struct DataResponse: Codable {
    let lastChecked: String
    let covid19Stats: [Covid19Stats]
}

struct Covid19Stats: Codable {
    let city: String?
    let province: String
    let country: String
    let lastUpdate: String
    let keyId: String
    let confirmed: Int
    let deaths: Int
    let recovered: Int?
}

struct TeamsResponse: Codable {
    let teams: [Team]
}

struct Team: Codable {
    let name: String
    let imageName: String
    let type: String
}

struct Book {
    var bookTitle: String
    var bookAuthor: String
}

class ViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView! {
        didSet {
            tableView.dataSource = self
        }
    }
    
    var covid19Stats: [Covid19Stats] = [] {
        didSet {
            tableView.reloadData()
        }
    }
    
    var books: [Book] = [] {
        didSet {
            dump(books)
        }
    }
    
    
    var elementName: String = String()
    var bookTitle = String()
    var bookAuthor = String()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let request = AF.request("https://run.mocky.io/v3/fb99a6af-9f74-445c-a877-0926b8f0d6f0")

        request.response { (response) in
            
            
            dump(response.value)
            
            guard let data = response.value else {  return }
            
            let xmlResult = XMLParser(data: response.value!!)
            xmlResult.delegate = self
            xmlResult.parse()
            dump(xmlResult)
            
            
        }
        
        
        
        
//
//
//        APIClient.getInfoCovid("Mexico") { (response) in
//
//            switch response {
//            case .failure(let error):
//                print(error.localizedDescription)
//            case .success(let resp):
//                self.covid19Stats = resp.data.covid19Stats
//            }
//        }
        
//        _ = GithubAPI.repos(org: "itorres84").sink { _ in } receiveValue: { (repos) in
//
//            dump(repos)
//
//        }
//
//
        
//        APIClient.getTeams { (response) in
//            switch response {
//            case .failure(let error):
//                print(error.localizedDescription)
//            case .success(let resp):
//               dump(resp)
//            }
//        }
//
        
//        let request = AF.request("https://run.mocky.io/v3/373be070-31f6-47b0-b333-e2b169753b7d")
//        
//        request.responseDecodable(of: TeamsResponse.self) { (response) in
//            
//            guard let teams = response.value else { return }
//            
//            dump(teams)
//            
//        }
        
    }

}

extension ViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
       return covid19Stats.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let state = covid19Stats[indexPath.row]
        
        let cell = UITableViewCell()
        cell.textLabel?.text = "\(state.province) | confirmados: \(state.confirmed) | defunciones: \(state.deaths)" 
        
        return cell
    }
    
    
    
    
    
}
extension ViewController: XMLParserDelegate {
    
    // 1
    func parser(_ parser: XMLParser, didStartElement elementName: String, namespaceURI: String?, qualifiedName qName: String?, attributes attributeDict: [String : String] = [:]) {

        if elementName == "book" {
            bookTitle = String()
            bookAuthor = String()
        }

        self.elementName = elementName
    }

    // 2
    func parser(_ parser: XMLParser, didEndElement elementName: String, namespaceURI: String?, qualifiedName qName: String?) {
        if elementName == "book" {
            let book = Book(bookTitle: bookTitle, bookAuthor: bookAuthor)
            books.append(book)
        }
    }

    // 3
    func parser(_ parser: XMLParser, foundCharacters string: String) {
        
        let data = string.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines)

        if (!data.isEmpty) {
            if self.elementName == "title" {
                bookTitle += data
            } else if self.elementName == "author" {
                bookAuthor += data
            }
        }
    }
    
    
}


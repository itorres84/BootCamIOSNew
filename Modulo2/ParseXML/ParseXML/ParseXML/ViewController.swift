//
//  ViewController.swift
//  ParseXML
//
//  Created by Israel Torres Alvarado on 05/04/21.
//

import UIKit
import Alamofire

class ViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView! {
        didSet {
            tableView.dataSource = self
        }
    }
    
    var books: [Book] = [] {
        didSet {
            tableView.reloadData()
        }
    }

    var elementName = String()
    var bookTitle = String()
    var bookAuthor = String()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.books = []
        
        let request = AF.request("https://run.mocky.io/v3/fb99a6af-9f74-445c-a877-0926b8f0d6f0")
        
        request.response { (response) in
            
            guard let value = response.value,
                  let realValue = value  else {  return }
            
            let xmlResult = XMLParser(data: realValue)
            xmlResult.delegate = self
            xmlResult.parse()
            
        }
        
    }

}

extension ViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return books.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        let book = books[indexPath.row]
        cell.textLabel?.text = "Libro: \(book.title)" + "\n" + "Author: \(book.author)"
        cell.textLabel?.numberOfLines = 0
        return  cell
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
            let book = Book(title: bookTitle, author: bookAuthor)
            books.append(book)
        }
    }

    // 3
    func parser(_ parser: XMLParser, foundCharacters string: String) {
        
        let data = string.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines)
        
        if (!data.isEmpty) {
            if self.elementName == "title" {
                bookTitle += data
                //bookTitle = bookTitle + data
            } else if self.elementName == "author" {
                bookAuthor += data
            }
        }
    }
    
    
}


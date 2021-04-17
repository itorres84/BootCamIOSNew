//
//  ViewController.swift
//  UseCoreData
//
//  Created by Israel Torres Alvarado on 14/04/21.
//

import UIKit
import CoreData

class ViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!

    var peoples: [Person] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "The List of Names"
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "Cell")
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        getInfo()
    
    }
    
    func getInfo() {
        
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
            return
        }
        
        //1
        let managedContext = appDelegate.persistentContainer.viewContext
        
        //2
        let fetchRequest = NSFetchRequest<Person>(entityName: "Person")
        
        //3
        do {
            
            peoples = try managedContext.fetch(fetchRequest)
            self.tableView.reloadData()
            
        } catch {
                
            print("Could not fetch. \(error.localizedDescription)")
            
        }
        
    }
    

    @IBAction func addName(_ sender: UIBarButtonItem) {
        
        let alert = UIAlertController(title: "New Name",
                                      message: "Add a new Name",
                                      preferredStyle: .alert)
        
        let saveAction = UIAlertAction(title: "Save",
                                       style: .default) { (accion) in
            
            guard let textFields = alert.textFields,
                  let texField = textFields.first,
                  let nameToSave = texField.text,
                  let texFieldTwo = textFields.last,
                  let numberToSave = texFieldTwo.text else { return }
            
            self.save(name: nameToSave, number: numberToSave)
            
        }
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel)
        
        alert.addAction(saveAction)
        alert.addAction(cancelAction)
        
        alert.addTextField()
        alert.addTextField()
        
        present(alert, animated: true)
        
    }
    
    
    func save(name: String, number: String) {
            
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
            return
        }
        
        //1
        let managedContext = appDelegate.persistentContainer.viewContext

        //2
        guard let entity = NSEntityDescription.entity(forEntityName: "Person", in: managedContext) else { return }
        
        let person =  NSManagedObject(entity: entity, insertInto: managedContext)
        
        //KVO - Key Value Object
        //3
        person.setValue(name, forKey: "name")
        if let telephone = Float(number) {
            person.setValue(telephone, forKey: "telephone")
        }
    
        //4
        
        do {
            
            try managedContext.save()
            self.getInfo()
            
        } catch {
            print("Could not save. \(error.localizedDescription)")
        }
    
    }
    
}

extension ViewController: UITableViewDataSource {
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return peoples.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
            
        let person = peoples[indexPath.row]
        let name = person.value(forKey: "name") as? String
        let telephone = person.value(forKey: "telephone") as? Float
    
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        cell.textLabel?.text = "name: \(name ?? ""), telephone: \(Int(telephone ?? 0))"
            
        return cell
    }
    
}

extension ViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let person = peoples[indexPath.row]
        let name = person.value(forKey: "name") as? String
        let telephone = person.value(forKey: "telephone") as? Float
         
        
    }
    
    
}

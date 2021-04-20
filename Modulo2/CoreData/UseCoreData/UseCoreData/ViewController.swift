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
        
        alert.addTextField { (txtName) in
            txtName.placeholder = "Escribe tu nombre"
        }
        alert.addTextField { (txtTelephone) in
            txtTelephone.placeholder = "Escribe tu telefono"
        }
        
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
        if let telephone = Int(number) {
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
    
    var deletePerson: Person?
    var deleteIndexPath: IndexPath?
    
    func confirmDelete(indexPath: IndexPath) {
        
        let person = peoples[indexPath.row]
        
        guard let name = person.name else {
            return
        }
        
        deletePerson = person
        deleteIndexPath = indexPath
        
        let alert = UIAlertController(title: "Delete person",
                                      message: "Are you sure you want to permenently delete \(name) ?",
                                      preferredStyle: .alert)
        
        let deleteAction = UIAlertAction(title: "Delete", style: .destructive, handler: handleDeletePerson)
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: handleCancelPerson)
        
        alert.addAction(deleteAction)
        alert.addAction(cancelAction)
        
        self.present(alert, animated: true, completion: nil)
        
    }
    
    func handleCancelPerson(accion: UIAlertAction) {
        deletePerson = nil
        deleteIndexPath = nil
    }
    
    func handleDeletePerson(accion: UIAlertAction) {
        
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate,
              let person = deletePerson,
              let deleteIndex = deleteIndexPath else {
            return
        }
        
        let managedContext = appDelegate.persistentContainer.viewContext
        
        do {
                        
            managedContext.delete(person)
            try managedContext.save()
            
            peoples.remove(at: deleteIndex.row)
            self.tableView.reloadData()
            deleteIndexPath = nil
            deletePerson = nil
            
        } catch {
            debugPrint(error.localizedDescription)
        }
    
    }

}

extension ViewController: UITableViewDataSource {
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return peoples.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
            
        let person = peoples[indexPath.row]
        let name = person.name ?? ""
        let telephone = person.telephone
    
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        cell.textLabel?.text = "Name: \(name)\nTelephone: \(telephone)"
        cell.textLabel?.numberOfLines = 0
        
        return cell
    }
    
}

extension ViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let person = peoples[indexPath.row]
        let name = person.name
        let telephone = person.telephone
        
        var txtNameAfter: UITextField?
        var txtTelephoneAfter: UITextField?
        
        let alert = UIAlertController(title: "Update Person",
                                      message: "update a peron whit name: \(name ?? "")",
                                      preferredStyle: .alert)
        
        let updateAction = UIAlertAction(title: "Update",
                                       style: .default) { (accion) in
            
           
            guard let txtName = txtNameAfter,
                  let txtTelephone = txtTelephoneAfter else {  return }
            
            person.name = txtName.text
        
            if let telephone = Int(txtTelephone.text ?? "") {
                person.telephone = Int64(telephone)
            }
            
            guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
                return
            }
            
            //1
            let managedContext = appDelegate.persistentContainer.viewContext
            
            do {
                
                try managedContext.save()
                self.tableView.reloadData()
                
            } catch {
                
                print(error.localizedDescription)
            
            }
            
        }
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel)
        
        alert.addAction(updateAction)
        alert.addAction(cancelAction)
        
        alert.addTextField { (txtName) in
            txtName.text = name
            txtNameAfter = txtName
        }
        alert.addTextField { (txtTelephone) in
            txtTelephone.keyboardType = .numberPad
            txtTelephone.text = "\(telephone)"
            txtTelephoneAfter = txtTelephone
        }
        
        present(alert, animated: true)
        

    }
    
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        
        if editingStyle == .delete {
            confirmDelete(indexPath: indexPath)
        }
        
    }
    
    
}

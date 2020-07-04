//
//  CategoryViewController.swift
//  Todoey
//
//  Created by Abrar Hoque on 6/26/20.
//  Copyright © 2020 App Brewery. All rights reserved.
//

import UIKit
//import CoreData
import RealmSwift
//import SwipeCellKit


class CategoryViewController: SwipeTableViewController {
    
    
    let realm = try! Realm()
    
    var categories : Results<Category>?
    
    
    
    
    
    

    override func viewDidLoad() {
        super.viewDidLoad()

        loadCategories()
        
        tableView.rowHeight = 80.0
        
    }

    
    
    
    //MARK: - TableView Datasource Methods
       override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
            return categories?.count ?? 1
        }
    
//    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell") as! SwipeTableViewCell
//        cell.delegate = self
//        return cell
//    }
        
        override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
            
        let cell = super.tableView(tableView, cellForRowAt: indexPath)
            
        cell.textLabel?.text = categories?[indexPath.row].name ?? "No categories added yet"
            
            
            return cell
            //return UITableView.updateTextAttributes(itemArray[count])
        }
    
    
    //MARK: - TableView Delegate Methods
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "goToItems", sender: self)
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let destinationVC = segue.destination as! TodoListViewController
        
        if let indexPath = tableView.indexPathForSelectedRow {
            destinationVC.selectedCategory = categories?[indexPath.row]
        }
        
    }
    
   
    
    //MARK: - Data Manipulation Methods
    
    func save(category: Category) {
        //let encoder = PropertyListEncoder()
        
        do {
            //let data = try encoder.encode(itemArray)
            //try data.write(to: dataFilePath!)
            
            try realm.write {
                realm.add(category)
            }
        } catch {
            print("Error saving contect, \(error)")
        }
        
        
        self.tableView.reloadData()
        
        
    }
    
    func loadCategories(){
    
//   func loadCategories(with request: NSFetchRequest<Category> = Category.fetchRequest()) {
//            let request : NSFetchRequest<Item> = Item.fetchRequest()
//
//            do {
//              categories =  try context.fetch(request)
//            } catch {
//                print("Error fetching data from context \(error)")
//            }
        categories = realm.objects(Category.self)
        
        tableView.reloadData()
        
        }
    
    //MARK: - delete data from swipe
    
    override func updateModel(at indexPath: IndexPath) {
        if let categoryForDeletion = self.categories?[indexPath.row] {
            
            super.updateModel(at: indexPath)
            
            do {
                try self.realm.write{
                    
                    //realm.delete(item)
                    self.realm.delete(categoryForDeletion)
                    
                }
            } catch {
                print("Error saving done status, \(error)")
            }
    }
    }
    
   
    
    
    //MARK: - Add new Categories
    @IBAction func addButtonPressed(_ sender: UIBarButtonItem) {
        
        var textField = UITextField()
        //var nText : String? - wrong
        
        let alert = UIAlertController(title: "Add New Category", message: "", preferredStyle: .alert)
        
        let action = UIAlertAction(title: "Add", style: .default) { (action) in
            //whats gonna happen when then the user clicks the add item button
            //print(textField.text)
            
            //           let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
            //let yurr = AppDelegate()
            
            //let yo = yurr.persistentContainer.viewContext
            
            let newCategory = Category()
            newCategory.name = textField.text!
            
            //newItem.done = false
            
           // self.categories.append(newCategory)
            // print(nText)
            
            //self.defaults.set(self.itemArray, forKey: "TodoListArray")
            self.save(category: newCategory)
        }
        
        alert.addTextField { (alertTextField) in
            alertTextField.placeholder = "Add a new category"
            
            textField = alertTextField
            //print(alertTextField.text)
            //print("Now")
            //nText = alertTextField.text
            //print(alertTextField.text)
        }
        
        alert.addAction(action)
        
        present(alert, animated: true, completion: nil)
        
    }
    
}

 




//
//  CategoryViewController.swift
//  Todoey
//
//  Created by Abrar Hoque on 6/26/20.
//  Copyright © 2020 App Brewery. All rights reserved.
//

import UIKit
import CoreData


class CategoryViewController: UITableViewController {
    
    
    var categories = [Category]()
    
    
    
    
    
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    

    override func viewDidLoad() {
        super.viewDidLoad()

        loadCategories()
        
        
        
    }

    
    
    
    //MARK: - TableView Datasource Methods
       override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
            return categories.count
        }
        
        override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
            
            
            //print("cellforrowatindex path called")
            //let count = it emArray.count - 1
            
            let cell = tableView.dequeueReusableCell(withIdentifier: "CategoryCell", for: indexPath)
            
            let category = categories[indexPath.row]
            
            
            cell.textLabel?.text = category.name
            
            
            //cell.accessoryType = item.done == true ? .checkmark : .none
            
            
           // cell.accessoryType = item.done ? .checkmark : .none
            
    //        if item.done == true {
    //            cell.accessoryType = .checkmark
    //        } else {
    //            cell.accessoryType = .none
    //        }
            
            
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
            destinationVC.selectedCategory = categories[indexPath.row]
        }
        
    }
    
   
    
    //MARK: - Data Manipulation Methods
    
    func saveCategories() {
        //let encoder = PropertyListEncoder()
        
        do {
            //let data = try encoder.encode(itemArray)
            //try data.write(to: dataFilePath!)
            
            try context.save()
        } catch {
            print("Error saving contect, \(error)")
        }
        
        
        self.tableView.reloadData()
        
        
    }
    
    func loadCategories(with request: NSFetchRequest<Category> = Category.fetchRequest()) {
            //let request : NSFetchRequest<Item> = Item.fetchRequest()
        
            do {
              categories =  try context.fetch(request)
            } catch {
                print("Error fetching data from context \(error)")
            }
            
        tableView.reloadData()
        
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
            
            let newCategory = Category(context: self.context)
            newCategory.name = textField.text ?? "You put a blank field"
            
            //newItem.done = false
            
            self.categories.append(newCategory)
            // print(nText)
            
            //self.defaults.set(self.itemArray, forKey: "TodoListArray")
            self.saveCategories()
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


    



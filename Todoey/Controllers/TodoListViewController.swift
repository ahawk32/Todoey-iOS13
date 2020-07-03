//
//  ViewController.swift
//  Todoey
//
//  Created by Philipp Muellauer on 02/12/2019.
//  Copyright © 2019 App Brewery. All rights reserved.
//

import UIKit
import CoreData
import RealmSwift

class TodoListViewController: UITableViewController {
    
    //cash money jhvghjvjjvhjhvjhvjvgjgvjhvjhvjhvjhvjhvjhvjh
    
    //var todoItems = [Item]()
    
    var todoItems : Results<Item>?
    
    let realm = try! Realm()
    
    var selectedCategory : Category?{
        didSet{
           loadItems()
        }
    }
    
//    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext

    
//    let dataFilePath = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first?.appendingPathComponent("Items.plist")
    
//    //var itemArray = ["Find Mike","Buy Eggos", "Destroy Demogogon"]
    //var itemArray2 = [Item(key: "Find Mike", check: false),Item(key: "Buy Eggos", check: false) , Item(key: "Destroy Demogogon", check: false)]
    
    //let defaults = UserDefaults.standard
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
    print(FileManager.default.urls(for: .documentDirectory, in: .userDomainMask))
        //print(dataFilePath)
        
//        let newItem = Item()
//        newItem.title = "Find Mike"
//        itemArray.append(newItem)
//
//        let newItem2 = Item()
//        newItem2.title = "Buy Eggos"
//        itemArray.append(newItem2)
//
//        let newItem3 = Item()
//        newItem3.title = "Destroy Demogogon"
//        itemArray.append(newItem3)
//
//        searchBar.delegate = self
        
        
        //let request : NSFetchRequest<Item> = Item.fetchRequest()
        
        //loadItems()
//        if let items = defaults.array(forKey: "TodoListArray") as? [Item] {
//            itemArray = items
//        }
        
        // Do any additional setup after loading the view.
    }
    
//MARK: - TableView Datasource Methods
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return todoItems?.count ?? 1
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        
        //print("cellforrowatindex path called")
        //let count = it emArray.count - 1
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "TodoItemCell", for: indexPath)
        
        if let item = todoItems?[indexPath.row]{
        
        cell.textLabel?.text = item.title
        
        
        //cell.accessoryType = item.done == true ? .checkmark : .none
        
        
        cell.accessoryType = item.done ? .checkmark : .none
            
        } else {
            cell.textLabel?.text = "No Items Added"
        }
        
        
        
        
//        if item.done == true {
//            cell.accessoryType = .checkmark
//        } else {
//            cell.accessoryType = .none
//        }
        
        
        return cell
        //return UITableView.updateTextAttributes(itemArray[count])
    }
    
//    override func tableView(_ tableView: UITableView,
//                            willSelectRowAt indexPath: IndexPath) -> IndexPath? {
//        let count = Int(indexPath.row)
//        print(itemArray[count])
//        return indexPath
//
//    }
    
  //MARK: - TableView Delegate Methods
    
    override func tableView(_ tableView: UITableView,
                            didSelectRowAt indexPath: IndexPath){
        
        
        if let item = todoItems?[indexPath.row] {
            do {
            try realm.write{
                
                realm.delete(item)
                
                //item.done = !item.done
            }
            } catch {
                print("Error saving done status, \(error)")
            }
        }
        
        tableView.reloadData()
        
        //itemArray[indexPath.row].setValue("Completed", forKey: "title")
        
//        todoItems[indexPath.row].done = !todoItems[indexPath.row].done
//
//
////        context.delete(itemArray[indexPath.row])
////        itemArray.remove(at: indexPath.row)
//
//        saveItems()
//
//        if itemArray[indexPath.row].done == false {
//            itemArray[indexPath.row].done = true
//        } else {
//            itemArray[indexPath.row].done = false
//        }
        
        //tableView.reloadData()
//        let count = Int(indexPath.row)
//        print(itemArray[count])
        
        tableView.deselectRow(at: indexPath, animated: true)
        
//        if tableView.cellForRow(at: indexPath)?.accessoryType == .checkmark {
//            tableView.cellForRow(at: indexPath)?.accessoryType = .none
//
//        } else {
//            tableView.cellForRow(at: indexPath)?.accessoryType = .checkmark
//        }
//
//
        
    }
    
    
    
 //MARK: - Add new items
    
    
    @IBAction func addButtonPressed(_ sender: UIBarButtonItem) {
        
        var textField = UITextField()
        //var nText : String? - wrong
        
        let alert = UIAlertController(title: "Add New Todoey Item", message: "", preferredStyle: .alert)
        
        let action = UIAlertAction(title: "Add Item", style: .default) { (action) in
            //whats gonna happen when then the user clicks the add item button
            //newItem.done = false
            if let currentCategory = self.selectedCategory {
                do {
                //let data = try encoder.encode(itemArray)
                //try data.write(to: dataFilePath!)
                               
                try self.realm.write {
                let newItem = Item()
                newItem.title = textField.text!
                currentCategory.items.append(newItem)
                }
            } catch {
                print("Error saving contect, \(error)")
            }
            }
        
                
            //newItem.parentCategory = self.selectedCategory
            self.tableView.reloadData()
           // self.itemArray.append(newItem)
           // print(nText)
            //self.defaults.set(self.itemArray, forKey: "TodoListArray")
            //self.saveItems()
        }
        
        alert.addTextField { (alertTextField) in
            alertTextField.placeholder = "Create new item"
            
            textField = alertTextField
            //print(alertTextField.text)
            //print("Now")
            //nText = alertTextField.text
            //print(alertTextField.text)
        }
        
        
        alert.addAction(action)
        
        present(alert, animated: true, completion: nil)
        
    
        
    }
    
    //MARK: - Model Manipulation Methods
    
//    func saveItems() {
//        //let encoder = PropertyListEncoder()
//
//        do {
//            //let data = try encoder.encode(itemArray)
//            //try data.write(to: dataFilePath!)
//
//            try context.save()
//        } catch {
//            print("Error saving contect, \(error)")
//        }
//
//
//        self.tableView.reloadData()
//
//
//    }
    
    func loadItems() {
            //let request : NSFetchRequest<Item> = Item.fetchRequest()

        todoItems = selectedCategory?.items.sorted(byKeyPath:"title", ascending:true)
        
//        let categoryPredicate = NSPredicate(format: "parentCategory.name MATCHES %@", selectedCategory!.name!)
//
//        if let additionalPredicate = predicate {
//            request.predicate = NSCompoundPredicate(andPredicateWithSubpredicates: [categoryPredicate, predicate!])
//        } else {
//            request.predicate = categoryPredicate
//        }
//        let compoundPredicate = NSCompoundPredicate(andPredicateWithSubpredicates: [categoryPredicate, predicate])
//
//        request.predicate = compoundPredicate
//
//            do {
//              itemArray =  try context.fetch(request)
//            } catch {
//                print("Error fetching data from context \(error)")
//            }

        tableView.reloadData()

        }


    
    
    
    
    
    
    
    
//    func loadItems() {
//        if let data = try? Data(contentsOf: dataFilePath!){
//            let decoder = PropertyListDecoder()
//            do {
//                itemArray = try decoder.decode([Item].self, from: data)
//            } catch {
//                print("Error decoding item array, \(error)")
//            }
//
//        }
//    }


    
    
    

//MARK: - Search bar methods
//extension TodoListViewController: UISearchBarDelegate{
//    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
//        let request : NSFetchRequest<Item> = Item.fetchRequest()
//
//        //print(searchBar.text!)
//        let predicate = NSPredicate(format: "title CONTAINS[cd] %@", searchBar.text!)
//
//        //request.predicate = predicate
//
//        request.sortDescriptors = [NSSortDescriptor(key: "title", ascending: true)]
//
//       // request.sortDescriptors = [sortDescriptor]
//
//        loadItems(with: request, predicate: predicate)
////        do {
////          itemArray =  try context.fetch(request)
////        } catch {
////            print("Error fetching data from context \(error)")
////        }
//
//        //tableView.reloadData()
//
//
//    }
//
//    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
//        if searchBar.text?.count == 0 {
//            loadItems()
//
//            DispatchQueue.main.async {
//                searchBar.resignFirstResponder()
//            }
//
//        }
//
//    }
//
//}
    
    
//    override func tableView(_ tableView: UITableView,
//                            didDeselectRowAt indexPath: IndexPath){
//        //tableView.cellForRow(at: indexPath)?.accessoryType = .none
//
//    }
    
//    override func tableView(_ tableView: UITableView,
//                            willDeselectRowAt indexPath: IndexPath) -> IndexPath?{
//
//        //tableView.cellForRow(at: indexPath)?.accessoryType = .none
//
//        return indexPath
//    }
//
    
    


//extension TodoListViewController: UITableViewDataSource {
//
//
//}

}

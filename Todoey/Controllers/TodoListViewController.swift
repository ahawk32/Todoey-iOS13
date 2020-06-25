//
//  ViewController.swift
//  Todoey
//
//  Created by Philipp Muellauer on 02/12/2019.
//  Copyright © 2019 App Brewery. All rights reserved.
//

import UIKit

class TodoListViewController: UITableViewController {
    
    
    var itemArray = [Item]()

    
    let dataFilePath = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first?.appendingPathComponent("Items.plist")
    //var itemArray = ["Find Mike","Buy Eggos", "Destroy Demogogon"]
    //var itemArray2 = [Item(key: "Find Mike", check: false),Item(key: "Buy Eggos", check: false) , Item(key: "Destroy Demogogon", check: false)]
    
    //let defaults = UserDefaults.standard
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        
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
        
        
        loadItems()
//        if let items = defaults.array(forKey: "TodoListArray") as? [Item] {
//            itemArray = items
//        }
        
        // Do any additional setup after loading the view.
    }


    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return itemArray.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        
        //print("cellforrowatindex path called")
        //let count = it emArray.count - 1
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "TodoItemCell", for: indexPath)
        
        let item = itemArray[indexPath.row]
        
        
        cell.textLabel?.text = item.title
        
        
        //cell.accessoryType = item.done == true ? .checkmark : .none
        
        
        cell.accessoryType = item.done ? .checkmark : .none
        
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
    
  
    
    override func tableView(_ tableView: UITableView,
                            didSelectRowAt indexPath: IndexPath){
        
        itemArray[indexPath.row].done = !itemArray[indexPath.row].done
        
        saveItems()
        
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
            //print(textField.text)
            
            let newItem = Item()
            newItem.title = textField.text!
            self.itemArray.append(newItem)
           // print(nText)
            
            //self.defaults.set(self.itemArray, forKey: "TodoListArray")
            self.saveItems()
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
    
    func saveItems() {
        let encoder = PropertyListEncoder()
        
        do {
            let data = try encoder.encode(itemArray)
            try data.write(to: dataFilePath!)
        } catch {
            print("Error encoding item array, \(error)")
        }
        
        
        tableView.reloadData()
        
        
    }
    
    func loadItems() {
        if let data = try? Data(contentsOf: dataFilePath!){
            let decoder = PropertyListDecoder()
            do {
                itemArray = try decoder.decode([Item].self, from: data)
            } catch {
                print("Error decoding item array, \(error)")
            }
           
        }
    }
    
    
    
    
    }
    
    
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


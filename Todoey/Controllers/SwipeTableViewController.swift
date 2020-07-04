//
//  SwipeTableViewController.swift
//  Todoey
//
//  Created by Abrar Hoque on 7/3/20.
//  Copyright © 2020 App Brewery. All rights reserved.
//

import UIKit
import SwipeCellKit

class SwipeTableViewController: UITableViewController, SwipeTableViewCellDelegate {

    override func viewDidLoad() {
        super.viewDidLoad()

        
    }
    
    //TableView Datasource Methods
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! SwipeTableViewCell
        cell.delegate = self
        
        
        
        return cell
        
    }

    func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath, for orientation: SwipeActionsOrientation) -> [SwipeAction]? {
        
        guard orientation == .right else { return nil }

        let deleteAction = SwipeAction(style: .destructive, title: "Delete") { action, indexPath in
            // handle action by updating model with deletion
            print("Delete Cell")
            
            self.updateModel(at: indexPath)
            
//            if let categoryForDeletion = self.categories?[indexPath.row] {
//            do {
//                try self.realm.write{
//
//                //realm.delete(item)
//                self.realm.delete(categoryForDeletion)
//
//            }
//            } catch {
//                print("Error saving done status, \(error)")
//            }
//
//               // tableView.reloadData()
//
//
//            }
        }
        

        // customize the action appearance
        deleteAction.image = UIImage(named: "delete-icon")

        return [deleteAction]
    }
    func tableView(_ tableView: UITableView, editActionsOptionsForRowAt indexPath: IndexPath, for orientation: SwipeActionsOrientation) -> SwipeOptions {
        var options = SwipeOptions()
        options.expansionStyle = .destructive

        return options
    }
    
    func updateModel(at indexPath: IndexPath){
        //update our data model
        print("delete c")
        
    }
   

}


    

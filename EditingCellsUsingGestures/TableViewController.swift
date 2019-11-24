//
//  ViewController.swift
//  EditingCellsUsingGestures
//
//  Created by Simran Singh Sandhu on 24/11/19.
//  Copyright © 2019 Simran Singh Sandhu. All rights reserved.
//

import UIKit

class TableViewController: UITableViewController {

    let cellId = "cellId"
    var dataArr : [String] = ["Simran", "Singh", "Sandhu"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.backgroundView?.backgroundColor = UIColor.white
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: cellId)
    }

    // Number of Rows in our TableView (The Count of our Array)
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataArr.count
    }
    
    // Creating a Cell and Setting up All our DataArr Data Respectively in the TableView.
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellId, for: indexPath)
        cell.textLabel?.text = dataArr[indexPath.row]
        return cell
    }
    
    // When Tapped on Any Cell, we will Deselect that selected cell with an animation
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
 
    //Swipe Left to Delete Cell Data
    override func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let deleteAction = UIContextualAction(style: .destructive, title: "Delete") { (action, view, success) in
            // Delete the Data from Array and also from TableView
            self.dataArr.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .automatic)
            success(true)
        }
        
        return UISwipeActionsConfiguration(actions: [deleteAction])
    }
    
    // Swipe Right to Do other Stuff
    override func tableView(_ tableView: UITableView, leadingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let doneAction = UIContextualAction(style: .destructive, title: "Done") { (action, view, success) in
            if let cell = tableView.cellForRow(at: indexPath) {
                cell.accessoryType = .checkmark
            }
            success(true)
        }
        
        doneAction.backgroundColor = UIColor.green
        
        return UISwipeActionsConfiguration(actions: [doneAction])
    }
}


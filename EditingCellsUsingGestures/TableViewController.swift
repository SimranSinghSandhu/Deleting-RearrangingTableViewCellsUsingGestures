//
//  ViewController.swift
//  EditingCellsUsingGestures
//
//  Created by Simran Singh Sandhu on 24/11/19.
//  Copyright © 2019 Simran Singh Sandhu. All rights reserved.
//

import UIKit
import TableViewDragger

class TableViewController: UITableViewController, TableViewDraggerDelegate, TableViewDraggerDataSource {
    
    // Ceating an Instance of TableViewDragger
    var dragger : TableViewDragger!
    
    var isDragable : Bool = false
    let cellId = "cellId"
    var dataArr : [String] = ["Simran", "Singh", "Sandhu"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.backgroundView?.backgroundColor = UIColor.white
        
        // Setting TableView Dragger Properties, Delegates and DataSource Methods
        dragger = TableViewDragger(tableView: tableView)
        dragger.delegate = self
        dragger.dataSource = self
        dragger.availableHorizontalScroll = true
        dragger.alphaForCell = 0.7
        
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
        
        if !isDragable {
            return UISwipeActionsConfiguration(actions: [deleteAction])
        } else {
            return UISwipeActionsConfiguration(actions: [])
        }
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
        
        if !isDragable {
            return UISwipeActionsConfiguration(actions: [doneAction])
        } else {
            return UISwipeActionsConfiguration(actions: [])
        }
    }
    
    // When Drag Begins
    func dragger(_ dragger: TableViewDragger, didBeginDraggingAt indexPath: IndexPath) {
        isDragable = true
    }
    
    // When Ever LongPressed On a Cell this Function Will Call
    func dragger(_ dragger: TableViewDragger, moveDraggingAt indexPath: IndexPath, newIndexPath: IndexPath) -> Bool {
        let item = dataArr[indexPath.row]
        dataArr.remove(at: indexPath.row)
        dataArr.insert(item, at: newIndexPath.row)
       
        tableView.moveRow(at: indexPath, to: newIndexPath)
        return true
    }
    
    // When Drop Ends
    func dragger(_ dragger: TableViewDragger, didEndDraggingAt indexPath: IndexPath) {
        isDragable = false
    }
}


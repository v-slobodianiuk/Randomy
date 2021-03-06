//
//  ListViewController.swift
//  Randomy
//
//  Created by Vadym on 25.03.2020.
//  Copyright © 2020 Vadym Slobodianiuk. All rights reserved.
//

import UIKit

class ListViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!

    var currentRow: Int?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.dataSource = self
        tableView.delegate = self
        
        // MARK: Add Edit Bar button
        navigationItem.leftBarButtonItem = editButtonItem
        navigationItem.leftBarButtonItem?.tintColor = .systemOrange
        
        // MARK: Load data and reload table
        Query.shared.loadItems()
        tableView.reloadData()
    }
    
    // MARK: Activate edit button
    override func setEditing(_ editing: Bool, animated: Bool) {
        super.setEditing(editing,animated:animated)
        if (editing) {
            tableView.isEditing = true
        } else {
            tableView.isEditing = false
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let destinationVC = segue.destination as? ListRandomViewController {
            // MARK: Send text of selected row to ListRandomViewController
            destinationVC.words = Query.shared.array[currentRow!].str
        }
        
        if let destinationVC = segue.destination as? CreateListViewController {
            // MARK: QueryDataDelegate
            destinationVC.delegate = self
        }
    }
}

extension ListViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return Query.shared.array.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ListCell", for: indexPath)
        
        cell.textLabel?.text = Query.shared.array[indexPath.row].str
        cell.textLabel?.numberOfLines = 0
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        currentRow = indexPath.row
        tableView.deselectRow(at: indexPath, animated: true)
        
        performSegue(withIdentifier: "listRandom", sender: self)
    }
        
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            Query.shared.array.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .left)
            Query.shared.saveItems()
        }
    }
    
    func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    func tableView(_ tableView: UITableView, moveRowAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath) {
        let itemToMove = Query.shared.array[sourceIndexPath.row]
        Query.shared.array.remove(at: sourceIndexPath.row)
        Query.shared.array.insert(itemToMove, at: destinationIndexPath.row)
        Query.shared.saveItems()
    }
    
}

// MARK: - QueryDataDelegate Method
extension ListViewController: QueryDataDelegate {
    func reloadItems() {
        DispatchQueue.main.async {
            // MARK: Load data when new items added to the plist. Reload table
            Query.shared.loadItems()
            self.tableView.reloadData()
        }
    }
}

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

    private var currentRow: Int?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.dataSource = self
        tableView.delegate = self
        
        Query.shared.loadItems()
        tableView.reloadData()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let destinationVC = segue.destination as? ListRandomViewController {
            destinationVC.words = Query.shared.array[currentRow!].text
        }
        
        if let destinationVC = segue.destination as? CreateListViewController {
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
        
        cell.textLabel?.text = Query.shared.array[indexPath.row].text
        cell.textLabel?.numberOfLines = 0
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        currentRow = indexPath.row
        tableView.deselectRow(at: indexPath, animated: true)
        
        performSegue(withIdentifier: "listRandom", sender: self)
    }
    
}

extension ListViewController: QueryDataDelegate {
    func reloadItems() {
        DispatchQueue.main.async {
            Query.shared.loadItems()
            self.tableView.reloadData()
        }
    }
}

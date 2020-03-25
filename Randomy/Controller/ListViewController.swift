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

    var data = Query()
    
    var currentRow = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("viewDidLoad")
        
        tableView.dataSource = self
        tableView.delegate = self
        
        data.loadItems()
        tableView.reloadData()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let destinationVC = segue.destination as? ListRandomViewController {
            
            func convertToArray() {
                destinationVC.randomArray = {
                    let textInputResult = data.array[currentRow].text
                    let array = textInputResult
                        .filter{!String($0)
                            .contains(" ")}
                        .components(separatedBy: ",")
                        .compactMap{String($0)}
                    return array
                }()
            }
            
            convertToArray()
        }
        
        if let destinationVC = segue.destination as? CreateListViewController {
            destinationVC.delegate = self
        }
    }
    
    @IBAction func addButton(_ sender: UIBarButtonItem) {
    }
    
}

extension ListViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return data.array.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ListCell", for: indexPath)
        
        cell.textLabel?.text = data.array[indexPath.row].text
        cell.textLabel?.numberOfLines = 0
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        currentRow = indexPath.row
        
        performSegue(withIdentifier: "listRandom", sender: self)
        
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
}

extension ListViewController: QueryDataDelegate {
    func reloadItems() {
        DispatchQueue.main.async {
            self.data.loadItems()
            self.tableView.reloadData()
        }
    }
}

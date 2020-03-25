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
    
    let dataFilePAth = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!.appendingPathComponent("list_of_words.plist")
    var itemArray = [DataModel] ()
    var currentRow = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("viewDidLoad")
        
        tableView.dataSource = self
        tableView.delegate = self
        
        loadItems()
        tableView.reloadData()
    }
    
    func loadItems() {
        if let data = try? Data(contentsOf: dataFilePAth) {
            let decoder = PropertyListDecoder()
            
            do {
                itemArray = try decoder.decode([DataModel].self, from: data)
            } catch {
                print("Error decoding items in array, \(error)")
            }
            
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let destinationVC = segue.destination as? ListRandomViewController {
            
            func convertToArray() {
                destinationVC.randomArray = {
                    let textInputResult = itemArray[currentRow].text
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
        itemArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ListCell", for: indexPath)
        
        cell.textLabel?.text = itemArray[indexPath.row].text
        cell.textLabel?.numberOfLines = 0
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        currentRow = indexPath.row
        
        performSegue(withIdentifier: "listRandom", sender: self)
        
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
}

extension ListViewController: SaveDataDelegate {
    func dataSaved() {
        DispatchQueue.main.async {
            self.loadItems()
            self.tableView.reloadData()
        }
    }
}

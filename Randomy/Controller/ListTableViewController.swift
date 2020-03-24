//
//  ListTableViewController.swift
//  Randomy
//
//  Created by Vadym on 23.03.2020.
//  Copyright © 2020 Vadym Slobodianiuk. All rights reserved.
//

import UIKit

class ListTableViewController: UITableViewController {
    
    //var exampleArray = ["John, Donna, Mike, April, Tom"]
    var itemArray = [DataModel] ()
    var currentRow = 0
    
    let dataFilePAth = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!.appendingPathComponent("list_of_words.plist")

    override func viewDidLoad() {
        super.viewDidLoad()
        
        print("viewDidLoad")

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
        
        
        //let archiveURL = documentsDirectory.appendingPathComponent("list_of_words").appendingPathExtension("plist")
        
        loadItems()
        
        tableView.reloadData()
    }
    
//    override func viewWillAppear(_ animated: Bool) {
//        super.viewWillAppear(animated)
//        tableView.reloadData()
//        print("viewWillAppear")
//        print(itemArray)
//    }
//
//    override func viewDidAppear(_ animated: Bool) {
//        super.viewDidAppear(animated)
//        print("viewDidAppear")
//        print(itemArray)
//    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if let destinationVC = segue.destination as? ListRandomViewController {

            //destinationVC.randomArray = exampleArray
            
            
            //destinationVC.randomArray = itemArray
//            for item in itemArray {
//                if let str = item as? String {
//                    print(str)
//                }
//            }
            

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

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return itemArray.count + 1
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ListCell", for: indexPath)
        
        if indexPath.row < itemArray.count{
            cell.textLabel?.text = itemArray[indexPath.row].text
            cell.textLabel?.numberOfLines = 0
            cell.accessoryType = .none
        } else {
            cell.textLabel?.text = "Create New List"
            cell.textLabel?.textColor = UIColor.systemBlue
            cell.accessoryType = .disclosureIndicator
        }

        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        currentRow = indexPath.row
        
        if indexPath.row == itemArray.count {
            performSegue(withIdentifier: "createList", sender: self)
        } else {
            performSegue(withIdentifier: "listRandom", sender: self)
        }
        
        tableView.deselectRow(at: indexPath, animated: true)
    }

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}

//
//  CreateListViewController.swift
//  Randomy
//
//  Created by Vadym on 24.03.2020.
//  Copyright © 2020 Vadym Slobodianiuk. All rights reserved.
//

import UIKit

class CreateListViewController: UIViewController {
    
    
    @IBOutlet weak var textView: UITextView!
    
    var itemArray = [DataModel] ()
    
    let dataFilePAth = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!.appendingPathComponent("list_of_words.plist")

    override func viewDidLoad() {
        super.viewDidLoad()
        
        loadItems()

        let tap = UITapGestureRecognizer(target: self.view, action: #selector(UIView.endEditing(_:)))
        view.addGestureRecognizer(tap)

        print(dataFilePAth)
        
    }
    
    func saveItems() {
        let encoder = PropertyListEncoder()
        do {
            let data = try encoder.encode(itemArray)
            try data.write(to: dataFilePAth)
        } catch {
            print("Error encoding item array, \(error)")
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
    
    @IBAction func saveButton(_ sender: UIBarButtonItem) {

        var newItem = DataModel()
        newItem.text = textView.text
        itemArray.append(newItem)
        saveItems()
        
        performSegue(withIdentifier: "backToList", sender: self)
    }
    
    
    // MARK: - Navigation
    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
//    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
//        if let destinationVC = segue.destination as? ListTableViewController {
//
//            destinationVC.exampleArray.append(textView.text)
//        }
//    }
}

extension CreateListViewController: UITextViewDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textView.endEditing(true)
        return true
    }
}

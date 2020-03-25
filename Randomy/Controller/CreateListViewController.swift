//
//  CreateListViewController.swift
//  Randomy
//
//  Created by Vadym on 24.03.2020.
//  Copyright © 2020 Vadym Slobodianiuk. All rights reserved.
//

import UIKit

protocol SaveDataDelegate {
    func  dataSaved()
}

class CreateListViewController: UIViewController {
    
    var delegate: SaveDataDelegate?
    
    @IBOutlet weak var textView: UITextView!
    
    var itemArray = [DataModel] ()
    
    var mainVC: ListViewController?
    
    let dataFilePAth = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!.appendingPathComponent("list_of_words.plist")

    override func viewDidLoad() {
        super.viewDidLoad()
        
        loadItems()
        
        let tap = UITapGestureRecognizer(target: self.view, action: #selector(UIView.endEditing(_:)))
        view.addGestureRecognizer(tap)

        //print(dataFilePAth)
        
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
        
        delegate?.dataSaved()
        
        dismiss(animated: true, completion: nil )
    }
    
    
    @IBAction func cancelButton(_ sender: UIBarButtonItem) {
        dismiss(animated: true, completion: nil)
    }
}

extension CreateListViewController: UITextViewDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textView.endEditing(true)
        return true
    }
}

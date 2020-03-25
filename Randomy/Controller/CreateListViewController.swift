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
    
    var delegate: QueryDataDelegate?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        Query.shared.loadItems()
        
        let tap = UITapGestureRecognizer(target: self.view, action: #selector(UIView.endEditing(_:)))
        view.addGestureRecognizer(tap)
    }
    
    @IBAction func saveButton(_ sender: UIBarButtonItem) {

        var newItem = DataModel()
        newItem.text = textView.text
        Query.shared.array.append(newItem)
        Query.shared.saveItems()
        
        delegate?.reloadItems()
        
        dismiss(animated: true, completion: nil)
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

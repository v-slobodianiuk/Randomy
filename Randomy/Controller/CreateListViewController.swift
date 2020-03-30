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
    @IBOutlet weak var saveButton: UIBarButtonItem!
    
    var delegate: QueryDataDelegate?
    var placeholder = "Enter the words separated by commas.\nFor example: Tom, John, Donna, Mike"

    override func viewDidLoad() {
        super.viewDidLoad()
        
        textView.delegate = self
        
        // MARK: Placeholder for UITextView
        textView.text = placeholder
        
        Query.shared.loadItems()
        
        // MARK: Hide keyboard by touch outside the UITextView
        let tap = UITapGestureRecognizer(target: self.view, action: #selector(UIView.endEditing(_:)))
        view.addGestureRecognizer(tap)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        textView.alpha = 0.5
        textView.layer.cornerRadius = 10
        textView.backgroundColor = UIColor.systemGray.withAlphaComponent(0.1)
    }
    
    @IBAction func saveButton(_ sender: UIBarButtonItem) {
        
        guard textView.text != placeholder else { return }

        // MARK: Save new data
        var newItem = DataModel()
        newItem.str = textView.text
        Query.shared.array.append(newItem)
        Query.shared.saveItems()
        
        // MARK: Reload tableView in ListViewController
        delegate?.reloadItems()
        
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func cancelButton(_ sender: UIBarButtonItem) {
        dismiss(animated: true, completion: nil)
    }
}

extension CreateListViewController: UITextViewDelegate {
    
    // MARK: Hide keyboard by return button
    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        if text == "\n" {
            textView.resignFirstResponder()
            return false
        }
        
        return true
    }
    
    // MARK: Clean UITextView when ShouldBeginEditing
    func textViewShouldBeginEditing(_ textView: UITextView) -> Bool {
        textView.text = ""
        textView.alpha = 1.0
        
        let range = NSMakeRange(textView.text.count - 1, 0)
        textView.scrollRangeToVisible(range)
        return true
    }

}

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

    override func viewDidLoad() {
        super.viewDidLoad()
        
        textView.delegate = self
        
        textView.text = "Enter the words separated by spaces or commas.\nFor example: Tom, John, Donna, Mike"
        
        Query.shared.loadItems()
        
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
    
    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        if text == "\n" {
            textView.resignFirstResponder()
            return false
        }
        
        return true
    }
    
    func textViewShouldBeginEditing(_ textView: UITextView) -> Bool {
        textView.text = ""
        textView.alpha = 1.0
        
        let range = NSMakeRange(textView.text.count - 1, 0)
        textView.scrollRangeToVisible(range)
        return true
    }

}

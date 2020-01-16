//
//  EntryDetailViewController.swift
//  Journal+NSFRC
//
//  Created by Karl Pfister on 5/9/19.
//  Copyright © 2019 Karl Pfister. All rights reserved.
//

import UIKit

class EntryDetailViewController: UIViewController {
    
    var entry: Entry?
    
    
    @IBOutlet weak var titleTextField: UITextField!
    @IBOutlet weak var bodyTextView: UITextView!
    @IBOutlet weak var clearButton: UIButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        designClearButton()
        updateViews()
        // Do any additional setup after loading the view.
    }
    
    func updateViews() {
        guard let entry = entry else { return }
        titleTextField.text = entry.title
        bodyTextView.text = entry.body
    }
    
    func designClearButton() {
        clearButton.layer.cornerRadius = clearButton.frame.height / 2
        clearButton.backgroundColor = .cyan
        clearButton.layer.borderColor = UIColor.black.cgColor
        clearButton.layer.borderWidth = 2
    }
    
    @IBAction func saveButtonTapped(_ sender: Any) {
        guard let title = titleTextField.text, let body = bodyTextView.text else { return }
        
        if let entry = entry {
            // update
            EntryController.sharedInstance.updateEntry(entry: entry, newTitle: title, newBody: body)
        } else {
            //create
            EntryController.sharedInstance.createEntry(withTitle: title, withBody: body)
        }
        // Pop that view
        navigationController?.popViewController(animated: true)
    }
    
    @IBAction func clearButtonTapped(_ sender: Any) {
        titleTextField.text = ""
        bodyTextView.text = ""
    }
}

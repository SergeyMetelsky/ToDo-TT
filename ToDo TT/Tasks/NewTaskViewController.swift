//
//  CreateTaskViewController.swift
//  ToDo TT
//
//  Created by Sergey on 8/11/21.
//

import UIKit

class NewTaskViewController: UIViewController {
    
    var task: Task?
    
    @IBOutlet weak var titleTextField: UITextField!
    @IBOutlet weak var descriptionTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = "New Task"
        
        if let task = task {
            titleTextField.text = task.title
            descriptionTextField.text = task.description
        }

    }

    @IBAction func cancelButtonPressed(_ sender: UIBarButtonItem) {
//        navigationController?.popViewController(animated: true)
        dismiss(animated: true, completion: nil)
    }
    
    
    @IBAction func saveButtonPressed(_ sender: UIBarButtonItem) {
//        navigationController?.popViewController(animated: true)
        dismiss(animated: true, completion: nil)
    }
  
}

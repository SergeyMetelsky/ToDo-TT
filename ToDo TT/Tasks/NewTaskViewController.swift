//
//  CreateTaskViewController.swift
//  ToDo TT
//
//  Created by Sergey on 8/11/21.
//

import UIKit
import FirebaseAuth
import FirebaseDatabase

class NewTaskViewController: UIViewController {
    
    //    MARK:- Properties
    var task: Task?
    var userId: String = ""
    var newDataReceived: (() -> ())?
    let titleMaxLength = 250
    let descriptionMaxLength = 1000
    
    //    MARK:- IBOutlets
    @IBOutlet weak var titleTextField: UITextField!
    @IBOutlet weak var descriptionTextView: UITextView!
    
    //    MARK:- ControllerLifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = "New Task"
        
        self.titleTextField.delegate = self
        self.descriptionTextView.delegate = self
        
        if let task = task {
            titleTextField.text = task.title
            descriptionTextView.text = task.description
        }
                
        let tapRecognizer = UITapGestureRecognizer(target: self, action: #selector(firstRecognizerClicked(_:)))
        view.addGestureRecognizer(tapRecognizer)
        
        self.userId = Auth.auth().currentUser?.uid ?? ""
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        if let firstVC = presentingViewController as? TasksListViewController {
            DispatchQueue.main.async {
                firstVC.tableView.reloadData()
            }
        }
    }
    
    //    MARK:- IBActions
    @IBAction func cancelButtonPressed(_ sender: UIBarButtonItem) {
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func saveButtonPressed(_ sender: UIBarButtonItem) {
        if titleTextField.text != "" {
            let id = self.task?.id ?? UUID().uuidString
            guard let titleText = titleTextField.text, let descriptionText = descriptionTextView.text else { return }
            let task = Task(id: id, userId: self.userId, title: titleText, description: descriptionText)
            let serverManager = ServerManager()
            serverManager.sendTaskToServer(task)
            newDataReceived?()
            dismiss(animated: true, completion: nil)
        }
    }
    
    //    MARK:- Functions
    @objc func firstRecognizerClicked(_ sender: UITapGestureRecognizer) {
        view.endEditing(true)
    }
}

//    MARK:- Extension
extension NewTaskViewController: UITextFieldDelegate, UITextViewDelegate {
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        if textField == titleTextField {
            guard let text = textField.text else { return true }
            return text.count < self.titleMaxLength
        }
        
        return false
    }
    
    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        if textView == descriptionTextView {
            guard let text = textView.text else { return true }
            return text.count < self.descriptionMaxLength
        }
        
        return false
    }
}

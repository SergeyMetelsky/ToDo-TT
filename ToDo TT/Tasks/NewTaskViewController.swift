//
//  CreateTaskViewController.swift
//  ToDo TT
//
//  Created by Sergey on 8/11/21.
//

import UIKit
import FirebaseAuth
import FirebaseDatabase

//let newTaskViewControllerNotificationName = NSNotification.Name(rawValue: "NewTaskNotification")

class NewTaskViewController: UIViewController {
    
    var task: Task?
    var userId: String = ""
    var newDataReceived: (() -> ())?
    let titleMaxLength = 250
    let descriptionMaxLength = 1000
    
    @IBOutlet weak var titleTextField: UITextField!
    @IBOutlet weak var descriptionTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = "New Task"
        
        self.titleTextField.delegate = self
        self.descriptionTextField.delegate = self
        
        if let task = task {
            titleTextField.text = task.title
            descriptionTextField.text = task.description
        }
        
        guard let userId = Auth.auth().currentUser?.uid else { return }
        self.userId = userId
        
        let tapRecognizer = UITapGestureRecognizer(target: self, action: #selector(firstRecognizerClicked(_:)))
        view.addGestureRecognizer(tapRecognizer)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        if let firstVC = presentingViewController as? TasksListViewController {
            DispatchQueue.main.async {
                firstVC.tableView.reloadData()
            }
        }
    }
    
    @IBAction func cancelButtonPressed(_ sender: UIBarButtonItem) {
        //        navigationController?.popViewController(animated: true)
        dismiss(animated: true, completion: nil)
    }
    
    
    @IBAction func saveButtonPressed(_ sender: UIBarButtonItem) {
        //        navigationController?.popViewController(animated: true)
        if titleTextField.text != "" {
            let id = self.task?.id ?? UUID().uuidString
            guard let titleText = titleTextField.text, let descriptionText = descriptionTextField.text else { return }
            let task = Task(id: id, userId: self.userId, title: titleText, description: descriptionText)
            let serverManager = ServerManager()
            serverManager.sendTaskToServer(task)
            //            NotificationCenter.default.post(name: newTaskViewControllerNotificationName, object: nil)
            newDataReceived?()
            dismiss(animated: true, completion: nil)
        }
    }
    
    @objc func firstRecognizerClicked(_ sender: UITapGestureRecognizer) {
        view.endEditing(true)
    }
}

extension NewTaskViewController: UITextFieldDelegate {
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        guard let text = textField.text else { return true }
        let maxLength = (textField == titleTextField) ? titleMaxLength : descriptionMaxLength
        return text.count < maxLength
    }
}

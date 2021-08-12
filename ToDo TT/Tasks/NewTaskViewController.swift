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
          
    @IBOutlet weak var titleTextField: UITextField!
    @IBOutlet weak var descriptionTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = "New Task"
        
        if let task = task {
            titleTextField.text = task.title
            descriptionTextField.text = task.description
        }
        
        guard let userId = Auth.auth().currentUser?.uid else { return }
        self.userId = userId
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
        if let titleText = titleTextField.text, let descriptionText = descriptionTextField.text {
            let id = self.task?.id ?? UUID().uuidString
            let task = Task(id: id, userId: self.userId, title: titleText, description: descriptionText)
            let serverManager = ServerManager()
            serverManager.sendTaskToServer(task)
//            NotificationCenter.default.post(name: newTaskViewControllerNotificationName, object: nil)
            newDataReceived?()
            dismiss(animated: true, completion: nil)
        }
    }
}

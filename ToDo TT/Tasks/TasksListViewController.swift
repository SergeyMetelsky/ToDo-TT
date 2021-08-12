//
//  TasksListViewController.swift
//  ToDo TT
//
//  Created by Sergey on 8/11/21.
//

import UIKit
import FirebaseAuth
import FirebaseDatabase

class TasksListViewController: UIViewController {
    var tasks: [Task] = []
    let defaultTasks: DefaultTasks = DefaultTasks()
    var userId: String = ""

    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
//        NotificationCenter.default.addObserver(self,
//                                               selector: #selector(notificationFromNewTaskViewController(_:)),
//                                               name: newTaskViewControllerNotificationName,
//                                               object: nil)
        navigationItem.title = "Tasks"
        
        tableView.dataSource = self
        tableView.delegate = self
        
        tableView.register(UINib(nibName: "TaskCell", bundle: nil), forCellReuseIdentifier: "TaskCell")
        
        guard let userId = Auth.auth().currentUser?.uid else { return }
        self.userId = userId
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super .viewWillAppear(animated)
        setActualData()
    }
    
    @IBAction func plusButtonPressed(_ sender: UIBarButtonItem) {
//        guard let destinationVC = self.storyboard?.instantiateViewController(identifier: "NewTaskViewController") else { return }
//        self.navigationController?.pushViewController(destinationVC, animated: true)
        
        guard let newTaskNavigationController = self.storyboard?.instantiateViewController(identifier: "NewTaskNavigationController") as? UINavigationController else { return }
        guard let newTaskViewController = newTaskNavigationController.viewControllers.first as? NewTaskViewController else { return }
        newTaskViewController.newDataReceived = { [weak self] in
            guard let self = self else { return }
            self.setActualData()
        }
        present(newTaskNavigationController, animated: true, completion: nil)
    }
    
    @objc func notificationFromNewTaskViewController(_ notification: Notification) {
        setActualData()
    }
    
    func setActualData() {
        let serverManager = ServerManager()
        serverManager.downloadTasksOnComplete(for: self.userId) { [weak self] (tasks) in
            guard let self = self else { return }
            self.tasks = tasks
            self.tableView.reloadData()
        } onError: { (error) in
            print(error)
        }
    }
}

extension TasksListViewController: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tasks.count
//        return defaultTasks.tasks.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "TaskCell", for: indexPath) as! TaskCell
//        let defaultTask = self.defaultTasks.tasks[indexPath.item]
//        cell.setupCell(task: defaultTask)
        let task = self.tasks[indexPath.item]
        cell.setupCell(task: task)
        return cell
    }
    
    func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCell.EditingStyle {
        return .delete
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
//          defaultTasks.tasks.remove(at: indexPath.row)
            tasks.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        let defaultTask = defaultTasks.tasks[indexPath.row]
        let task = tasks[indexPath.row]
        
//        guard let destinationVC = self.storyboard?.instantiateViewController(identifier: "NewTaskViewController") as? NewTaskViewController else { return }
//        destinationVC.task = defaultTask
//        self.navigationController?.pushViewController(destinationVC, animated: true)
        
        guard let newTaskNavigationController = self.storyboard?.instantiateViewController(identifier: "NewTaskNavigationController") as? UINavigationController else { return }
        guard let newTaskViewController = newTaskNavigationController.viewControllers.first as? NewTaskViewController else { return }
        newTaskViewController.task = task
        newTaskViewController.newDataReceived = { [weak self] in
            guard let self = self else { return }
            self.setActualData()
        }
        
        present(newTaskNavigationController, animated: true, completion: nil)
    }
    
//    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
//        return 70
//    }
}

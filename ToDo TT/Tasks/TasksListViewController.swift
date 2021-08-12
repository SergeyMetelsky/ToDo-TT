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
    
    //    MARK:- Properties
    var tasks: [Task] = []
    let defaultTasks: DefaultTasks = DefaultTasks()
    var userId: String = ""
    
    //    MARK:- IBOutlets
    @IBOutlet weak var tableView: UITableView!
    
    //    MARK:- ControllerLifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.title = "Tasks"
        
        tableView.dataSource = self
        tableView.delegate = self
        
        tableView.register(UINib(nibName: "TaskCell", bundle: nil), forCellReuseIdentifier: "TaskCell")
        
        self.userId = Auth.auth().currentUser?.uid ?? ""
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super .viewWillAppear(animated)
        setActualData()
    }
    
    //    MARK:- IBActions
    @IBAction func plusButtonPressed(_ sender: UIBarButtonItem) {
        guard let newTaskNavigationController = self.storyboard?.instantiateViewController(identifier: "NewTaskNavigationController") as? UINavigationController else { return }
        guard let newTaskViewController = newTaskNavigationController.viewControllers.first as? NewTaskViewController else { return }
        newTaskViewController.newDataReceived = { [weak self] in
            guard let self = self else { return }
            self.setActualData()
        }
        
        present(newTaskNavigationController, animated: true, completion: nil)
    }
    
    @IBAction func reloadDataButtonPressed(_ sender: UIButton) {
        setActualData()
    }
    
    //    MARK:- Functions
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

//    MARK:- Extension
extension TasksListViewController: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tasks.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "TaskCell", for: indexPath) as! TaskCell
        let task = self.tasks[indexPath.item]
        cell.setupCell(task: task)
        return cell
    }
    
    func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCell.EditingStyle {
        return .delete
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            let serverManager = ServerManager()
            serverManager.removeTaskFromServer(tasks[indexPath.row])
            tasks.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let task = tasks[indexPath.row]
        guard let newTaskNavigationController = self.storyboard?.instantiateViewController(identifier: "NewTaskNavigationController") as? UINavigationController else { return }
        guard let newTaskViewController = newTaskNavigationController.viewControllers.first as? NewTaskViewController else { return }
        newTaskViewController.task = task
        newTaskViewController.newDataReceived = { [weak self] in
            guard let self = self else { return }
            self.setActualData()
        }
        
        present(newTaskNavigationController, animated: true, completion: nil)
    }
}

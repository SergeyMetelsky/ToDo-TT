//
//  TasksListViewController.swift
//  ToDo TT
//
//  Created by Sergey on 8/11/21.
//

import UIKit

class TasksListViewController: UIViewController {
    var tasks: [Task] = []
    let defaultTasks: DefaultTasks = DefaultTasks()

    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = "Tasks"
        
        tableView.dataSource = self
        tableView.delegate = self
        
        tableView.register(UINib(nibName: "TaskCell", bundle: nil), forCellReuseIdentifier: "TaskCell")
    }
    
    @IBAction func plusButtonPressed(_ sender: UIBarButtonItem) {
    }
}

extension TasksListViewController: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        return tasks.count
        return defaultTasks.tasks.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "TaskCell", for: indexPath) as! TaskCell
        let defaultTask = self.defaultTasks.tasks[indexPath.item]
        cell.setupCell(task: defaultTask)
        return cell
    }
    
//    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
//        return 70
//    }
}

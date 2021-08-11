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
//        guard let destinationVC = self.storyboard?.instantiateViewController(identifier: "NewTaskViewController") else { return }
//        self.navigationController?.pushViewController(destinationVC, animated: true)
        
        guard let destinationVC = self.storyboard?.instantiateViewController(identifier: "NewTaskNavigationController") as? UINavigationController else { return }
        present(destinationVC, animated: true, completion: nil)
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
    
    func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCell.EditingStyle {
        return .delete
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
//            objects.remove(at: indexPath.row)
            defaultTasks.tasks.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let defaultTask = defaultTasks.tasks[indexPath.row]
//        guard let destinationVC = self.storyboard?.instantiateViewController(identifier: "NewTaskViewController") as? NewTaskViewController else { return }
//        destinationVC.task = defaultTask
//        self.navigationController?.pushViewController(destinationVC, animated: true)
        
        guard let destinationVC = self.storyboard?.instantiateViewController(identifier: "NewTaskNavigationController") as? UINavigationController else { return }
        guard let destinationVC2 = destinationVC.viewControllers.first as? NewTaskViewController else { return }
        destinationVC2.task = defaultTask
        present(destinationVC, animated: true, completion: nil)
    }
    
//    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
//        return 70
//    }
}

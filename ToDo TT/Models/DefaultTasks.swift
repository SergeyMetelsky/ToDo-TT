//
//  DefaultTasks.swift
//  ToDo TT
//
//  Created by Sergey on 8/11/21.
//

import Foundation
import UIKit

class DefaultTasks {
    var tasks: [Task] = []
    
    init() {
        setup()
    }
    
    func setup() {
        let task1 = Task(id: "1", userId: "11111", title: "11", description: "111 111")
        let task2 = Task(id: "2", userId: "22222", title: "22", description: "222 222")
        let task3 = Task(id: "3", userId: "33333", title: "33", description: "333 333")
        
        self.tasks = [task1, task2, task3]
    }
}

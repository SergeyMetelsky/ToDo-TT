//
//  ServerManager.swift
//  ToDo TT
//
//  Created by Sergey on 8/12/21.
//

import Foundation
import FirebaseAuth
import FirebaseDatabase

class ServerManager {
    func sendTaskToServer(_ task: Task) {
        
        let json: [String : Any] = ["id" : task.id,
                                    "userId" : task.userId,
                                    "title" : task.title,
                                    "description" : task.description]
        
        let database = Database.database().reference()
        let child = database.child("tasks").child("\(task.id)")
        child.setValue(json) { error, ref in
            
        }
    }
    
    func downloadTasksOnComplete(for userId: String, onComplete: @escaping ([Task]) -> Void, onError: @escaping (String) -> Void) {
        
        let database = Database.database().reference()
        let child = database.child("tasks").queryOrdered(byChild: "userId").queryEqual(toValue: userId)
        
        child.observeSingleEvent(of: .value) { (response) in
            //            print(response.value)
            if let value = response.value as? [String : Any] {
                
                var result: [Task] = []
                for item in value.values {
                    
                    if let taskJson = item as? [String : Any] {
                        
                        if let id = taskJson["id"] as? String,
                           let userId = taskJson["userId"] as? String,
                           let title = taskJson["title"] as? String,
                           let description = taskJson["description"] as? String {
                            
                            let task = Task(id: id, userId: userId, title: title, description: description)
                            result.append(task)
                        }
                    }
                }
                
                onComplete(result)
            } else {
                
                onError("An error occurred while loading tasks!")
            }
        }
    }
}

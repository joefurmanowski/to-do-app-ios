//
//  ToDoModel.swift
//  ToDoApp
//
//  Created by Joseph T. Furmanowski on 11/7/22.
//

import Foundation
import Firebase
import FirebaseDatabase

class ToDoModel
{
    static let sharedInstance = ToDoModel()
    
    let toDoTaskNotification = Notification.Name(rawValue: toDoTaskNotificationKey)
    
    var toDoTasks:[ToDo] = []
    
    let nc = NotificationCenter.default
    
    let toDoDatabaseRef = Database.database().reference(withPath: "ToDoTasks")
    
    var toDoObserverHandle: UInt?
    
    func observeToDoTasks()
    {
        toDoObserverHandle = toDoDatabaseRef.observe(.value, with: {snapshot in var tempToDoTasks:[ToDo] = []
            for child in snapshot.children
            {
                if let data = child as? DataSnapshot
                {
                    if let thisToDoTask = ToDo(snapshot: data)
                    {
                        tempToDoTasks.append(thisToDoTask)
                    }
                }
            }
            self.toDoTasks.removeAll()
            self.toDoTasks = tempToDoTasks
            NotificationCenter.default.post(name: self.toDoTaskNotification, object: nil)
        })

    }
    
    func cancelObserver()
    {
        if let observerHandle = toDoObserverHandle
        {
            toDoDatabaseRef.removeObserver(withHandle: observerHandle)
        }
    }
    
    func createNewToDo(toDoTask: ToDo)
    {
        let newToDoRef = toDoDatabaseRef.child(toDoTask.toDoItemID)
        newToDoRef.setValue(toDoTask.toAnyObject())
    }
    
    func updateToDo(toDoTask: ToDo)
    {
        let newToDoRef = toDoDatabaseRef.child(toDoTask.toDoItemID)
        newToDoRef.setValue(toDoTask.toAnyObject())
    }
    
    func deleteToDo(toDoTask: ToDo)
    {
        let newToDoRef = toDoDatabaseRef.child(toDoTask.toDoItemID)
        newToDoRef.removeValue()
    }
    
}

//
//  ToDo.swift
//  ToDoApp
//
//  Created by Joseph T. Furmanowski on 11/7/22.
//

import Foundation
import Firebase
import FirebaseDatabase

struct ToDo
{
    var ref: DatabaseReference?
    var toDoItemID: String
    var toDoTask: String
    var addedBy: String
    var addedDate: String
    var completedBy: String
    var completedDate: String
    var status: String
    
    init (toDoItemID: String, toDoTask: String, addedBy: String, addedDate: String, completedBy: String, completedDate: String, status: String)
    {
        self.ref = nil
        self.toDoItemID = toDoItemID
        self.toDoTask = toDoTask
        self.addedBy = addedBy
        self.addedDate = addedDate
        self.completedBy = completedBy
        self.completedDate = completedDate
        self.status = status
    }
    
    init? (snapshot: DataSnapshot)
    {
        guard
            let value = snapshot.value as? [String: Any],
            let toDoItemID = value["toDoItemID"] as? String,
            let toDoTask = value["toDoTask"] as? String,
            let addedBy = value["addedBy"] as? String,
            let addedDate = value["addedDate"] as? String,
            let completedBy = value["completedBy"] as? String,
            let completedDate = value["completedDate"] as? String,
            let status = value["status"] as? String
        else
        {
            return nil
        }
        
        self.ref = snapshot.ref
        self.toDoItemID = toDoItemID
        self.toDoTask = toDoTask
        self.addedBy = addedBy
        self.addedDate = addedDate
        self.completedBy = completedBy
        self.completedDate = completedDate
        self.status = status
    }
    
    func toAnyObject() -> Dictionary<String, Any> {
        return
            [
                "toDoItemID": self.toDoItemID,
                "toDoTask": self.toDoTask,
                "addedBy": self.addedBy,
                "addedDate": self.addedDate,
                "completedBy": self.completedBy,
                "completedDate": self.completedDate,
                "status": self.status
            ]
    }
}

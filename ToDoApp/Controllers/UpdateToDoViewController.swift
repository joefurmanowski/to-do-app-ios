//
//  UpdateToDoViewController.swift
//  ToDoApp
//
//  Created by Joseph T. Furmanowski on 11/7/22.
//

import UIKit

class UpdateToDoViewController: UIViewController
{
    
    let userModel = UserModel.sharedInstance
    let toDoModel = ToDoModel.sharedInstance
    var selectedToDoTask: ToDo?

    @IBOutlet weak var toDoTask: UITextView!
    @IBOutlet weak var taskCompleted: UISwitch!
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        taskCompleted.isOn = selectedToDoTask?.completedDate == "N/A" ? false : true
        toDoTask.text = selectedToDoTask?.toDoTask
        hideKeyboardWhenTappedAround()
    }
    
    func getLongDateTime() -> String
    {
        let date = Date()

        let dateFormatter = DateFormatter()

        dateFormatter.dateStyle = .short
        dateFormatter.timeStyle = .short

        return dateFormatter.string(from: date)
    }
    
    @IBAction func updateToDoItem(_ sender: UIBarButtonItem)
    {
        selectedToDoTask?.toDoTask = toDoTask.text
        
        if taskCompleted.isOn
        {
            selectedToDoTask?.status = "completed"
            selectedToDoTask?.completedBy = userModel.currentUser!.profileName
            selectedToDoTask?.completedDate = getLongDateTime()
        }
        else
        {
            selectedToDoTask?.status = "pending"
            selectedToDoTask?.completedBy = "N/A"
            selectedToDoTask?.completedDate = "N/A"
        }
        
        toDoModel.updateToDo(toDoTask: selectedToDoTask!)
        
        // Alert
        let alert = UIAlertController(title: "Success", message: "To do task updated.", preferredStyle: .alert)
        
        // Options
        let close = UIAlertAction(title: "Close", style: .default, handler: { _ in
            print("Close button pressed")
            self.navigationController?.popViewController(animated: true)
        })
        alert.addAction(close)
        
        // Show alert
        self.present(alert, animated: true)
    }
    
    @IBAction func deleteToDoItem(_ sender: UIBarButtonItem)
    {
        // Alert
        let alert = UIAlertController(title: "Confirmation", message: "Are you sure you would like to delete this to do task? It will be permanently deleted and cannot be recovered.", preferredStyle: .alert)
        
        // Options
        let cancel = UIAlertAction(title: "Cancel", style: .cancel, handler: { _ in
            print("Cancel button pressed")
        })
        let delete = UIAlertAction(title: "Yes", style: .destructive, handler: { _ in
            print("Delete button pressed")
            self.toDoModel.deleteToDo(toDoTask: self.selectedToDoTask!)
            self.navigationController?.popViewController(animated: true)
        })
        alert.addAction(cancel)
        alert.addAction(delete)
        
        // Show alert
        self.present(alert, animated: true)
    }
    
}

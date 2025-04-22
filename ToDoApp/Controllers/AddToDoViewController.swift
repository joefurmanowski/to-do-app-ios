//
//  AddToDoViewController.swift
//  ToDoApp
//
//  Created by Joseph T. Furmanowski on 11/7/22.
//

import UIKit

class AddToDoViewController: UIViewController
{

    @IBOutlet weak var toDoTask: UITextView!
    
    let toDoModel = ToDoModel.sharedInstance
    let userModel = UserModel.sharedInstance
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        hideKeyboardWhenTappedAround()
    }
    
    func timeInterval() -> String
    {
        
        let tnow = Date()
        
        var ts = String(tnow.timeIntervalSince1970)
        ts = ts.replacingOccurrences(of: ".", with: "")
        return ts
    }
    
    func getLongDateTime() -> String
    {
        let date = Date()

        let dateFormatter = DateFormatter()

        dateFormatter.dateStyle = .short
        dateFormatter.timeStyle = .short

        return dateFormatter.string(from: date)
    }
    
    @IBAction func addToDoTask(_ sender: UIBarButtonItem)
    {
        guard let _ = toDoTask.text else
        {
            return
        }
        
        let toDoTaskID = timeInterval() // ID in database based on time interval since 1970
        
        let pTime = getLongDateTime()
        
        let pUser = userModel.currentUser!.profileName
        
        let postedMessage = ToDo(toDoItemID: toDoTaskID, toDoTask: toDoTask.text, addedBy: pUser, addedDate: pTime, completedBy: "N/A", completedDate: "N/A", status: "pending")
        
        toDoModel.createNewToDo(toDoTask: postedMessage)
        
        // Alert
        let alert = UIAlertController(title: "Success", message: "To do task created.", preferredStyle: .alert)
        
        // Options
        let close = UIAlertAction(title: "Close", style: .default, handler: { _ in
            print("Close button pressed")
            self.navigationController?.popViewController(animated: true)
        })
        alert.addAction(close)
        
        // Show alert
        self.present(alert, animated: true)  // this will present the Alert
    }
    
}

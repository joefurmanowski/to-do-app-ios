//
//  ToDoTableViewController.swift
//  ToDoApp
//
//  Created by Joseph T. Furmanowski on 11/7/22.
//

import UIKit

class ToDoTableViewController: UITableViewController
{
    
    let toDoTaskNotification = Notification.Name(rawValue: toDoTaskNotificationKey)

    let userModel = UserModel.sharedInstance
    let toDoModel = ToDoModel.sharedInstance

    override func viewDidLoad()
    {
        super.viewDidLoad()
    }
    
    override func viewDidAppear(_ animated: Bool)
    {
        super.viewDidAppear(animated)
        createObservers()
        toDoModel.observeToDoTasks()
    }
    
    override func viewDidDisappear(_ animated: Bool)
    {
        super.viewDidDisappear(animated)
        toDoModel.cancelObserver()
        NotificationCenter.default.removeObserver(self)
    }
    
    func createObservers()
    {
        NotificationCenter.default.addObserver(self, selector: #selector(refreshTable(notification:)), name: toDoTaskNotification, object: nil)
    }
    
    @objc
    func refreshTable(notification: NSNotification)
    {
        self.tableView.reloadData()
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int
    {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        return toDoModel.toDoTasks.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        let cell = tableView.dequeueReusableCell(withIdentifier: "toDoCell", for: indexPath) as! ToDoTableViewCell
        
        let thisToDoTask = toDoModel.toDoTasks[indexPath.row]
        
        cell.toDoTask.text = thisToDoTask.toDoTask
        
        if (thisToDoTask.status == "pending")
        {
            cell.completedBy.isHidden = true
            cell.accessoryType = .none // need this for when cells are reused (adjusts accessory type accordingly)
        }
        else
        {
            cell.completedBy.text = "✅ Completed on \(thisToDoTask.completedDate) by \(thisToDoTask.completedBy)"
            cell.completedBy.isHidden = false
            cell.accessoryType = .checkmark
        }
        
        cell.addedBy.text = "➕ Added on \(thisToDoTask.addedDate) by \(thisToDoTask.addedBy)"
        
        return cell
    }
    
    @IBAction func logOut(_ sender: UIBarButtonItem)
    {
        // Alert
        let alert = UIAlertController(title: "Confirmation", message: "Are you sure you would like to log out? You will need to log in again.", preferredStyle: .alert)
        
        // Options
        let cancel = UIAlertAction(title: "Cancel", style: .cancel, handler: { _ in
            print("Cancel button pressed")
        })
        let logOut = UIAlertAction(title: "Log Out", style: .destructive, handler: { _ in
            print("Log out button pressed")
            self.userModel.logOut()
            print("User signed out")
            self.dismiss(animated: true)
        })
        alert.addAction(cancel)
        alert.addAction(logOut)
        
        // Show alert
        self.present(alert, animated: true)
    }
    
    // MARK: - Navigation
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath)
    {
        performSegue(withIdentifier: "updateToDoSegue", sender: self)
    }
    

    override func prepare(for segue: UIStoryboardSegue, sender: Any?)
    {
        if segue.identifier == "updateToDoSegue" // Since ToDoTVC has two segues we need to differentiate between them to avoid crashes
        {
            let destination_VC = segue.destination as! UpdateToDoViewController
            destination_VC.selectedToDoTask = toDoModel.toDoTasks[self.tableView.indexPathForSelectedRow!.row]
        }
        else {}
    }

}

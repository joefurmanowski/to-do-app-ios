//
//  LoginViewController.swift
//  ToDoApp
//
//  Created by Joseph T. Furmanowski on 11/7/22.
//

import UIKit

class LoginViewController: UIViewController
{
    
    let userModel = UserModel.sharedInstance

    @IBOutlet weak var emailAddress: UITextField!
    @IBOutlet weak var password: UITextField!
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        hideKeyboardWhenTappedAround()
    }
    
    
    @IBAction func logIn(_ sender: UIButton)
    {
        performLogIn()
    }
    
    func performLogIn ()
    {
        Task
        {
            if let enteredEmail = emailAddress.text, let enteredPassword = password.text
            {
                let (result, resultMessage) = try await userModel.logInAsync(withEmail: enteredEmail, andPassword: enteredPassword)
                if result
                {
                    performSegue(withIdentifier: "mainSegue", sender: self)
                }
                else
                {
                    // Alert
                    let alert = UIAlertController(title: "Log In Failed", message: resultMessage, preferredStyle: .alert)
                    
                    // Options
                    alert.addAction(UIAlertAction(title: "OK", style: .default))
                    
                    // Show alert
                    self.present(alert, animated: true, completion: nil)
                }
            }
            else
            {
                // Alert
                let alert = UIAlertController(title: "Log In Failed", message: "Please enter credentials", preferredStyle: .alert)
                
                // Options
                alert.addAction(UIAlertAction(title: "OK", style: .default))
                
                // Show alert
                self.present(alert, animated: true, completion: nil)
            }
        }
    }
    
}

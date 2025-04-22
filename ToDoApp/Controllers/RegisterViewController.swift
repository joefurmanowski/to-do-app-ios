//
//  RegisterViewController.swift
//  ToDoApp
//
//  Created by Joseph T. Furmanowski on 11/7/22.
//

import UIKit

class RegisterViewController: UIViewController
{
    let userModel = UserModel.sharedInstance

    @IBOutlet weak var profileName: UITextField!
    @IBOutlet weak var emailAddress: UITextField!
    @IBOutlet weak var password: UITextField!
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        hideKeyboardWhenTappedAround()
    }
    
    @IBAction func register(_ sender: UIButton)
    {
        if let enteredProfileName = profileName.text,
           let enteredEmail = emailAddress.text,
           let enteredPassword = password.text
        {
            Task {
                let (result, resultMessage) = try await userModel.registerAsync(withEmail: enteredEmail, andPassword: enteredPassword, andProfileName: enteredProfileName)
                if result {
                    print (resultMessage)
                    print (userModel.authenticatedUser!.uid)
                    self.dismiss(animated: true)
                } else {
                    print (resultMessage)
                    
                    // Alert
                    let alert = UIAlertController(title: "Registration Failed", message: resultMessage, preferredStyle: .alert)
                    
                    // Options
                    alert.addAction(UIAlertAction(title: "OK", style: .default))
                    
                    // Show alert
                    self.present(alert, animated: true, completion: nil)
                }
            }
            
        }
        else
        {
            // Alert
            let alert = UIAlertController(title: "Register", message: "Please enter your credentials.", preferredStyle: .alert)
            
            // Options
            alert.addAction(UIAlertAction(title: "OK", style: .default))
            
            // Show alert
            self.present(alert, animated: true, completion: nil)
        }
    }

    @IBAction func cancelRegistration(_ sender: UIButton) {
        self.dismiss(animated: true)
    }
}

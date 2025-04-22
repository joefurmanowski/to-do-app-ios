//
//  ViewController+HideKeyboard.swift
//  ToDoApp
//
//  Created by Joseph T. Furmanowski on 11/13/22.
//

import UIKit

extension UIViewController
{
    func hideKeyboardWhenTappedAround()
    {
        let tap: UIGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboardView))
        tap.cancelsTouchesInView = true
        view.addGestureRecognizer(tap)
    }
    
    @objc
    func dismissKeyboardView()
    {
        view.endEditing(true)
    }
}

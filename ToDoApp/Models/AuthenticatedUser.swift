//
//  AuthenticatedUser.swift
//  ToDoApp
//
//  Created by Joseph T. Furmanowski on 11/10/22.
//

import Foundation
import FirebaseAuth

struct AuthenticatedUser
{
    let uid: String
    let email: String
    
    init (authData: FirebaseAuth.User)
    {
        uid = authData.uid
        email = authData.email!
    }
    
    init (uid: String, email: String)
    {
        self.uid = uid
        self.email = email
    }
    
}

//
//  User.swift
//  ToDoApp
//
//  Created by Joseph T. Furmanowski on 11/7/22.
//

import Foundation
import Firebase
import FirebaseDatabase

struct User
{
    let ref: DatabaseReference?
    let uid: String
    let profileName: String
    let email: String
    
    init(uid: String, profileName: String, email: String)
    {
        self.ref = nil
        self.uid = uid
        self.profileName = profileName
        self.email = email
    }
    
    init?(snapshot: DataSnapshot)
    {
        print (snapshot)
        guard
            let value = snapshot.value as? [String: AnyObject],
            let uid = value["uid"] as? String,
            let profileName = value["profileName"] as? String,
            let email = value["email"] as? String
        else
        {
            return nil
        }
        
        self.ref = snapshot.ref
        self.uid = uid
        self.profileName = profileName
        self.email = email
    }
    
    func toAnyObject() -> Dictionary<String, String>
    {
        return [
            "uid": uid,
            "profileName": profileName,
            "email": email,
        ]
    }
}

//
//  UserModel.swift
//  ToDoApp
//
//  Created by Joseph T. Furmanowski on 11/9/22.
//

import Foundation
import FirebaseAuth
import FirebaseDatabase

class UserModel
{
    static let sharedInstance = UserModel()
    
    var authenticatedUser: AuthenticatedUser?
    var currentUser: User?
    
    private init() {}
    
    func logInAsync(withEmail email: String, andPassword pw: String) async throws -> (Bool, String)
    {
        do
        {
            let authData = try await Auth.auth().signIn(withEmail: email, password: pw)
            authenticatedUser = AuthenticatedUser(uid: authData.user.uid, email: authData.user.email!)
            try await getLoggedInUser()
            return (true, "Log in successful")
        }
        catch
        {
            let err = error
            return (false, err.localizedDescription)
        }
    }
    
    func logOut()
    {
        do
        {
            try Auth.auth().signOut()
        }
        catch let logOutError as NSError
        {
            print("Error logging out: %@", logOutError)
        }
    }
    
    func registerAsync(withEmail email: String, andPassword pw: String, andProfileName name: String) async throws -> (Bool, String)
    {
        do
        {
            let userCreationResponse = try await Auth.auth().createUser(withEmail: email, password: pw)
            authenticatedUser = AuthenticatedUser(uid: userCreationResponse.user.uid, email: userCreationResponse.user.email!)
            newRegisteredUser(withUid: authenticatedUser!.uid, andProfileName: name, andEmail: email)
            return (true, "Successfully registered user")
        }
        catch
        {
            let err = error
            return (false, err.localizedDescription)
        }
    }
    
    func newRegisteredUser(withUid uid: String, andProfileName name: String, andEmail email: String)
    {
        let usersDatabaseRef = Database.database().reference(withPath: "Users")
        let user = User(uid: uid, profileName: name, email: email)
        let userNodeRef = usersDatabaseRef.child(user.uid)
        
        userNodeRef.setValue(user.toAnyObject())
    }
    
    func getLoggedInUser() async throws
    {
        do
        {
            if let uid = authenticatedUser?.uid
            {
                let usersDatabaseRef = Database.database().reference()
                let userData = try await usersDatabaseRef.child("Users/\(uid)").getData()
                
                currentUser = User(snapshot: userData)
            }
        }
        catch
        {
            print("Cannot retrieve user data")
        }
    }
    
    
}

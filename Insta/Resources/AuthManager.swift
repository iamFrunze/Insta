//
//  Auth.swift
//  Insta
//
//  Created by Антон Коротков on 02.02.2022.
//

import Foundation
import FirebaseAuth

open class AuthManager {
  static let shared = AuthManager()

  //MARK: - Public
  public func registerNewUser(username: String, email: String, password: String, completion: @escaping (Bool) -> Void) {
    /*
     - Check if username is available
     - Check if email is available
     - Create account
     - Insert account in database
     */
    DatabaseManager.shared.canCreateNewUser(with: email, username: username) { canCreate in
      if canCreate {
        /*
         - Create account
         - Insert account to database
         */
        Auth.auth().createUser(withEmail: email, password: password) { result, error in
          guard error == nil, result != nil else {
            // Firebase auth could not create account
            completion(false)
            return
          }
          // Insert into database
          DatabaseManager.shared.insertNewUser(with: email, username: username){ inserted in
            if inserted {
              completion(true)
              return
            } else {
              completion(false)
              return
            }
          }
        }
      }
      else {
        // either username or email does exist
        completion(false)
      }
    }
  }

  public func loginUser(username: String?, email: String?, password: String, completion: @escaping (Bool) -> Void) {
    if let email = email {
      // email log in
      Auth.auth().signIn(withEmail: email, password: password) { authResult, error in
        guard authResult != nil, error == nil else {
          completion(false)
          return
        }
        completion(true)
      }
    }
    else if let username = username {
      // username log in
      print("Username :: \(username)")
    }
  }

  public func logOut(completion: (Bool) -> Void) {
    do {
      try Auth.auth().signOut()
      completion(true)
      return
    } catch {
      print(error)
      completion(false)
      return
    }
  }
}

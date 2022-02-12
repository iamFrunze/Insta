//
//  DatabseManager.swift
//  Insta
//
//  Created by Антон Коротков on 02.02.2022.
//

import Foundation
import FirebaseDatabase

open class DatabaseManager {
  static let shared = DatabaseManager()

  private let database = Database.database().reference()

  // MARK: - Public

  /// Check if username and email is available
  ///  - Parameters
  ///     - email: String representing email
  ///     - username: String representin username
  public func canCreateNewUser(with email: String, username: String, completion: (Bool) -> Void) {
      completion(true)
  }

  /// Insert new user data to database
  ///  - Parameters
  ///     - email: String representing email
  ///     - username: String representin username
  ///     - completion: Async callback for result if database entry succeeded
  public func insertNewUser(with email: String, username: String, completion: @escaping (Bool) -> Void){
    database.child(email.safeDatabaseKey()).setValue(["username": username]) { error, _ in
      if error == nil {
        // Succeeded
        completion(true)
        return
      } else {
        // Failed
        completion(false)
        return
      }
    }
  }

  // MARK: - Private

}

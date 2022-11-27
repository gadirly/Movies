//
//  DBManager.swift
//  Netflix
//
//  Created by Gadirli on 20.11.22.
//

import Foundation
import FirebaseDatabase
import FirebaseAuth

class DBManager {
    public static let shared: DBManager = DBManager()
    
    private let database = Database.database().reference()
    
    public func addUser(with user: NetflixUser, completion: @escaping (Bool) -> Void) {
        database.child(user.safeEmail).setValue([
            "first_name": user.firstName,
            "last_name": user.lastName
        ]) { error, _ in
            guard error == nil else {
                print("Failed to add user to database")
                completion(false)
                return
            }
            
            completion(true)
        }
    }
    
    public func getUserInformation(completion: @escaping (String) -> Void){
        
        
        guard let userEmail = Auth.auth().currentUser?.email else
        {
            return
        }
        
        var safeEmail = userEmail.replacingOccurrences(of: ".", with: "-")
        safeEmail = safeEmail.replacingOccurrences(of: "@", with: "-")
        
        database.child(safeEmail).observeSingleEvent(of: .value) { snapshot in
            guard let value = snapshot.value as? NSDictionary else {
                
                return
                
            }
            
            let name = "\(value["first_name"] as? String ?? "") \(value["last_name"] as? String ?? "")"
            
            completion(name)
            

        }
        
        
        
    }
    
    
    
}

struct NetflixUser {
    let firstName: String
    let lastName: String
    let emailAddress: String
    
    var safeEmail: String {
        var safeEmail = emailAddress.replacingOccurrences(of: ".", with: "-")
        safeEmail = safeEmail.replacingOccurrences(of: "@", with: "-")
        return safeEmail
    }
    
    var profilePictureFileName: String {
        return "\(safeEmail)_profile_picture.png"
    }
}

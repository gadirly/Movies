//
//  StorageManager.swift
//  Netflix
//
//  Created by Gadirli on 25.11.22.
//

import Foundation
import FirebaseStorage
import FirebaseAuth

class StorageManager {
    static let shared = StorageManager()
    
    private let storage = Storage.storage().reference()
    
    /// Uploads picture to firebase storage and returns completion with url string to download
    public func uploadProfilePicture(with data: Data, fileName: String, completion: @escaping (Result<String, Error>) -> Void) {
        storage.child("images/\(fileName)").putData(data, metadata: nil) { metadata, error in
            guard error == nil else {
                print("Failed to upload data to firebase for profile picture")
                completion(.failure(StorageErrors.failedToUpload))
                return
            }
            
            self.storage.child("images/\(fileName)").downloadURL { url, error in
                guard let url = url else {
                    print("Can't get url for download profile picture")
                    completion(.failure(StorageErrors.failedToGetDownloadUrl))
                    return
                }
                
                let urlString = url.absoluteString
                print("Download url returned: \(urlString)")
                completion(.success(urlString))
            }
            
        }
    }
    
    public func getProfilePicutre(completion: @escaping (String) -> Void) {
        
        guard let email = Auth.auth().currentUser?.email else {
            return
        }
        
        var safeEmail = email.replacingOccurrences(of: ".", with: "-")
        safeEmail = safeEmail.replacingOccurrences(of: "@", with: "-")
        
        self.storage.child("images/\(safeEmail)_profile_picture.png").downloadURL { url, error in
            guard let url = url else {
                print("Can't get url for download profile picture")
                completion("Error fetch photo url")
                return
            }
            
            let urlString = url.absoluteString
            print("Download url returned: \(urlString)")
            completion(urlString)
        }
    }
    
    public enum StorageErrors: Error {
        case failedToUpload
        case failedToGetDownloadUrl
    }
}

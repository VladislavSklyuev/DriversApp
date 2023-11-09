//
//  StorageService.swift
//  FirstGradProject2
//
//  Created by Владислав Склюев on 16.08.2023.
//

import Foundation
import FirebaseStorage
import UIKit

class StorageService {
    static let shared = StorageService(); private init() { }
    private let storage = Storage.storage()
    private let storageRef = Storage.storage().reference()
    private var carsReference: StorageReference { storageRef.child("Cars") }
    
    func upload(id: String, image: [Data]) {

        let metadata = StorageMetadata()
        metadata.contentType = "image/jpg"
        
        for (index, value) in image.enumerated() {
            
                storageRef.child("Cars").child(id).child(String(index)).putData(value, metadata: metadata)
        }
    }
    
        func downloadPicture(withName name: String, by id: String, in collection: PicCollection) async throws -> UIImage? {
            let filePath = storageRef.child(collection.rawValue).child(id).child(name)
            let data = try await filePath.data(maxSize: 6 * 1024 * 1024)
            let uiImage = UIImage(data: data)
            return uiImage
        }
}

//class StorageService {
//    static let shared = StorageService(); private init() { }
//    private let storage = Storage.storage().reference()
//
//    private var carsReference: StorageReference { storage.child("Cars") }
//    private var newsReference: StorageReference { storage.child("News") }
//
//    func upload(id: String, image: Data) {
//
//        let metadata = StorageMetadata()
//        metadata.contentType = "image/jpg"
//
//        carsReference.child(id).putData(image, metadata: metadata)
//    }
//
//    func downloadPicture(withName name: String, by id: String, in collection: PicCollection) async throws -> UIImage? {
//        let filePath = storage.child(collection.rawValue).child(id).child(name)
//        let data = try await filePath.data(maxSize: 6 * 1024 * 1024)
//        let uiImage = UIImage(data: data)
//        return uiImage
//    }
//}

enum PicCollection: String {
    case cars = "Cars"
    case news = "News"
}

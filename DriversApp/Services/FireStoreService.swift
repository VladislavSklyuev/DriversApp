//
//  FireStoreService.swift
//  FirstGradProject2
//
//  Created by Владислав Склюев on 10.08.2023.
//

import Foundation
import FirebaseFirestore

class FireStoreService {
    static let shared = FireStoreService(); private init() { }
    private let database = Firestore.firestore()
    
    private var driversReference: CollectionReference { database.collection("drivers") }
    private var profilesReference: CollectionReference { database.collection("profiles") }
    private var carsReference: CollectionReference { database.collection("cars") }
    private var newsReference: CollectionReference { database.collection("news") }
    
    func getDrivers() async throws -> [Driver] {
        let snapshot = try await driversReference.getDocuments()
        let docs = snapshot.documents
        
        let drivers = docs.map { snapshot in
            Driver(snapshot: snapshot)!
        }
        
        return drivers
    }
    
    func deleteCar(id: String) async throws {
        let docPath = carsReference.document(id).documentID
        
        try await database.collection("cars").document(docPath).delete()
    }
    
    func deleteDriver(id: String) async throws {
        let docPath = driversReference.document(id).documentID
        
        try await database.collection("drivers").document(docPath).delete()
    }
    
    func getCars() async throws -> [Car] {
        let snapshot = try await carsReference.getDocuments()
        let docs = snapshot.documents
        
        var allCars = [Car]()
        
        for doc in docs {
            if var car = Car(snapshot: doc) {
                let picturesRef = carsReference.document(car.id).collection("pictures")
                let picSnap = try await picturesRef.getDocuments()
                let picDocs = picSnap.documents
                var pics = [Picture]()
                
                for picDoc in picDocs {
                    if let pic = Picture(snapshot: picDoc) {
                        pics.append(pic)
                    }
                }
                car.images = pics
                
                allCars.append(car)
            }
            
        }
        
        return allCars
    }
    
    
    func getUserData(id: String) async throws -> Profile {
        let docPath = profilesReference.document(id)
        let snapshot = try await docPath.getDocument()
        guard let profile = Profile(snapshot: snapshot) else { throw FirestoreError.invalidProfile }
        return profile
    }
    
    
    func changeDriverData(driver: Driver) async throws {
        let docPath = driversReference.document(driver.id)
        try await docPath.setData(driver.representation)
    }
    
    func setCarData(car: Car) async throws {
        let docPath = carsReference.document(car.id)
        try await docPath.setData(car.representation)
        
    }
    
    func setPictures(car: Car) async throws {
        for num in 0..<4 {
            let str = String(num)
            let picture = Picture(id: str)
            let docPath = carsReference.document(car.id).collection("pictures").document(str)
            try await docPath.setData(picture.representation)
        }
    }
    
//    func setCars(car: Car, image: Data, completion: @escaping (Result<Car, Error>) -> ()) {
//        StorageService.shared.upload(id: car.id, image: image) { result in
//            
//            switch result {
//            case .success(let sizeInfo):
//                print(sizeInfo)
//                
//                self.carsReference.document(car.id).setData(car.representation) { error in
//                    if let error = error {
//                        completion(.failure(error))
//                    } else {
//                        completion(.success(car))
//                    }
//                }
//                
//            case .failure(let error):
//                completion(.failure(error))
//            }
//        }
//    }
    
}

enum FirestoreError: Error {
    case invalidProfile
}


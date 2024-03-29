//
//  DataManager.swift
//  PersonalCapStone
//
//  Created by Tyler May on 2/15/24.
//

import Foundation
import Firebase
import FirebaseFirestoreSwift

enum FetchErrors: Error {
    case noCurrentUser
    case documentNotFound
    case fetchingError(Error)
}

extension CarsController {
    
    func fetchFavoriteCars() async throws -> [Car] {
        
        guard let currentUserUID = Auth.auth().currentUser?.uid else {
            throw FetchErrors.noCurrentUser
        }
        let db = Firestore.firestore()
        
        let arrOfData = try await db.collection("users").document(currentUserUID).collection("FavoriteCars").getDocuments().documents.map {
            do {
                return try $0.data(as: Car.self)
            } catch {
                print(error)
                fatalError("Error loading Cars")
            }
        }
        return arrOfData as [Car]
    }
    
    func addToFavorites(carData: Car) {
        let db = Firestore.firestore()
        let currentUserUID = Auth.auth().currentUser?.uid ?? ""
        let ref = db.collection("users").document(currentUserUID).collection("FavoriteCars").document(carData.id)
        
        do {
            let data = try Firestore.Encoder().encode(carData)
            
            ref.setData(data) { err in
                if let err = err {
                    print("Error adding document: \(err)")
                } else {
                    print("Document added with ID: \(ref.documentID)")
                }
            }
        } catch {
            print("Failed to encode car")
        }
    }
    
    func deleteFavoriteCars(firestoreID: String?) {
        let db = Firestore.firestore()
        let currentUserUID = Auth.auth().currentUser?.uid ?? ""
        if let carId = firestoreID {
            Task {
                do {
                    try await db.collection("users").document(currentUserUID).collection("FavoriteCars").document(carId).delete()
                } catch {
                    print("error: \(error.localizedDescription)")
                }
            }
        } else {
            print("Unable to delete favorite car")
        }
    }
    
    func addToImageCollection() {
        guard !imageDictionary.isEmpty else {
            return
        }
        let db = Firestore.firestore()
        let currentUserUID = Auth.auth().currentUser?.uid ?? ""
        let ref = db.collection("users").document(currentUserUID).collection("CarImages").document("imageDictionary")
        
        do {
            let data = try Firestore.Encoder().encode(imageDictionary)
            
            ref.setData(data) { err in
                if let err = err {
                    print("Error adding document: \(err)")
                } else {
                    print("Document added with ID: \(ref.documentID)")
                }
            }
        } catch {
            print("Unable to add Images")
        }
    }
    
    func fetchImages() async throws -> [String: Any]? {
        guard let currentUserUID = Auth.auth().currentUser?.uid else {
            throw FetchErrors.noCurrentUser
        }
        let db = Firestore.firestore()
        let ref = db.collection("users").document(currentUserUID).collection("CarImages").document("imageDictionary")
        
        do {
            let document = try await ref.getDocument()
            
            guard let data = document.data() else {
                throw FetchErrors.documentNotFound
            }
            
            return data
        } catch {
            throw FetchErrors.fetchingError(error)
        }
        
    }
    
}

//
//  DataManager.swift
//  PersonalCapStone
//
//  Created by Tyler May on 2/15/24.
//

import Foundation
import Firebase
import FirebaseFirestoreSwift


extension CarsController {
    
    func fetchFavoriteCars() async throws -> [Car] {
        let db = Firestore.firestore()
        let arrOfData = try await db.collection("FavoriteCars").getDocuments().documents.map {
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
        let ref = db.collection("FavoriteCars").document(carData.id)
        
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
        if let carId = firestoreID {
            Task {
                do {
                    try await db.collection("FavoriteCars").document(carId).delete()
                } catch {
                    print("error: \(error.localizedDescription)")
                }
            }
        } else {
            print("Unable to delete favorite car")
        }
    }


}

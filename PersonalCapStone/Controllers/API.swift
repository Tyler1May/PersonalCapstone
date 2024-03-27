//
//  API.swift
//  PersonalCapStone
//
//  Created by Tyler May on 2/7/24.
//

import Foundation
import SwiftUI
import Firebase
import FirebaseFirestore


enum APICallErrors: Error, LocalizedError {
    case invalidSearchParam
    case invalidURl
    case invalidJson
    case invalidResponse
}

class API {
    static let baseUrl = "https://api.api-ninjas.com/v1/cars?"
    var searchText: String = String()
    
    static let shared = API()
    
    @Published var imageDictionary: [String: String] = [:]
    @Published var isLoaded = false
    
    func setUpDictionary() {
        if let currentUserUID = Auth.auth().currentUser?.uid {
            Task {
                do {
                    let dictionary = try await Firestore.firestore().collection("users").document(currentUserUID).collection("CarImages").document("imageDictionary").getDocument()
                    DispatchQueue.main.async {
                        if let data = dictionary.data() {
                            self.imageDictionary = data.compactMapValues { value in
                                value as? String
                            }
                        } else {
                            self.imageDictionary = [:]
                        }
                        CarsController.shared.setUpSubscribers()
                    }
                }
            }
        } else {
            imageDictionary = [:]
        }
        
    }
    
    static func getCars(param: String, year: String, searchText: String) async throws -> [Car] {
        let url = URL(string: "\(API.baseUrl)")!
        
        var components = URLComponents(url: url, resolvingAgainstBaseURL: true)!
        
        components.queryItems = [
            "limit": "1",
            "\(param.lowercased())": "\(searchText)",
            "year": "\(year)"
        ].map { URLQueryItem(name: $0.key, value: $0.value) }
        
        var request = URLRequest(url: components.url!)
        request.httpMethod = "GET"
        request.addValue("Wtf7Qc0cOWRaN24Gmf43QA==bwMwyxo6DJHh2yZr", forHTTPHeaderField: "X-Api-Key")
                
        let (data, response) = try await URLSession.shared.data(for: request)
        
        let str = String(data: data, encoding: .utf8)
        print(String(describing: str))
        
        guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 else {
            throw APICallErrors.invalidSearchParam
        }
        
        let decoder = JSONDecoder()
        let cars = try decoder.decode([ApiCar].self, from: data)
        return cars.compactMap {
            $0.toCar()
        }
        
    }
    
    func getCarImg(q: String) async throws -> String? {
        
        if imageDictionary.keys.contains(q) {
            return imageDictionary[q]
        } else {
            let url = URL(string: "https://www.googleapis.com/customsearch/v1?key=AIzaSyAVbz2mZPOpBNkzY5EXGI45fvDXyKAoeKU&cx=66dab38731f5e4960&q=\(q) front three-quarter view&searchType=image&num=1")!
            
            let (data, response) = try await URLSession.shared.data(from: url)
            
            //        let str = String(data: data, encoding: .utf8)
            //        print(String(describing: str))
            
            guard let httpResponse = response as? HTTPURLResponse else {
                throw APICallErrors.invalidResponse
            }
            
            if httpResponse.statusCode == 429 {
                return nil
            } else if httpResponse.statusCode != 200 {
                throw APICallErrors.invalidJson
            }
            
            guard let json = try JSONSerialization.jsonObject(with: data) as? [String: Any] else { throw APICallErrors.invalidJson }
            
            if let items = json["items"] as? [[String: Any]] {
                for item in items {
                    if let link = item["link"] as? String {
                        imageDictionary[q] = link
                        return link
                    }
                }
            }
            
            return nil
            
        }
    }
}



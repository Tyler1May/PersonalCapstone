//
//  API.swift
//  PersonalCapStone
//
//  Created by Tyler May on 2/7/24.
//

import Foundation
import SwiftUI

enum APICallErrors: Error, LocalizedError {
    case invaldSearchParam
}

struct API {
    static let baseUrl = "https://api.api-ninjas.com/v1/cars?"
    var searchParam: String
    var searchText: String
    
    func getCars() async throws -> [Car] {
        let url = URL(string: "\(API.baseUrl)")!
        
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        request.addValue("X-Api-Key", forHTTPHeaderField: "Wtf7Qc0cOWRaN24Gmf43QA==bwMwyxo6DJHh2yZr")
        
        let parameters: [String: Any] = [
            "\(searchParam)": searchText,
            "limit": 50
        ]
        
        request.httpBody = try JSONSerialization.data(withJSONObject: parameters)
        
        let (data, response) = try await URLSession.shared.data(for: request)
        
        guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 else {
            throw APICallErrors.invaldSearchParam
        }
        
        let decoder = JSONDecoder()
        let car = try decoder.decode([Car].self, from: data)
        return car
        
    }
}



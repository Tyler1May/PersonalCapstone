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
    var searchText: String
    
    static func getCars(param: String, searchText: String) async throws -> [Car] {
        let url = URL(string: "\(API.baseUrl)")!
        
        var components = URLComponents(url: url, resolvingAgainstBaseURL: true)!
        
        components.queryItems = [
            "limit": "50",
            "\(param.lowercased())": "\(searchText)"
        ].map { URLQueryItem(name: $0.key, value: $0.value) }
        
        var request = URLRequest(url: components.url!)
        request.httpMethod = "GET"
        request.addValue("Wtf7Qc0cOWRaN24Gmf43QA==bwMwyxo6DJHh2yZr", forHTTPHeaderField: "X-Api-Key")
                
        let (data, response) = try await URLSession.shared.data(for: request)
        
        let str = String(data: data, encoding: .utf8)
        print(String(describing: str))
        
        guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 else {
            throw APICallErrors.invaldSearchParam
        }
        
        let decoder = JSONDecoder()
        let cars = try decoder.decode([Car].self, from: data)
        return cars
        
    }
}



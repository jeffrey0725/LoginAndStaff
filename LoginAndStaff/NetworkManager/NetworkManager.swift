//
//  NetworkManager.swift
//  LoginAndStaff
//
//  Created by Jeffrey Cheung on 24/9/2025.
//

import Foundation
import Combine

class NetworkManager {
    static let shared = NetworkManager()
    
    func request<T: Decodable, Body: Encodable>(_ urlString: String, _ method: String, _ headers: [String: String], _ query: [String: String]?, _ body: Body?) -> AnyPublisher<T, Error> {
        var components = URLComponents(string: urlString)!
        if let _query = query {
            components.queryItems = _query.map({ URLQueryItem(name: $0.key, value: $0.value) })
        }
        
        var request = URLRequest(url: components.url!, cachePolicy: .reloadIgnoringLocalAndRemoteCacheData)
        request.httpMethod = method
        
        // api key and content type must add into header
        request.setValue("reqres-free-v1", forHTTPHeaderField: "x-api-key")
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        headers.forEach({ (key, value) in
            request.setValue(value, forHTTPHeaderField: key)
        })
        
        if let _body = body {
            do {
                request.httpBody = try JSONEncoder().encode(_body)
            } catch {
                return Fail(error: error).eraseToAnyPublisher()
            }
        }
        
        return URLSession.shared.dataTaskPublisher(for: request)
            .tryMap(({ (data, response) in
                return data
            }))
            .decode(type: T.self, decoder: JSONDecoder())
            .receive(on: DispatchQueue.main)
            .eraseToAnyPublisher()
    }
}

struct ApiDomain {
    let domain: String = "https://reqres.in/"
}

struct ApiPath {
    let login = "api/login"
}

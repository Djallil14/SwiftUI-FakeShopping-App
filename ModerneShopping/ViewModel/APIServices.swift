//
//  APIServices.swift
//  ModerneShopping
//
//  Created by Djallil Elkebir on 2021-09-02.
//

import Foundation

class APIServices {
    
    static let shared = APIServices()
    private let baseURL = "https://fakestoreapi.com/products"
    private let userURL = "https://randomuser.me/api/"
    private let apiCall = URLSession.shared
    
    func fetchProducts(from endpoint: ProductListEndpoint, completion: @escaping (Result<[Product], APICallError>) -> ()){
        guard let url = URL(string: "\(baseURL)\(endpoint.description)") else {
            completion(.failure(.invalidEndpoint))
            return
        }
        loadURLAndDecode(url: url, completion: completion)
    }
    func fetchUser(completion: @escaping (Result<Results, APICallError>) -> ()){
        guard let url = URL(string: "\(userURL)") else {
            completion(.failure(.invalidEndpoint))
            return
        }
        loadURLAndDecode(url: url, completion: completion)
    }
}


enum ProductListEndpoint: String, CaseIterable {
    
    case all = "All"
    case jewelery = "Jewelery"
    case electronics = "electronics"
    case men = "men's clothing"
    case women = "women's clothing"
    
    var description: String {
        switch self {
        case .all: return "/"
        case .jewelery: return "/category/jewelery"
        case .electronics: return "/category/electronics"
        case .men: return "/category/men's%20clothing"
        case .women: return "/category/women's%20clothing"
        }
    }
}

extension APIServices {

    private func loadURLAndDecode<T: Decodable>(url: URL, parameters: [String: String]? = nil, completion: @escaping (Result<T, APICallError>)-> ()){
        guard let urlComponents = URLComponents(url: url, resolvingAgainstBaseURL: false) else {
            completion(.failure(.invalidEndpoint))
            return
        }
        
        guard let finalURL = urlComponents.url else {
            completion(.failure(.invalidEndpoint))
            return
        }
        apiCall.dataTask(with: finalURL){ (data, response, error) in
            
            if error != nil {
                completion(.failure(.apiError))
            }
            guard let urlResponse = response as? HTTPURLResponse, 200..<300 ~= urlResponse.statusCode else {
                completion(.failure(.invalidResponse))
                return
            }
            
            guard let data = data else {
                completion(.failure(.noData))
                return
            }
            
            do {
                let decodedData = try JSONDecoder().decode(T.self, from: data)
                completion(.success(decodedData))
            } catch {
                completion(.failure(.decodingError))
            }
        }.resume()
    }
}

enum APICallError: Error, CustomNSError {
    case apiError
    case invalidEndpoint
    case noData
    case invalidResponse
    case decodingError
    
    var localizedDescription: String {
        switch self {
        case .apiError: return "Failed to fetch data"
        case .invalidEndpoint: return "Invalid endpoint"
        case .invalidResponse: return "Invalid response"
        case .noData: return "No data"
        case .decodingError: return "Failed to decode data"
        }
    }
    
    var errorUserInfo: [String : Any] {
        [NSLocalizedDescriptionKey: localizedDescription]
    }
}

//
//  NetworkManager.swift
//  SWAPI
//
//  Created by Dmitriy Panferov on 11/07/23.
//

import Foundation

enum Link {
    case rootApi
    case characters
    case starships
    case planets
    
    var url: URL {
        switch self {
        case .rootApi:
            return URL(string: "https://swapi.dev/api/")!
        case .characters:
            return URL(string: "https://swapi.dev/api/people/")!
        case .starships:
            return URL(string: "https://swapi.dev/api/starships/")!
        case .planets:
            return URL(string: "https://swapi.dev/api/planets/")!
        }
    }
}

enum NetworkError: Error {
    case invalidURL
    case noData
    case decodingError
}

final class NetworkManager {
    static let shared = NetworkManager()
    
    private init() {}
    
    //MARK: - Fetch Data
    func fetchData<T: Decodable>(
        _ type: T.Type,
        from url: URL,
        completion: @escaping(Result<T, NetworkError>) -> Void
    ) {
        URLSession.shared.dataTask(with: url) { data, _, error in
            guard let data else {
                completion(.failure(.noData))
                print(error?.localizedDescription ?? "No error description")
                return
            }
            
            do {
                let decoder = JSONDecoder()
                decoder.keyDecodingStrategy = .convertFromSnakeCase
                let dataModel = try decoder.decode(T.self, from: data)
                DispatchQueue.main.async {
                    completion(.success(dataModel))
                }
            } catch {
                completion(.failure(.decodingError))
            }
        }.resume()
    }
    
    func fetchPage<T: Decodable>(
        _ type: T.Type,
        from url: String?,
        completion: @escaping(Result<T, NetworkError>) -> Void
    ) {
        guard let stringURL = url, let url = URL(string: stringURL) else {
            return
        }
        URLSession.shared.dataTask(with: url) { data, _, error in
            guard let data else {
                completion(.failure(.noData))
                print(error?.localizedDescription ?? "No error description")
                return
            }
            
            do {
                let decoder = JSONDecoder()
                decoder.keyDecodingStrategy = .convertFromSnakeCase
                let dataModel = try decoder.decode(T.self, from: data)
                DispatchQueue.main.async {
                    completion(.success(dataModel))
                }
            } catch {
                completion(.failure(.decodingError))
            }
        }.resume()
    }
}

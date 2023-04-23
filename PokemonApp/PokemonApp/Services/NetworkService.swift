//
//  NetworkService.swift
//  PokemonApp
//
//  Created by Carolina on 23.04.23.
//

import Foundation

import UIKit
import Alamofire
import AlamofireImage
import SwiftyJSON

enum NetworkError: Error {
    case invalidUrl
    case invalidResponse
    case invalidData
}

final class NetworkService {
    static let urlForListOfPokemons = "https://pokeapi.co/api/v2/pokemon"
    
    static func getPokemons(completion: @escaping (Result<MainResultResponse, Error>) -> Void) {
        guard let url = URL(string: NetworkService.urlForListOfPokemons) else {
            completion(.failure(NetworkError.invalidUrl))
            return
        }
       
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            
            if let error = error {
                completion(.failure(error))
                return
            }
            
            guard let httpResponse = response as? HTTPURLResponse,
                  (200...299).contains(httpResponse.statusCode) else {
                completion(.failure(NetworkError.invalidResponse))
                return
            }
            
            guard let data = data else {
                completion(.failure(NetworkError.invalidData))
                return
            }
            
            do {
                let mainResultResponse = try JSONDecoder().decode(MainResultResponse.self, from: data)
                completion(.success(mainResultResponse))
            } catch {
                completion(.failure(error))
            }
        }
        task.resume()
    }
}

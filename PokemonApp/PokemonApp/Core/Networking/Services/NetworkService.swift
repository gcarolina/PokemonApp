//
//  NetworkService.swift
//  PokemonApp
//
//  Created by Carolina on 23.04.23.
//

import UIKit
import Alamofire
import AlamofireImage
import SwiftyJSON

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
                
                let mainResultResponseObject = MainResultResponseObject()
                mainResultResponseObject.count = mainResultResponse.count
                mainResultResponseObject.next = mainResultResponse.next
                mainResultResponseObject.previous = mainResultResponse.previous
                
                for result in mainResultResponse.results {
                    let resultObject = ResultResponseObject()
                    resultObject.name = result.name
                    resultObject.url = result.url
                    
                    mainResultResponseObject.results.append(resultObject)
                }
                StorageManager.savePokemonsInfo(mainResultResponseObject: mainResultResponseObject)
                completion(.success(mainResultResponse))
            } catch {
                completion(.failure(error))
            }
        }
        task.resume()
    }
    
    static func getPokemonInfo(pokemonUrl: String, completion: @escaping (Result<PokemonCharacteristics, Error>) -> Void) {
        guard let url = URL(string: pokemonUrl) else {
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
                let pokemonCharacteristics = try JSONDecoder().decode(PokemonCharacteristics.self, from: data)
                completion(.success(pokemonCharacteristics))
            } catch {
                completion(.failure(error))
            }
        }
        task.resume()
    }
    
    static func getPhoto(imageURL: String, callback: @escaping (_ image: UIImage?, _ error: Error?) -> Void) {
        if let image = CacheManager.shared.imageCache.image(withIdentifier: imageURL) {
            callback(image, nil)
        } else {
            AF.request(imageURL).responseImage { response in
                if case .success(let image) = response.result {
                    CacheManager.shared.imageCache.add(image, withIdentifier: imageURL)
                    callback(image, nil)
                } else {
                    callback(nil, response.error)
                }
            }
        }
    }
}

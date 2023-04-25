//
//  StorageManager.swift
//  PokemonApp
//
//  Created by Carolina on 24.04.23.
//

import Foundation
import RealmSwift

let realm = try! Realm()

class StorageManager {
    static func getAllPokemons() -> Results<MainResultResponseObject> {
        realm.objects(MainResultResponseObject.self)
    }
    
    static func savePokemonsInfo(mainResultResponseObject: MainResultResponseObject) {
        do {
            try realm.write {
                realm.add(mainResultResponseObject)
            }
        } catch {
            print(error)
        }
    }
}

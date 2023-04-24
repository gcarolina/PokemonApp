//
//  MainResultResponseObject.swift
//  PokemonApp
//
//  Created by Carolina on 24.04.23.
//

import Foundation
import RealmSwift

class MainResultResponseObject: Object {
    @objc dynamic var count: Int = 0
    @objc dynamic var next: String = ""
    @objc dynamic var previous: String? = nil
    let results = List<ResultResponseObject>()
}

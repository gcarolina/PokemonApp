//
//  ResultResponseObject.swift
//  PokemonApp
//
//  Created by Carolina on 25.04.23.
//

import Foundation
import RealmSwift

class ResultResponseObject: Object {
    @objc dynamic var name: String = ""
    @objc dynamic var url: String = ""
}

//
//  CacheManager.swift
//  PokemonApp
//
//  Created by Carolina on 23.04.23.
//

import UIKit
import AlamofireImage

final class CacheManager {
    let imageCache: AutoPurgingImageCache

    init(memoryCapacity: UInt64, preferredMemoryUsageAfterPurge: UInt64) {
        imageCache = AutoPurgingImageCache(
            memoryCapacity: memoryCapacity,
            preferredMemoryUsageAfterPurge: preferredMemoryUsageAfterPurge
        )
    }
}

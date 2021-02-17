//
//  ConfigResponseModel.swift
//  TheMovieDBAPI
//
//  Created by Umut SERIFLER on 16/02/2021.
//  Copyright © 2021 UmutSERIFLER. All rights reserved.
//

struct ConfigResponseModel: Decodable {
    let images: ImagesConfigModel
    let change_keys: [String]

    struct ImagesConfigModel: Decodable {
        let base_url: String
        let secure_base_url: String
        let backdrop_sizes: [String]
        let logo_sizes: [String]
        let poster_sizes: [String]
        let profile_sizes: [String]
        let still_sizes: [String]
    }
    
    enum ImageResolution:Int {
        case low = 0
        case medium
        case high
    }
    
    func getImageResolutionSize(size: ImageResolution = .low) -> String? {
        if images.logo_sizes.isEmpty { return nil }
        switch size {
        case .low:
            return images.logo_sizes.first
        case .medium:
            let middleIndex = (images.logo_sizes.count - 1) / 2
            return images.logo_sizes[middleIndex]
        case .high:
            return images.logo_sizes.last
        }
    }
    
}

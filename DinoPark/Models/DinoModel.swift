//
//  DinoModel.swift
//  DinoPark
//
//  Created by Andersson on 31/01/25.
//

import Foundation

struct DinoModel: Decodable {
    let id: Int
    let name: String
    let type: String
    let latitude: Double
    let longitude: Double
    let movies: [String]
    let movieScenes: [MovieScene]
    let link: String
    
    struct MovieScene: Decodable {
        let id: Int
        let movie: String
        let sceneDescription: String
    }
}

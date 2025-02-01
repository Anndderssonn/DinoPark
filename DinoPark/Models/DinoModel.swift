//
//  DinoModel.swift
//  DinoPark
//
//  Created by Andersson on 31/01/25.
//

import SwiftUI

struct DinoModel: Decodable, Identifiable {
    let id: Int
    let name: String
    let type: DinoType
    let latitude: Double
    let longitude: Double
    let movies: [String]
    let movieScenes: [MovieScene]
    let link: String
    
    var image: String {
        name.lowercased().replacingOccurrences(of: " ", with: "")
    }
    
    struct MovieScene: Decodable {
        let id: Int
        let movie: String
        let sceneDescription: String
    }
    
    enum DinoType: String, Decodable {
        case land
        case air
        case sea
        
        var backgroundColor: Color {
            switch self {
            case .land: return Color.brown
            case .air: return Color.teal
            case .sea: return Color.blue
            }
        }
    }
}

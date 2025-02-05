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
}

enum DinoType: String, Decodable, CaseIterable, Identifiable {
    case land
    case air
    case sea
    case all
    
    var id: DinoType { self }
    
    var backgroundColor: Color {
        switch self {
        case .land: return Color.brown
        case .air: return Color.teal
        case .sea: return Color.blue
        case .all: return Color.purple
        }
    }
    
    var icon: String {
        switch self {
        case .land: return "leaf.fill"
        case .air: return "wind"
        case .sea: return "drop.fill"
        case .all: return "square.stack.3d.up.fill"
        }
    }
}

//
//  DinoDecodable.swift
//  DinoPark
//
//  Created by Andersson on 31/01/25.
//

import Foundation

class DinoDecodable {
    var dinos: [DinoModel] = []
    
    init () {
        decodeDinoData()
    }
    
    func decodeDinoData() {
        if let url = Bundle.main.url(forResource: "jpapexpredators", withExtension: "json") {
            do {
                let data = try Data(contentsOf: url)
                let decoder = JSONDecoder()
                decoder.keyDecodingStrategy = .convertFromSnakeCase
                dinos = try decoder.decode([DinoModel].self, from: data)
            } catch {
                print("Error decoding JSON data: \(error)")
            }
        }
    }
    
    func searchDinos(for searchTerm: String) -> [DinoModel] {
        if searchTerm.isEmpty {
            return dinos
        }
        return dinos.filter { dino in
            dino.name.localizedCaseInsensitiveContains(searchTerm)
        }
    }
    
    func sortDinos(by alphabetical: Bool) {
        dinos.sort { dino1, dino2 in
            if alphabetical {
                return dino1.name < dino2.name
            } else {
                return dino1.id < dino2.id
            }
        }
    }
}

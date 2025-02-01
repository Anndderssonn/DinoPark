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
}

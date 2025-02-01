//
//  ContentView.swift
//  DinoPark
//
//  Created by Andersson on 31/01/25.
//

import SwiftUI

struct ContentView: View {
    let dinos = DinoDecodable()
    
    var body: some View {
        List(dinos.dinos) { dino in
            HStack {
                Image(dino.image)
                    .resizable()
                    .scaledToFit()
                    .frame(width: 100, height: 100)
                    .shadow(color: .white, radius: 2)
                VStack(alignment: .leading) {
                    Text(dino.name)
                        .fontWeight(.bold)
                    Text(dino.type.rawValue.capitalized)
                        .font(.subheadline)
                        .fontWeight(.semibold)
                        .padding(.horizontal, 13)
                        .padding(.vertical, 5)
                        .background(dino.type.backgroundColor)
                        .clipShape(.buttonBorder)
                }
            }
        }
        .preferredColorScheme(.dark)
    }
}

#Preview {
    ContentView()
}

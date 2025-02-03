//
//  ContentView.swift
//  DinoPark
//
//  Created by Andersson on 31/01/25.
//

import SwiftUI

struct ContentView: View {
    let dinos = DinoDecodable()
    @State var searchDino = ""
    var filteredDinos: [DinoModel] {
        if searchDino.isEmpty {
            return dinos.dinos
        }
        return dinos.dinos.filter { dino in
            dino.name.localizedCaseInsensitiveContains(searchDino)
        }
    }
    
    var body: some View {
        NavigationStack{
            List(filteredDinos) { dino in
                NavigationLink {
                    Image(dino.image)
                        .resizable()
                        .scaledToFit()
                } label: {
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
            }.navigationTitle("Apex Predators")
                .searchable(text: $searchDino)
                .autocorrectionDisabled()
                .animation(.default, value: searchDino)
        }.preferredColorScheme(.dark)
    }
}

#Preview {
    ContentView()
}

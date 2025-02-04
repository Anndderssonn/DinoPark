//
//  ContentView.swift
//  DinoPark
//
//  Created by Andersson on 31/01/25.
//

import SwiftUI

struct ContentView: View {
    let dinos = DinoDecodable()
    @State var searchValue = ""
    @State var alphabetical = false
    var filteredDinos: [DinoModel] {
        dinos.sortDinos(by: alphabetical)
        return dinos.searchDinos(for: searchValue)
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
                .searchable(text: $searchValue)
                .autocorrectionDisabled()
                .animation(.default, value: searchValue)
                .toolbar {
                    ToolbarItem(placement: .topBarLeading) {
                        Button {
                            withAnimation {
                                alphabetical.toggle()
                            }
                        } label: {
                            Image(systemName: alphabetical ? "film" : "textformat")
                                .foregroundStyle(Color.purple.opacity(0.8))
                                .symbolEffect(.bounce, value: alphabetical)
                        }
                    }
                }
        }.preferredColorScheme(.dark)
    }
}

#Preview {
    ContentView()
}

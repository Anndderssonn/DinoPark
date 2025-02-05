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
    @State var typeSelected = DinoType.all
    var filteredDinos: [DinoModel] {
        dinos.filterDinos(by: typeSelected)
        dinos.sortDinos(by: alphabetical)
        return dinos.searchDinos(for: searchValue)
    }
    
    var body: some View {
        NavigationStack{
            List(filteredDinos) { dino in
                NavigationLink {
                    DinoDetail(dino: dino)
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
                    ToolbarItem(placement: .topBarTrailing) {
                        Menu {
                            Picker("Filter", selection: $typeSelected.animation()) {
                                ForEach(DinoType.allCases) { type in
                                    Label(type.rawValue.capitalized, systemImage: type.icon)
                                }
                            }
                        } label : {
                            Image(systemName: "slider.horizontal.3")
                                .foregroundStyle(Color.purple.opacity(0.8))
                        }
                    }
                }
        }.preferredColorScheme(.dark)
    }
}

#Preview {
    ContentView()
}

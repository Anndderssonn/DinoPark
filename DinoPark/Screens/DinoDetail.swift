//
//  DinoDetail.swift
//  DinoPark
//
//  Created by Andersson on 4/02/25.
//

import SwiftUI

struct DinoDetail: View {
    let dino: DinoModel
    
    var body: some View {
        GeometryReader { geometry in
            ScrollView {
                ZStack(alignment: .bottomTrailing) {
                    Image(dino.type.rawValue)
                        .resizable()
                        .scaledToFit()
                    Image(dino.image)
                        .resizable()
                        .scaledToFit()
                        .frame(width: geometry.size.width/1.5, height: geometry.size.height/3.7)
                        .scaleEffect(x: -1)
                        .shadow(color: .black, radius: 7)
                        .offset(y: 20)
                }
                VStack(alignment: .leading) {
                    Text(dino.name)
                        .font(.largeTitle)
                    Text("Appears in:")
                        .font(.title3)
                        .padding(.top, 10)
                    ForEach(dino.movies, id: \.self) { movie in
                        Text("🎬 \(movie)")
                            .font(.subheadline)
                    }
                    .padding(.top, 3)
                    Text("Movie Moments")
                        .font(.title)
                        .padding(.top, 15)
                    ForEach(dino.movieScenes) { scene in
                        Text(scene.movie)
                            .font(.title2)
                            .padding(.vertical, 1)
                        Text(scene.sceneDescription)
                            .padding(.bottom, 15)
                    }
                    Text("Read More:")
                        .font(.caption)
                    Link(dino.link, destination: URL(string: dino.link)!)
                        .font(.caption)
                        .foregroundStyle(.blue)
                }
                .padding()
                .padding(.bottom)
                .frame(width: geometry.size.width, alignment: .leading)
            }
        }
        .ignoresSafeArea()
    }
}

#Preview {
    DinoDetail(dino: DinoDecodable().dinos[2])
        .preferredColorScheme(.dark)
}

//
//  DinoDetail.swift
//  DinoPark
//
//  Created by Andersson on 4/02/25.
//

import SwiftUI
import MapKit

struct DinoDetail: View {
    let dino: DinoModel
    @State var position: MapCameraPosition
    @Namespace var animation
    
    var body: some View {
        GeometryReader { geometry in
            ScrollView {
                ZStack(alignment: .bottomTrailing) {
                    Image(dino.type.rawValue)
                        .resizable()
                        .scaledToFit()
                        .overlay {
                            LinearGradient(stops: [Gradient.Stop(color: .clear, location: 0.8), Gradient.Stop(color: .black, location: 1)], startPoint: .top, endPoint: .bottom)
                        }
                    NavigationLink {
                        Image(dino.image)
                            .resizable()
                            .scaledToFit()
                    } label: {
                        Image(dino.image)
                            .resizable()
                            .scaledToFit()
                            .frame(width: geometry.size.width/1.5, height: geometry.size.height/3.7)
                            .scaleEffect(x: -1)
                            .shadow(color: .black, radius: 7)
                            .offset(y: 20)
                    }
                }
                VStack(alignment: .leading) {
                    Text(dino.name)
                        .font(.largeTitle)
                    NavigationLink {
                        DinoMap(position: .camera(MapCamera(centerCoordinate: dino.location, distance: 1000, heading: 250, pitch: 80)))
                            .navigationTransition(.zoom(sourceID: 1, in: animation))
                    } label: {
                        Map(position: $position) {
                            Annotation(dino.name, coordinate: dino.location) {
                                Image(systemName: "mappin.and.ellipse")
                                    .font(.largeTitle)
                                    .symbolEffect(.breathe)
                            }
                            .annotationTitles(.hidden)
                        }
                        .frame(height: 125)
                        .overlay(alignment: .trailing) {
                            Image(systemName: "arrow.right.circle.fill")
                                .imageScale(.large)
                                .font(.title3)
                                .padding(.trailing, 5)
                        }
                        .overlay(alignment: .topLeading) {
                            Text("Current Location")
                                .padding([.leading, .bottom], 5)
                                .padding(.trailing, 8)
                                .background(.black.opacity(0.35))
                                .clipShape(.rect(bottomTrailingRadius: 5))
                        }
                        .clipShape(.rect(cornerRadius: 5))
                    }
                    .matchedTransitionSource(id: 1, in: animation)
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
        .toolbarBackground(.automatic)
    }
}

#Preview {
    let dino = DinoDecodable().dinos[2]
    NavigationStack {
        DinoDetail(dino: dino, position: .camera(MapCamera(centerCoordinate: dino.location, distance: 30000)))
            .preferredColorScheme(.dark)
    }
}

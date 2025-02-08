//
//  DinoMap.swift
//  DinoPark
//
//  Created by Andersson on 7/02/25.
//

import SwiftUI
import MapKit

struct DinoMap: View {
    @State var position: MapCameraPosition
    @State var satellite = false
    let dinos = DinoDecodable()
    
    var body: some View {
        Map(position: $position) {
            ForEach(dinos.dinos) { dino in
                Annotation(dino.name, coordinate: dino.location) {
                    Image(dino.image)
                        .resizable()
                        .scaledToFit()
                        .frame(height: 100)
                        .shadow(color: .white, radius: 5)
                        .scaleEffect(x: -1)
                }
            }
        }
        .mapStyle(satellite ? .imagery(elevation: .realistic) : .standard(elevation: .realistic))
        .overlay(alignment: .bottomTrailing) {
            Button {
                satellite.toggle()
            } label: {
                Image(systemName: satellite ? "globe.americas.fill" : "globe.americas")
                    .font(.largeTitle)
                    .imageScale(.large)
                    .background(.ultraThinMaterial)
                    .padding()
            }
        }
        .toolbarBackground(.automatic)
    }
}

#Preview {
    DinoMap(position: .camera(MapCamera(centerCoordinate: DinoDecodable().dinos[2].location, distance: 1000, heading: 250, pitch: 80)))
        .preferredColorScheme(.dark)
}

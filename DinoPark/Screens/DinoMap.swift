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
    @State var dinoPinInfo: DinoModel?
    @State var showInfoDinoPin = false
    let dinos = DinoDecodable()
    
    var body: some View {
        ZStack {
            Map(position: $position) {
                ForEach(dinos.dinos) { dino in
                    Annotation(dino.name, coordinate: dino.location) {
                        Image(dino.image)
                            .resizable()
                            .scaledToFit()
                            .frame(height: 100)
                            .shadow(color: .white, radius: 5)
                            .scaleEffect(x: -1)
                            .onTapGesture {
                                dinoPinInfo = dino
                                showInfoDinoPin.toggle()
                            }
                            .zIndex(1)
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
            
            if showInfoDinoPin, let dino = dinoPinInfo {
                VStack {
                    Text(dino.name)
                        .font(.title2)
                        .foregroundStyle(Color.black)
                    Text("Latitude: \(dino.latitude)")
                        .font(.caption)
                        .foregroundStyle(.blue)
                    Text("Longitude: \(dino.longitude)")
                        .font(.caption)
                        .foregroundStyle(.blue)
                    Button("Close") {
                        showInfoDinoPin = false
                        dinoPinInfo = nil
                    }
                    .padding()
                    .foregroundColor(.purple)
                    .background(Color.clear)
                    .fontWeight(.bold)
                }
                .frame(width: 250, height: 150)
                .background(Color.white.opacity(0.9))
                .cornerRadius(3)
                .shadow(radius: 10)
                .position(
                    x: UIScreen.main.bounds.width / 2,
                    y: UIScreen.main.bounds.height / 3.5
                )
                .zIndex(2)
            }
        }
        .toolbarBackground(.automatic)
    }
}

#Preview {
    DinoMap(position: .camera(MapCamera(centerCoordinate: DinoDecodable().dinos[2].location, distance: 1000, heading: 250, pitch: 80)))
        .preferredColorScheme(.dark)
}

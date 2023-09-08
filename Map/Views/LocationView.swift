//
//  LocationView.swift
//  Map
//
//  Created by Amir Diafi on 7/9/23.
//

import SwiftUI
import MapKit


struct LocationView: View {
    @EnvironmentObject private var vm: LocationViewModel
    
    var body: some View {
        ZStack {
            Map(coordinateRegion: $vm.mapRegion)
                .ignoresSafeArea(.all)
            
            VStack {
                header
                    .padding()
                Spacer()
                ZStack {
                    ForEach(vm.locations) {location in
                        if vm.selectedLocation == location {
                            LocationCard(location: location)
                                .shadow(color: Color.black.opacity(0.12), radius: 30)
                                .transition(
                                    .asymmetric(
                                        insertion: .move(edge: .trailing),
                                        removal: .move(edge: .leading)
                                    )
                                )
                        }
                    }
                }
                .padding()
            }
        }
    }
}

struct LocationView_Previews: PreviewProvider {
    static var previews: some View {
        LocationView()
            .environmentObject(LocationViewModel())
    }
}

extension LocationView {
    private var header:  some View {
        VStack(spacing: 0) {
            Button {
                vm.onOpenList()
            } label: {
                Text(vm.selectedLocation.name + ", " + vm.selectedLocation.cityName)
                    .font(.title2)
                    .fontWeight(.black)
                    .foregroundColor(.primary)
                    .frame(height: 55)
                    .frame(maxWidth: .infinity)
                    .animation(.none, value: vm.selectedLocation)
                    .overlay(alignment: .leading) {
                        Image(systemName: "arrow.down")
                            .padding()
                            .font(.headline)
                            .foregroundColor(.primary)
                            .rotationEffect(Angle(degrees: vm.isShowListOpen ? 180 : 0))
                    }
            }

            if(vm.isShowListOpen) {
                PlacesList()
            }
        }
        .background(.thinMaterial)
        .cornerRadius(10)
        .shadow(color: Color.black.opacity(0.3), radius: 20, x: 20, y: 20)
    }
}

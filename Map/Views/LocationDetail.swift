//
//  LocationDetail.swift
//  Map
//
//  Created by Amir Diafi on 9/11/23.
//

import SwiftUI
import MapKit

struct LocationDetail: View {
    let location: Location
    @EnvironmentObject private var vm: LocationViewModel
    
    var body: some View {
        ScrollView {
            VStack {
                cards
                    .shadow(color: Color.black.opacity(0.3), radius: 20, x: 0, y: 10)
            }
            
            VStack(alignment: .leading, spacing: 16) {
                titleSection
                Divider()
                descriptionSection
                Divider()
                mapLayer
            }
            .frame(maxWidth: .infinity, alignment: .leading)
            .padding()
        }
        .ignoresSafeArea()
        .background(.ultraThinMaterial)
        .overlay(alignment: .topLeading) {
            Button {
                vm.sheetLocation = nil
            } label: {
                Image(systemName: "multiply")
                    .font(.headline)
                    .padding(16)
                    .background(.ultraThickMaterial)
                    .tint(Color.black)
                    .clipShape(RoundedRectangle(cornerRadius: 10))
                    .shadow(radius: 4)
                    .padding()
            }
            

        }
    }
}

struct LocationDetail_Previews: PreviewProvider {
    static var previews: some View {
        LocationDetail(location: LocationViewModel().locations.first!)
            .environmentObject(LocationViewModel())
    }
}


extension LocationDetail {
    private var cards: some View {
        TabView {
            ForEach(location.imageNames, id: \.self) {
                Image($0)
                    .resizable()
                    .scaledToFill()
                    .frame(width: UIScreen.main.bounds.width)
                    .clipped()
            }
        }
        .frame(height: 500)
        .tabViewStyle(.page)
    }
    private var titleSection: some View {
        VStack(alignment: .leading, spacing: 8)  {
            Text(location.name)
                .font(.largeTitle)
                .fontWeight(.semibold)
            Text(location.cityName)
                .font(.title3)
                .foregroundColor(.secondary)
        }
    }
    private var descriptionSection: some View {
        VStack(alignment: .leading, spacing: 16)  {
            Text(location.description)
                .font(.subheadline)
                .foregroundColor(.secondary)
            
            if let url = URL(string: location.link) {
                Link("Read more on Wikipedia", destination: url)
                    .font(.headline)
                    .tint(.blue)
            }
        }
    }
    private var mapLayer: some View {
        Map(
            coordinateRegion:
                .constant(
                    MKCoordinateRegion(
                        center: location.coordinates,
                        span: MKCoordinateSpan(
                            latitudeDelta: 0.01,
                            longitudeDelta: 0.01
                        )
                    )
                ),
            annotationItems: [location],
            annotationContent: { location in
                MapAnnotation(coordinate: location.coordinates) {
                    CustomMarker()
                        .shadow(radius: 10)
                }
            }
        )
        .aspectRatio(1, contentMode: .fit)
        .cornerRadius(30)
        .allowsHitTesting(false)
    }
}

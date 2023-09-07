//
//  LocationViewModel.swift
//  Map
//
//  Created by Amir Diafi on 7/9/23.
//

import Foundation
import SwiftUI
import MapKit

class LocationViewModel: ObservableObject {
    
    @Published var locations: [Location]
    @Published var selectedLocation: Location {
        didSet {
            onUpdateMapRegion(location: selectedLocation)
        }
    }
    @Published var mapRegion: MKCoordinateRegion = MKCoordinateRegion()
    let span = MKCoordinateSpan(latitudeDelta: 0.1, longitudeDelta: 0.1)
    @Published var isShowListOpen = false
    
    init() {
        let locations = LocationsDataService.locations
        self.locations = locations
        self.selectedLocation = locations.first!
        self.onUpdateMapRegion(location: locations.first!)
    }
    
    private func onUpdateMapRegion(location: Location) {
        withAnimation(.easeInOut) {
            mapRegion = MKCoordinateRegion(center: location.coordinates, span: span)
        }
    }
    
    func onSelectLocation(location: Location) {
        withAnimation(.easeInOut) {
            selectedLocation = location
            isShowListOpen.toggle()
        }
    }
    
    func onOpenList() {
        withAnimation(.easeInOut) {
            isShowListOpen.toggle()
        }
    }
    
}

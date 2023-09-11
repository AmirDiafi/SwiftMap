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
    @Published var sheetLocation: Location? = nil
    
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
            isShowListOpen = false
        }
    }
    
    func onOpenList() {
        withAnimation(.easeInOut) {
            isShowListOpen.toggle()
        }
    }
    
    func onNextLocation() {
        withAnimation(.easeInOut) {
            isShowListOpen = false
            guard let currentIndex = locations.firstIndex(where: {$0 == selectedLocation}) else {
                print("no index found")
                return
            }
            
            let nextIndex = currentIndex + 1
            guard locations.indices.contains(nextIndex) else {
                print("no next index found")
                self.onSelectLocation(location: locations.first!)
                return
            }

            let nextLocation = locations[nextIndex]
            self.onSelectLocation(location: nextLocation)

        }
    }
    
}

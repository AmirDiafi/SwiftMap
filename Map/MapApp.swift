//
//  MapApp.swift
//  Map
//
//  Created by Amir Diafi on 7/8/23.
//

import SwiftUI

@main
struct MapApp: App {
    @StateObject private var vm = LocationViewModel()
    var body: some Scene {
        WindowGroup {
            LocationView()
                .environmentObject(vm)
        }
    }
}

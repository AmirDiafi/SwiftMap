//
//  PlacesList.swift
//  Map
//
//  Created by Amir Diafi on 9/7/23.
//

import SwiftUI



struct PlacesList: View {
    @EnvironmentObject private var vm: LocationViewModel

    var body: some View {
        List {
            ForEach(vm.locations) { location in
                Button {
                    vm.onSelectLocation(location: location)
                } label: {
                    listRowView(location: location)
                }
                .padding(.vertical, 4)
                .listRowBackground(Color.clear)
            }
        }
        .listStyle(PlainListStyle())
    }
}

struct PlacesList_Previews: PreviewProvider {
    static var previews: some View {
        PlacesList()
    }
}

extension PlacesList {
    private func listRowView(location: Location) -> some View {
        HStack {
            if let image = location.imageNames.first {
                Image(image)
                    .resizable()
                    .scaledToFit()
                    .frame(width: 45, height: 45)
                    .cornerRadius(10)
            }
            VStack(alignment: .leading) {
                Text(location.name)
                    .font(.headline)
                Text(location.cityName)
                    .font(.subheadline)
            }
            .frame(maxWidth: .infinity, alignment: .leading)
        }
    }
}

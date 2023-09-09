//
//  LocationCard.swift
//  Map
//
//  Created by Amir Diafi on 9/8/23.
//

import SwiftUI

struct LocationCard: View {
    let location: Location
    @EnvironmentObject private var vm: LocationViewModel

    var body: some View {
        HStack(alignment: .bottom, spacing: 0) {
            VStack(alignment: .leading, spacing: 25) {
                VStack{
                    ZStack {
                        if let image = location.imageNames.first! {
                            Image(image)
                                .resizable()
                                .scaledToFit()
                                .frame(width: 100, height: 100)
                                .cornerRadius(10)
                        }
                    }
                    .padding(6)
                    .background(Color.white)
                    .cornerRadius(10)
                }
                VStack(alignment: .leading, spacing: 4) {
                    Text(location.name)
                        .font(.title)
                        .fontWeight(.bold)
                        .frame(maxWidth: .infinity, alignment: .leading)
                        
                    Text(location.cityName)
                        .font(.headline)
                        .frame(maxWidth: .infinity, alignment: .leading)
                }
                .frame(maxWidth: .infinity)
            }

            VStack {
                Button {
                    
                } label: {
                    Text("Learn more")
                        .font(.headline)
                        .frame(width: 125, height: 35)
                }
                .buttonStyle(.borderedProminent)
                
                Button {
                    vm.onNextLocation()
                } label: {
                    Text("Next")
                        .font(.headline)
                        .frame(width: 125, height: 35)
                }
                .buttonStyle(.bordered)

            }
        }
        .padding(20)
        .background(
            RoundedRectangle(cornerRadius: 20)
                .fill(.ultraThinMaterial)
                .offset(y: 65)
        )
        .clipped()
        .cornerRadius(20)
    }
}

struct LocationCard_Previews: PreviewProvider {
    static var previews: some View {
        LocationCard(location: LocationViewModel().locations.first!)
            .environmentObject(LocationViewModel())
            .padding()
    }
}

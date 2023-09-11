//
//  CustomMarker.swift
//  Map
//
//  Created by Amir Diafi on 9/10/23.
//

import SwiftUI

struct CustomMarker: View {
    var body: some View {
        VStack {
            Image(systemName: "map.circle.fill")
                .resizable()
                .scaledToFit()
                .frame(width: 30, height: 30)
                .font(.headline)
                .foregroundColor(.white)
                .padding(6)
                .background(Color.accentColor)
                .clipShape(Circle())
            Image(systemName: "triangle.fill")
                .resizable()
                .scaledToFit()
                .frame(width: 10, height: 10)
                .foregroundColor(.accentColor)
                .rotationEffect(Angle(degrees: 180))
                .offset(y: -9)
                .padding(.bottom, 40)
        }
        
    }
}

struct CustomMarker_Previews: PreviewProvider {
    static var previews: some View {
        CustomMarker()
    }
}

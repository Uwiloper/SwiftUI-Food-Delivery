//
//  BackgroundFade.swift
//  EaToo
//
//  Created by Alumno on 15/09/25.
//

import SwiftUI

struct BackgroundFade: View {
    
    var gradient = Gradient(stops: [
        .init(color: Color("BackgroundColor"), location: 0.0),
        .init(color: Color.white, location: 0.2)
    ])
    
    var body: some View {
        ZStack {
            LinearGradient(gradient: gradient,
                           startPoint: .bottom,
                           endPoint: .top)
        }.ignoresSafeArea()
    }
}

#Preview {
    BackgroundFade()
}

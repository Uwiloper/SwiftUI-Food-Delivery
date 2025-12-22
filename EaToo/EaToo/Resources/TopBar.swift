//
//  TopBar.swift
//  EaToo
//
//  Created by Alumno on 22/09/25.
//

import SwiftUI

struct TopBar: View {
    @State private var searchText = ""

    var body: some View {
        VStack(spacing: 12) {
            HStack {
                Image(systemName: "slider.horizontal.3")
                    .font(.title2)
                    .foregroundColor(.black)

                Text("home")
                    .font(.headline)
                    .fontWeight(.bold)
                    .padding(.leading, 8)

                Spacer()

                ZStack {
                    Circle()
                        .fill(Color.red)
                        .frame(width: 36, height: 36)

                    Image(systemName: "person.fill")
                        .foregroundColor(.white)
                        .font(.system(size: 18, weight: .bold))
                }
            }
        }.padding(.horizontal)
        .padding(.bottom)
    }
}


#Preview {
    TopBar()
}
